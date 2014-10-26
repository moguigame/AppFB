package
{
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import Data.Data_FriendInfo;
	import Data.Data_PlayerInfo;
	import Data.Data_RoomInfo;
	import Data.Data_SNSPlayerInfo;
	import Data.Data_TableInfo;
	import Data.Data_TablePlayerCount;
	import Data.Data_WebPrama;
	
	import Game.ClientToServerMessage;
	import Game.Game_CreateTablePID;
	import Game.Game_GameFlag;
	import Game.Game_GameRule;
	import Game.Game_JuBaoPengMoney;
	import Game.Game_MatchRoomState;
	import Game.Game_MatchTableState;
	import Game.Game_MaxMoney;
	import Game.Game_PlayerAct;
	import Game.Game_PlayerBaseInfo;
	import Game.Game_PlayerData;
	import Game.Game_PlayerDataEx;
	import Game.Game_PlayerGameInfo;
	import Game.Game_PlayerGameMoney;
	import Game.Game_PlayerGiftInfo;
	import Game.Game_PlayerGiftInfoList;
	import Game.Game_PlayerHonorInfoList;
	import Game.Game_PlayerJoinRoom;
	import Game.Game_PlayerJoinTable;
	import Game.Game_PlayerLeaveRoom;
	import Game.Game_PlayerLeaveTable;
	import Game.Game_PlayerMatchData;
	import Game.Game_PlayerMoguiMoney;
	import Game.Game_PlayerStateInfo;
	import Game.Game_PlayerStateInfoList;
	import Game.Game_ReqChangeBank;
	import Game.Game_ReqCreateTable;
	import Game.Game_ReqJoinRoom;
	import Game.Game_ReqJoinTable;
	import Game.Game_ReqPlayerGiftInfo;
	import Game.Game_ReqRoomTableInfo;
	import Game.Game_ReqSendGift;
	import Game.Game_RespChangeBank;
	import Game.Game_RespCreateTable;
	import Game.Game_RespJoinRoom;
	import Game.Game_RespJoinTable;
	import Game.Game_RespPlayerAct;
	import Game.Game_RespRoomTableInfo;
	import Game.Game_RespSendGift;
	import Game.Game_RoomInfo;
	import Game.Game_RoomInfoList;
	import Game.Game_SendGift;
	import Game.Game_ShowTable;
	import Game.Game_ShowTableList;
	import Game.Game_TableInfo;
	import Game.Game_TableInfoList;
	import Game.Game_TablePlayerCountList;
	import Game.Game_UserAwardList;
	import Game.PlayerLobbyConnect;
	import Game.RespLobbyConnect;
	import Game.ServerToClientMessage;
	import Game.msgTablePlayerCount;
	
	import L2C.L2C_TableInfo;
	import L2C.LC_Flag;
	import L2C.S2L_ClickTable;
	import L2C.S2L_DoubleClickTable;
	import L2C.S2L_Flag;
	
	import MoGui.net.CLoadResource;
	import MoGui.net.MsgData;
	import MoGui.net.MsgDataEvent;
	
	import PublicXY.BatchProtocol;
	import PublicXY.Public_XYBase;
	import PublicXY.Public_XieYiList;
	import PublicXY.ReqHeart;
	import PublicXY.ReqKey;
	import PublicXY.RespHeart;
	import PublicXY.RespKey;
	
	import UILogic.Box_PlayerInfo;
	import UILogic.Box_Shop;
	import UILogic.CCommonMatch;
	import UILogic.CJuBaoPengRule;
	import UILogic.CNoticeBoard;
	import UILogic.LobbyTopBar;
	import UILogic.MoguiViewStack;
	import UILogic.PlayerInfoBoard;
	import UILogic.UI_LobbyBack;
	import UILogic.ViewSprite;
	import UILogic.View_GuanJunMatch;
	import UILogic.View_JingBiaoMatch;
	import UILogic.View_RoomTableInfo;
	import UILogic.View_SNSPlayerInfo;
	import UILogic.View_TaoJinMatch;
	import UILogic.Window_Bank;
	import UILogic.Window_CreateTable;
	import UILogic.Window_PlayerInfo;
	import UILogic.Window_Shop;
	import UILogic.CPlayerActon;
	
	import events.ClientToLobby;
	import events.LobbyToClient;
	import events.StageToLobby;
	
	import morn.core.components.Button;
	import morn.core.components.ISelect;
	import morn.core.components.Image;
	import morn.core.components.Tab;
	import morn.core.handlers.Handler;
	
	[SWF(frameRate="24",backgroundColor="0x0a344c",width="1000",height="620")]
	public class DezhouLobby extends Sprite
	{
		//公共
		private var m_LobbyRes:CLoadResource;
		private var m_ConfigData:ConfigData;
		private var m_spLobbyBG:UI_LobbyBack;
		private var m_spLobbyBG_Mask:Sprite;
		private var m_spTitle:LobbyTopBar;
		private var m_spPlayerInfoBoard:PlayerInfoBoard;
		
		private var m_TabPlace:int;                                            //用于记录当前标签的位置
		private var m_TabFlag:int;                                             //显示的是普通还是比赛场，0普通 1比赛场
		private var m_spTabRoomInfo:Tab;
		private var m_spViewStackRoomInfo:MoguiViewStack;
		
		private var m_spTabSNS:Tab;
		private var m_spViewSNSInfo:MoguiViewStack;
		private var m_spViewFriend:View_SNSPlayerInfo;
		private var m_spViewSameCity:View_SNSPlayerInfo;
		
		private var m_spTabMatch:Tab;
		private var m_spViewMatchStack:MoguiViewStack;		
		private var m_spViewTaoJinMatch:View_TaoJinMatch;
		private var m_spViewGuanJunMatch:View_GuanJunMatch;
		private var m_spViewJingBiaoMatch:View_JingBiaoMatch;
		
		private var m_spChangeDi:CCommonMatch;                                 //比赛场和普通场的区别
		
		private var m_btnHelp:SimpleButton;
		private var m_btnAward:SimpleButton;
		private var m_btnCreateRoom:Button;
		private var m_btnEnterRoom:Button;
		private var m_btnQuickStartGame:Button;
		
		private var m_spLogo:Image;
		private var m_spNotice:CNoticeBoard;
		private var m_spJuBaoPengRule:CJuBaoPengRule;
		
		private var m_winBank:Window_Bank;
		private var m_winCreateTable:Window_CreateTable;
		private var m_winPlayerInfo:Window_PlayerInfo;
		private var m_winShop:Window_Shop;
		
		private var m_gamesocket:CGameSocket;
		
		private var m_arrayMsgToClient:Vector.<MsgData>;                       //用于存放发给游戏逻辑消息的缓存
		private var m_GameClient:DezhouGame;
		
		private var m_TimerGameTime:Timer = new Timer(20);                    //用于记录游戏的时钟	
		
		public  var m_MyData:Data_PlayerInfo;
		private var m_webPrama:Data_WebPrama;
		private var m_arrayPlayerInfo:Vector.<Data_PlayerInfo>;
		private var m_arrayRoomInfo:Vector.<Data_RoomInfo>;
		
		public function DezhouLobby()
		{
			App.init(this);
			InitDataOnce();
			this.addEventListener(Event.ADDED_TO_STAGE, OnAddToStage);
		}
		private function InitDataOnce():void
		{
			DebugLog("InitDataOnce");
			m_arrayMsgToClient = new Vector.<MsgData>();
			m_GameClient = null;
			
			m_TabPlace = 0;
			m_TabFlag = DeZhouDef.TabFlag_Common;
			m_arrayRoomInfo = new Vector.<Data_RoomInfo>();
			
			m_webPrama = new Data_WebPrama();
			m_MyData = new Data_PlayerInfo();
			m_arrayPlayerInfo = new Vector.<Data_PlayerInfo>();
			
			m_TimerGameTime.addEventListener(TimerEvent.TIMER, OnTimer);
		}
		private function OnAddToStage(evt:Event):void
		{
			DebugLog("Lobby OnAddToStage");
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.showDefaultContextMenu = false;
			stage.color = 0x777777;
			
			//背景的处理
			stage.addEventListener(Event.RESIZE,OnBackResize);
			stage.addEventListener(ClientToLobby.EVENT_ID,OnClientToLobby);
			stage.addEventListener(StageToLobby.EVENT_ID,OnStageToLobby);
			stage.addEventListener(FullScreenEvent.FULL_SCREEN,OnFullScreen);
			
			m_ConfigData = new ConfigData();
			m_ConfigData.addEventListener(Event.COMPLETE,OnConfigComplete);
			m_ConfigData.StartLoad();
			
			m_webPrama.m_AID =  1;
			m_webPrama.m_PID = stage.loaderInfo.parameters["numid"];
			//this.m_webPrama.m_LoginSession = "";
			DebugLog("AID PID",m_webPrama.m_AID,m_webPrama.m_PID );
		}
		private function OnFullScreen(evt:FullScreenEvent):void
		{
			if( evt.fullScreen )
			{
				DebugLog("全屏模式");
			}
			else
			{
				DebugLog("正常模式");
			}
		}
		private function OnBackResize(event:Event):void
		{
			DebugLog("OnBackResize Start");	
			
			DrawBackGround();
			PutObject();
		}
		private function DrawBackGround():void
		{
			DebugLog("DrawBackGround():");
		}
		private function PutObject():void
		{
			DebugLog("PutObject():");
		}
		private function DebugError(...args):void
		{
			Logger.log("Lobby ?????????????????????",args);
			trace(new Date().toLocaleTimeString(),"Lobby ?????????????????????",args);
		}
		private function DebugLog(...args):void
		{
			Logger.log("Lobby ",args);
			trace(new Date().toLocaleTimeString(),"Lobby ",args);
		}
		private function OnConfigComplete(evt:Event):void
		{
			DebugLog("OnConfigComplete");
			m_LobbyRes = new CLoadResource(m_ConfigData.m_LobbyRes,m_ConfigData.m_LobbyResVer);
			m_LobbyRes.addEventListener(Event.COMPLETE,OnLobbyResComplete);
		}
		private function OnLobbyResComplete(evt:Event):void
		{
			App.loader.loadAssets(["assets/comp.swf"],new Handler(MornLoadComplete));
		}
		private function MornLoadComplete():void
		{
			DebugLog("MornLoadComplete");
			
			var TempClass:Class;
			
			GlobleData.S_pResLobby =  m_LobbyRes;
			
			m_spLobbyBG = new UI_LobbyBack();
			addChild(m_spLobbyBG);
			
			m_spNotice = new CNoticeBoard();
			addChild(m_spNotice);
			m_spNotice.x = 10;
			m_spNotice.y = 50;
			
			m_spLogo = new Image("png.comp.Image_Logo");
			addChild(m_spLogo);
			m_spLogo.x = 15;
			m_spLogo.y = 48;
			
			m_spPlayerInfoBoard = new PlayerInfoBoard();
			addChild(m_spPlayerInfoBoard);
			m_spPlayerInfoBoard.x = 690;
			m_spPlayerInfoBoard.y = 50;	

			m_spChangeDi = new CCommonMatch();
			addChild(m_spChangeDi);
			m_spChangeDi.x = 40;
			m_spChangeDi.y = 159;
			
			var TempBack4:Image = new Image("png.comp.Image_back_yinying");
			TempBack4.sizeGrid = "10,10,10,10";
			TempBack4.x = 10;
			TempBack4.y = 200;
			TempBack4.width = 730;
			TempBack4.height = 420;
			addChild(TempBack4);
			
			var TempBack1:Image = new Image("png.comp.RoomInfo_Back1");
			TempBack1.sizeGrid = "10,10,10,10";
			TempBack1.x = TempBack4.x + 1;
			TempBack1.y = TempBack4.y + 1;
			TempBack1.width = TempBack4.width - 2;
			TempBack1.height = TempBack4.height - 4;
			addChild(TempBack1);
			
			var TempBack2:Image = new Image("png.comp.RoomInfo_Back2");
			TempBack2.sizeGrid = "10,10,10,10";
			TempBack2.x = TempBack1.x + 2;
			TempBack2.y = TempBack1.y +2;
			TempBack2.width = TempBack1.width - 4;
			TempBack2.height = TempBack1.height - 4 - 40;
			addChild(TempBack2);
			
			m_spTabRoomInfo = new Tab("","png.comp.tab_yuan");
			m_spTabRoomInfo.labelColors = "0xffffff,0xffffff,0xffffff,0xffffff";
			addChild(m_spTabRoomInfo);
			m_spTabRoomInfo.x = 25;
			m_spTabRoomInfo.y = 209;
			m_spTabRoomInfo.addEventListener(Event.SELECT,OnTabRoomSelect);
			
			m_spViewStackRoomInfo = new MoguiViewStack();
			addChild(m_spViewStackRoomInfo);
			m_spViewStackRoomInfo.x = 14;
			m_spViewStackRoomInfo.y = 242;
			
			m_spTabMatch = new Tab("","png.comp.tab_yuan");
			m_spTabMatch.labelColors = "0xffffff,0xffffff,0xffffff,0xffffff";
			//m_spTabMatch.labels = "淘金赛,冠军赛,锦标赛";
			addChild(m_spTabMatch);
			m_spTabMatch.x = 25;
			m_spTabMatch.y = 209;
			m_spTabMatch.addEventListener(Event.SELECT,OnTabMatchSelect);
			
			m_spViewMatchStack = new MoguiViewStack();
			addChild(m_spViewMatchStack);
			m_spViewMatchStack.x = 14;
			m_spViewMatchStack.y = 241;
			
			m_spViewTaoJinMatch = null;
			m_spViewGuanJunMatch = null;
			m_spViewJingBiaoMatch = null;
			
			var TempBack8:Image = new Image("png.comp.Image_back_yinying");
			TempBack8.sizeGrid = "10,10,10,10";
			TempBack8.x = 750;
			TempBack8.y = 160;
			TempBack8.width = 240;
			TempBack8.height = 460;
			addChild(TempBack8);
			
			var TempBack5:Image = new Image("png.comp.RoomInfo_Back1");
			TempBack5.sizeGrid = "10,10,10,10";
			TempBack5.x = TempBack8.x + 1;
			TempBack5.y = TempBack8.y + 1;
			TempBack5.width = TempBack8.width - 2;
			TempBack5.height = TempBack8.height - 4;
			addChild(TempBack5);
			
			var TempBack6:Image = new Image("png.comp.RoomInfo_Back2");
			TempBack6.sizeGrid = "10,10,10,10";
			TempBack6.x = TempBack5.x + 2;
			TempBack6.y = TempBack5.y + 2 + 40;
			TempBack6.width = TempBack5.width - 4;
			TempBack6.height = TempBack5.height - 4 - 40;
			addChild(TempBack6);
			
			
			m_spTabSNS = new Tab("","png.comp.tab_yuan");
			m_spTabSNS.labelColors = "0xffffff,0xffffff,0xffffff,0xffffff";
			addChild(m_spTabSNS);
			m_spTabSNS.x = 760;
			m_spTabSNS.y = 170;
			m_spTabSNS.addEventListener(Event.SELECT,OnTabSNSSelect);
			//m_spTabSNS.labels = "好友,同城";
			m_spTabSNS.labels = "好友";
			(m_spTabSNS.items[0] as Button).labelBold = true;
			(m_spTabSNS.items[0] as Button).btnLabel.alpha = 1;
			//(m_spTabSNS.items[1] as Button).labelBold = true;
			//(m_spTabSNS.items[1] as Button).btnLabel.alpha = 0.5;
			m_spTabSNS.selectedIndex = 0;
			
			m_spViewSNSInfo = new MoguiViewStack();
			addChild(m_spViewSNSInfo);
			m_spViewSNSInfo.x = 760;
			m_spViewSNSInfo.y = 205;
			
			m_spViewFriend = new View_SNSPlayerInfo();
			//m_spViewSameCity = new View_SNSPlayerInfo();
			
			m_spViewSNSInfo.addItem(m_spViewFriend);
			//m_spViewSNSInfo.addItem(m_spViewSameCity);
			
			m_btnCreateRoom = new Button("png.comp.button_yellow","创建房间");
			addChild(m_btnCreateRoom);
			m_btnCreateRoom.labelSize = 12;
			m_btnCreateRoom.labelColors = "0x401f0a";
			m_btnCreateRoom.width = 80;
			m_btnCreateRoom.height = 30;
			m_btnCreateRoom.x = 643;
			m_btnCreateRoom.y = 579;
			m_btnCreateRoom.addEventListener(MouseEvent.CLICK,OnCreateRoomClick);
			
			m_btnEnterRoom = new Button("png.comp.button_blue","进入房间");
			//addChild(m_btnEnterRoom);
			m_btnEnterRoom.width = 100;
			m_btnEnterRoom.height = 35;
			m_btnEnterRoom.x = 620;
			m_btnEnterRoom.y = 563;
			m_btnEnterRoom.addEventListener(MouseEvent.CLICK,OnEnterRoomClick);
			
			m_btnQuickStartGame = new Button("png.comp.button_green","快速开始");
			addChild(m_btnQuickStartGame);
			m_btnQuickStartGame.labelColors = "0xffffff";
			m_btnQuickStartGame.labelSize = 12;
			m_btnQuickStartGame.width = 80;
			m_btnQuickStartGame.height = 30;
			m_btnQuickStartGame.x = 550;
			m_btnQuickStartGame.y = 579;
			m_btnQuickStartGame.addEventListener(MouseEvent.CLICK,OnQuickStartClick);
			
			m_GameClient = new DezhouGame();
			m_GameClient.SetLobby(this);
			m_GameClient.SetLobbyRes(m_LobbyRes);
			m_GameClient.SetConfigData(m_ConfigData);
			addChild(m_GameClient);
			m_GameClient.x = 0;
			m_GameClient.y = PositionConfig.s_TitleHeight;
			m_GameClient.visible = false;
			
			m_spTitle = new LobbyTopBar();
			addChild(m_spTitle);
			
			m_spJuBaoPengRule = new CJuBaoPengRule();
			addChild(m_spJuBaoPengRule);
			m_spJuBaoPengRule.visible = false;
			
			m_winBank = new Window_Bank();
			addChild(m_winBank);
			m_winBank.visible = false;
			
			m_winCreateTable = new Window_CreateTable();
			addChild(m_winCreateTable);
			m_winCreateTable.visible = false;
			
			m_winPlayerInfo = new Window_PlayerInfo();
			addChild(m_winPlayerInfo);
			m_winPlayerInfo.visible = false;
			
			m_winShop = new Window_Shop();
			addChild(m_winShop);
			m_winShop.visible = false;
			
			m_TimerGameTime.start();
			ConnectToServer();			
			
			//var testBtn:Button = new Button("png.comp.button_yellow5","测试按钮");
			//testBtn.width = 300;
			//testBtn.height = 30;
			//this.addChild(testBtn);
		}
		
		private function OnAwardClick(evt:MouseEvent):void
		{
			
		}
		private function OnHelpClick(evt:MouseEvent):void
		{
			
		}
		private function OnCreateRoomClick(evt:MouseEvent):void
		{
			addChild(m_winCreateTable);
			m_winCreateTable.visible = true;
			
			m_winCreateTable.m_boxCreateTable.m_GameMoney = m_MyData.m_nGameMoney;
		}
		private function OnEnterRoomClick(evt:MouseEvent):void
		{
			
		}
		
		private function OnQuickStartClick(evt:MouseEvent):void
		{
			m_MyData.m_AutoRoomID = 0;
			if( m_MyData.m_TableID==0 && m_TabFlag==DeZhouDef.TabFlag_Common )
			{
				var retDataRI:Data_RoomInfo = null;
				for(var i:int=0;i<m_arrayRoomInfo.length;i++)
				{
					retDataRI = m_arrayRoomInfo[i] as Data_RoomInfo;
					if( retDataRI.m_Place<DeZhouDef.Place_AutoRoom 
						&& m_MyData.m_nGameMoney>=retDataRI.m_MinMoneyInRoom 
						&& m_MyData.m_nGameMoney<=retDataRI.m_MaxMoneyInRoom )
					{
						m_MyData.m_AutoRoomID = retDataRI.m_RoomID;
					}
				}
				
				if( m_MyData.m_AutoRoomID > 0 )
				{
					if( m_MyData.m_AutoRoomID == m_MyData.m_RoomID )
					{
						var TempViewRTI:View_RoomTableInfo = GetViewByRoomID(m_MyData.m_AutoRoomID) as View_RoomTableInfo;
						if( TempViewRTI != null )
						{
							var TempTableInfo:Data_TableInfo = TempViewRTI.GetAutoTable(m_MyData.m_nGameMoney);
							if( TempTableInfo != null )
							{
								m_MyData.m_AutoTableID = TempTableInfo.m_TableID;
								
								var msgRJT:Game_ReqJoinTable = new Game_ReqJoinTable();
								msgRJT.m_RoomID  = m_MyData.m_AutoRoomID;
								msgRJT.m_TableID = m_MyData.m_AutoTableID;
								this.m_gamesocket.SendMsg(msgRJT);
							}
						}
					}
					else
					{						
						var viewRI:View_RoomTableInfo =  GetViewByRoomID( m_MyData.m_AutoRoomID ) as View_RoomTableInfo;
						if( viewRI )
						{
							m_TabPlace = viewRI.m_Place;
							m_spTabRoomInfo.selectedIndex = viewRI.m_Idx;
							
							DebugLog("OnQuickStartClick RoomID Idx",m_MyData.m_AutoRoomID,viewRI.m_Idx);
						}
						else
						{
							DebugError("OnQuickStartClick Room="+m_MyData.m_AutoRoomID);
						}
					}
				}
			}
		}
		
		private function OnClientToLobby(evt:ClientToLobby):void
		{
			DebugLog("OnClientToLobby MsgID="+evt.m_msgData.m_msgID,">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
			
			var msgData:MsgData = evt.m_msgData;
			switch(msgData.m_msgID)
			{
				case LC_Flag.ID:
				{
					OnLCFlag(msgData);
				}
				break;
				default:
					DebugError("OnClientToLobby MsgID="+msgData.m_msgID+" MsgLen="+msgData.m_msgLen);
			}
		}
		
		private function OnLCFlag(msgData:MsgData):void
		{
			DebugLog("Lobby OnLCFlag");
			
			var msgFlag:LC_Flag = new LC_Flag();
			msgFlag.Read(msgData);
			
			switch(msgFlag.m_Flag)
			{
				case LC_Flag.InitClient:
				{
					DebugLog("Client Init OK");
					if( m_MyData.m_RoomID>0 && m_MyData.m_TableID>0 )
					{
						DebugLog("StartGame 之前客户端未准备好，收到客户端INIT OK消息后启动客户端");
						var TempMsgFlag:LC_Flag = new LC_Flag();
						TempMsgFlag.m_Flag = LC_Flag.StartGame;
						SendMsgToClient(TempMsgFlag);
					}
					else
					{
						if( m_arrayMsgToClient.length > 0 )
						{
							DebugLog("清理多余消息");
							m_arrayMsgToClient.length = 0;
						}
					}
				}
				break;
				case LC_Flag.ClientShow:
				{
					DebugLog("ClientShow");
				}
				break;
				case LC_Flag.ClientHide:
				{
					DebugLog("ClientHide");
				}
				break;
				case LC_Flag.GetMsg:
				{
					OnClientGetMsg();
				}
				break;
				default:
					DebugError("OnLCFlag Flag="+msgFlag.m_Flag);
			}
		}
		
		private function OnStageToLobby(evt:StageToLobby):void
		{
			DebugLog("OnStageToLobby");
			var msgData:MsgData = evt.m_msgData;
			switch(msgData.m_msgID)
			{
				case S2L_Flag.ID:
				{
					OnLobbyFlag(msgData);
				}
				break;
				case S2L_ClickTable.ID:
				{
					OnClickTableInfo(msgData);
				}
				break;
				case S2L_DoubleClickTable.ID:
				{
					OnDoubleClickTableInfo(msgData);
				}
				break;
				case Game_ReqCreateTable.ID:
				{
					OnReqCreateTable(msgData);
				}
				break;
				default:
					DebugError("OnStageToLobby MsgID="+msgData.m_msgID+" MsgLen="+msgData.m_msgLen);
			}
		}
		
		private function OnTimer(evt:TimerEvent):void
		{
			var TempTime:int = getTimer();
			var PassTime:int = 0;
			
			if( m_GameClient.visible )
			{
				m_GameClient.OnTimer(TempTime);				
			}
			m_winBank.m_boxbank.OnTime(TempTime);
			m_winCreateTable.m_boxCreateTable.OnTime(TempTime);
			m_winShop.m_boxShop.OnTime(TempTime);
		}	
		
		//供客户端调用
		public function ClientSendGameMsg(msg:Public_XYBase):void
		{
			DebugLog("ClientSendGameMsg");
			if( m_GameClient.GetClientState() == DeZhouDef.ClientState_Gamming )
			{
				m_gamesocket.SendMsg(msg);
			}
			else
			{
				DebugError("ClientSendGameMsg Name="+msg.GetClassName());
			}
		}
		//供客户端调用
		public function ClientSengLogicMsg(msg:Public_XYBase):void
		{
			DebugLog("ClientSengLogicMsg");
			if( m_GameClient.GetClientState() == DeZhouDef.ClientState_Gamming )
			{
				var msgClientToServer:ClientToServerMessage = new ClientToServerMessage();
				var msgData:MsgData = new MsgData();
				msg.Write(msgData);
				msgData.ResetDataPosition();
				
				var TempMsgLen:int = msgData.m_dataArray.bytesAvailable;
				msgClientToServer.m_MsgID  = msgData.m_msgID;
				msgClientToServer.m_MsgLen = TempMsgLen;
				msgClientToServer.m_msgData.writeBytes(msgData.m_dataArray,0,TempMsgLen);
				msgClientToServer.m_msgData.position = 0;
				m_gamesocket.SendMsg(msgClientToServer);
			}
			else
			{
				DebugError("ClientSengLogicMsg Name="+msg.GetClassName());
			}
		}
		
		private function SendMsgToClient(msg:Public_XYBase):void
		{
			if( stage != null )
			{
				var evtC2L:LobbyToClient = new LobbyToClient();
				var TempMsgData:MsgData = new MsgData();
				msg.Write(TempMsgData);
				TempMsgData.m_dataArray.position = 0;
				evtC2L.m_msgData = TempMsgData;
				stage.dispatchEvent(evtC2L);
			}
			else
			{
				this.DebugError("SendMsgToClient stage=null");
			}
		}
		private function SendMsgDataToClient(msgdata:MsgData):void
		{
			var evtC2L:LobbyToClient = new LobbyToClient();	
			msgdata.m_dataArray.position = 0;
			evtC2L.m_msgData = msgdata;
			stage.dispatchEvent(evtC2L);
		}
		//转发大厅的消息给客户端，如果准备好就走接送，否则就存起来
		private function PushMsgToClient(msgdata:MsgData):void
		{
			var nClientState:int = m_GameClient.GetClientState();
			if( nClientState == DeZhouDef.ClientState_Gamming )
			{
				SendMsgDataToClient(msgdata);
			}
			else
			{
				m_arrayMsgToClient.push(msgdata);
			}
		}
		
		private function OnClientGetMsg():void
		{
			DebugLog("OnClientGetMsg");
			var nClientState:int = m_GameClient.GetClientState();
			if( nClientState == DeZhouDef.ClientState_Gamming )
			{
				if(m_MyData.m_RoomID>0 && m_MyData.m_TableID>0)
				{
					var dataTI:Data_TableInfo = GetTableInfoByID(m_MyData.m_RoomID,m_MyData.m_TableID);
					if( dataTI != null )
					{
						var msgTI:L2C_TableInfo = new L2C_TableInfo();
						msgTI.GetData(dataTI);
						this.SendMsgToClient(msgTI);
					}
					
					for(var i:int=0;i<m_arrayMsgToClient.length;++i)
					{
						SendMsgDataToClient(m_arrayMsgToClient[i]);
					}
					m_arrayMsgToClient.length = 0;
				}
				else
				{
					DebugLog("OnClientGetMsg RoomID="+m_MyData.m_RoomID+" TableID="+m_MyData.m_TableID);
				}
			}
			else
			{
				DebugLog("OnClientGetMsg ClientState="+nClientState);
			}
		}
		
		
		private function OnTabSNSSelect(evt:Event):void
		{
			DebugLog("OnTabSNSSelect");
			if( m_spTabSNS.visible == false )
			{
				DebugError("OnTabSNSSelect");
			}
			
			m_spViewSNSInfo.selectedIndex = m_spTabSNS.selectedIndex;
			
			if( m_spTabSNS.selectedIndex == 0 )
			{
				(m_spTabSNS.items[0] as Button).btnLabel.alpha = 1;
				(m_spTabSNS.items[1] as Button).btnLabel.alpha = 0.5;
			}
			else 
			{
				(m_spTabSNS.items[0] as Button).btnLabel.alpha = 0.5;
				(m_spTabSNS.items[1] as Button).btnLabel.alpha = 1;
			}
		}
		
		private function OnTabMatchSelect(evt:Event):void
		{
			DebugLog("OnTabMatchSelect");
			if( m_spTabMatch.visible == false ) DebugError("OnTabMatchSelect",m_TabFlag);
			
			m_spViewMatchStack.selectedIndex = m_spTabMatch.selectedIndex;
			
			var TempBtnArray:Vector.<ISelect> = m_spTabMatch.items;
			for each(var TempBtn:ISelect in TempBtnArray )
			{
				(TempBtn as Button).btnLabel.alpha = 0.5;
			}
			(m_spTabMatch.selection as Button).btnLabel.alpha = 1;
			
			m_TabPlace = (m_spViewMatchStack.selection as ViewSprite).m_Place;
			if( m_TabPlace == DeZhouDef.Place_TaoJingMatch )
			{
				if( m_spViewTaoJinMatch!=null )
				{
					if( m_spViewTaoJinMatch.m_HaveTableInfo==0 )
					{
						var msgReqRTI:Game_ReqRoomTableInfo = new Game_ReqRoomTableInfo();
						msgReqRTI.m_RoomID = m_spViewTaoJinMatch.m_RoomID;
						m_gamesocket.SendMsg(msgReqRTI);
					}
					
					if( m_MyData.m_RoomID != m_spViewTaoJinMatch.m_RoomID )
					{
						var msgMatchJR:Game_ReqJoinRoom = new Game_ReqJoinRoom();
						msgMatchJR.m_RoomID = m_spViewTaoJinMatch.m_RoomID;
						m_gamesocket.SendMsg(msgMatchJR);
					}
				}
				else
				{
					this.DebugError("OnTabMatchSelect m_spViewTaoJinMatch==null");
				}
			}
		}
		private function OnTabRoomSelect(evt:Event):void
		{
			DebugLog("OnTabRoomSelect");
			if( m_spTabRoomInfo.visible == false ) DebugError("OnTabRoomSelect",m_TabFlag);
			
			m_spViewStackRoomInfo.selectedIndex = m_spTabRoomInfo.selectedIndex;
			
			var TempBtnArray:Vector.<ISelect> = m_spTabRoomInfo.items;
			for each(var TempBtn:ISelect in TempBtnArray )
			{				
				(TempBtn as Button).btnLabel.alpha = 0.5;
			}			
			(m_spTabRoomInfo.selection as Button).btnLabel.alpha = 1;
			
			if( m_TabFlag == DeZhouDef.TabFlag_Common )
			{
				var TempViewRI:View_RoomTableInfo = m_spViewStackRoomInfo.selection as View_RoomTableInfo;
				m_TabPlace = TempViewRI.m_Place;
				if( TempViewRI.m_HaveTableInfo == 0 )
				{
					DebugLog("ROOMID="+TempViewRI.m_RoomID);
					var msgReqRTI:Game_ReqRoomTableInfo = new Game_ReqRoomTableInfo();
					msgReqRTI.m_RoomID = TempViewRI.m_RoomID;
					m_gamesocket.SendMsg(msgReqRTI);
				}
				
				if( m_MyData.m_RoomID != TempViewRI.m_RoomID )
				{
					var msgReqJR:Game_ReqJoinRoom = new Game_ReqJoinRoom();
					msgReqJR.m_RoomID = TempViewRI.m_RoomID;
					m_gamesocket.SendMsg(msgReqJR);
				}				
			}
		}
		
		private function OnLobbyFlag(msgData:MsgData):void
		{
			var msgFlag:S2L_Flag = new S2L_Flag();
			msgFlag.Read(msgData);
			
			switch( msgFlag.m_Flag )
			{
				case S2L_Flag.ChangDi:
				{
					if( msgFlag.m_Value == CCommonMatch.CommonState )
					{
						m_TabFlag = DeZhouDef.TabFlag_Common;
						
						m_spTabRoomInfo.visible = true;
						m_spViewStackRoomInfo.visible = true;
						m_btnQuickStartGame.visible = true;
						m_btnCreateRoom.visible = true;
						
						m_spTabMatch.visible = false;
						m_spViewMatchStack.visible = false;
						
						var TempViewRI:View_RoomTableInfo = m_spViewStackRoomInfo.selection as View_RoomTableInfo;
						m_TabPlace = TempViewRI.m_Place;
						if( TempViewRI.m_HaveTableInfo == 0 )
						{
							DebugLog("ROOMID="+TempViewRI.m_RoomID);
							var msgReqRTI:Game_ReqRoomTableInfo = new Game_ReqRoomTableInfo();
							msgReqRTI.m_RoomID = TempViewRI.m_RoomID;
							m_gamesocket.SendMsg(msgReqRTI);
						}
						
						if( m_MyData.m_RoomID != TempViewRI.m_RoomID )
						{
							var msgReqJR:Game_ReqJoinRoom = new Game_ReqJoinRoom();
							msgReqJR.m_RoomID = TempViewRI.m_RoomID;
							m_gamesocket.SendMsg(msgReqJR);
						}						
					}
					else if( msgFlag.m_Value == CCommonMatch.MatchState )
					{
						m_TabFlag = DeZhouDef.TabFlag_Match;
						
						m_spTabRoomInfo.visible = false;
						m_spViewStackRoomInfo.visible = false;
						m_btnQuickStartGame.visible = false;
						m_btnCreateRoom.visible = false;
						
						m_spTabMatch.visible = true;
						m_spViewMatchStack.visible = true;
						
						m_TabPlace = (m_spViewMatchStack.selection as ViewSprite).m_Place;
						if( m_TabPlace == DeZhouDef.Place_TaoJingMatch )
						{
							if( m_spViewTaoJinMatch != null )
							{
								if( m_spViewTaoJinMatch.m_HaveTableInfo == 0 )
								{
									var msgMatchReqRTI:Game_ReqRoomTableInfo = new Game_ReqRoomTableInfo();
									msgMatchReqRTI.m_RoomID = m_spViewTaoJinMatch.m_RoomID;
									m_gamesocket.SendMsg(msgMatchReqRTI);
								}
								
								if( m_MyData.m_RoomID != m_spViewTaoJinMatch.m_RoomID )
								{
									var msgMatchJR:Game_ReqJoinRoom = new Game_ReqJoinRoom();
									msgMatchJR.m_RoomID = m_spViewTaoJinMatch.m_RoomID;
									m_gamesocket.SendMsg(msgMatchJR);
								}
							}
							else
							{
								this.DebugError("OnLobbyFlag m_spViewTaoJinMatch == null");
							}
						}						
					}
				}
				break;
				case S2L_Flag.BTN_JuBaoPengClick:
				{
					var DesX:int;
					var DesY:int;
					if( msgFlag.m_Value == CJuBaoPengRule.OPEN )
					{
						if( m_spJuBaoPengRule.visible == false )
						{
							m_spJuBaoPengRule.x = PositionConfig.s_LobbyWidth/2;
							m_spJuBaoPengRule.y = 5;
							DesX = (PositionConfig.s_LobbyWidth-560)/2;
							DesY = (PositionConfig.s_LobbyHeight-450)/2;
							m_spJuBaoPengRule.MoveToPointByTime(new Point(DesX,DesY),0.2);
							
							m_spJuBaoPengRule.scaleX = 0.01;
							m_spJuBaoPengRule.scaleY = 0.01;
							m_spJuBaoPengRule.ScaleByTime(1,1,0.2);
							
							m_spJuBaoPengRule.visible = true;
						}
					}
					else if( msgFlag.m_Value == CJuBaoPengRule.CLOSE )
					{
						if( m_spJuBaoPengRule.visible )
						{
							DesX = PositionConfig.s_LobbyWidth/2;
							DesY = 5;
							m_spJuBaoPengRule.MoveToPointByTime(new Point(DesX,DesY),0.2);
							
							m_spJuBaoPengRule.ScaleByTime(0.01,0.01,0.2);
							m_spJuBaoPengRule.HideByTime(0.2);
						}
					}
				}
				break;
				case S2L_Flag.Shop:
				{
					var msgGameSG:Game_ReqSendGift = new Game_ReqSendGift();
					if( msgFlag.m_Value == Box_Shop.E_Close ){
						m_winShop.visible = false;
					}
					else if( msgFlag.m_Value == Box_Shop.E_BuySelf ){
						msgGameSG.m_GiftID  = m_winShop.m_boxShop.m_nSelectID;
						msgGameSG.m_SendPID = GlobleData.s_MyPID;
						msgGameSG.m_arrayRecvPID.push(int(msgFlag.m_msgString));
						m_gamesocket.SendMsg(msgGameSG);
					}
					else if( msgFlag.m_Value == Box_Shop.E_BuyFriend ){
						msgGameSG.m_GiftID  = m_winShop.m_boxShop.m_nSelectID;
						msgGameSG.m_SendPID = GlobleData.s_MyPID;
						msgGameSG.m_arrayRecvPID.push(int(msgFlag.m_msgString));
						m_gamesocket.SendMsg(msgGameSG);
					}
				}
				break;
				case S2L_Flag.Title:
				{
					var nFlag:int = msgFlag.m_Value;
					if( nFlag == LobbyTopBar.E_Shop ){
						addChild(m_winShop);
						m_winShop.visible = true;
						m_winShop.m_boxShop.Show(GlobleData.m_BasePrice,Box_Shop.ShopType_MySelf);
					}
					else if( nFlag == LobbyTopBar::E_ChongZhi ){
						
					}					
				}
				break;
				case S2L_Flag.PlayerAction:
				{
					var nActionFlag:int = msgFlag.m_Value;
					var nActionPID:int  = int(msgFlag.m_msgString);
					if( nActionFlag == CPlayerActon.E_TailInfo ){
						var curPI:Data_PlayerInfo = null;
						if( nActionPID == m_MyData.m_PID ){
							curPI = m_MyData;
						}
						else{
							var TempPI:Data_PlayerInfo = GlobleData.GetPlayerInfoByPID(nActionPID);							
							if( TempPI == null ){
								TempPI = new Data_PlayerInfo();
								GlobleData.s_arrayPlayerInfo.push(TempPI);
							}
							curPI = TempPI;
						}
						if( curPI ){
							addChild(m_winPlayerInfo);
							m_winPlayerInfo.visible = true;
							m_winPlayerInfo.m_boxInfo.Show(curPI);
						}
					}
					else if( nActionFlag == CPlayerActon.E_SendGift ){
						addChild(m_winShop);
						m_winShop.visible = true;
						m_winShop.m_boxShop.Show(GlobleData.m_BasePrice,Box_Shop.ShopType_Player);
					}
					else if( nActionFlag == CPlayerActon.E_AddFriend ){
						
					}
				}
				break;
				case S2L_Flag.Bank_Close:
					m_winBank.visible = false;
					break;
				case S2L_Flag.Bank_In:
					if( msgFlag.m_Value <= m_MyData.m_nGameMoney )
					{
						var msgCB:Game_ReqChangeBank = new Game_ReqChangeBank();
						msgCB.m_Flag        = Game_ReqChangeBank.GameToBank;
						msgCB.m_PID         = m_MyData.m_PID;
						msgCB.m_nChangMoney = msgFlag.m_Value;
						m_gamesocket.SendMsg(msgCB);
					}
					break;
				case S2L_Flag.Bank_Out:
					if( msgFlag.m_Value <= m_MyData.m_nBankMoney )
					{
						var msgB2G:Game_ReqChangeBank = new Game_ReqChangeBank();
						msgB2G.m_Flag        = Game_ReqChangeBank.BankToGame;
						msgB2G.m_PID         = m_MyData.m_PID;
						msgB2G.m_nChangMoney = msgFlag.m_Value;
						m_gamesocket.SendMsg(msgB2G);
					}
					break;
				case S2L_Flag.BTN_BANK:
					OnBtnBank();
					break;
				case S2L_Flag.BTN_ZILIAO:
					addChild(m_winPlayerInfo);
					m_winPlayerInfo.visible = true;
					m_winPlayerInfo.m_boxInfo.Show(m_MyData);
					if( m_MyData.m_arrayCurGift.length + m_MyData.m_arrayPassGift.length == 0 )
					{
						var msgReqGift:Game_ReqPlayerGiftInfo = new Game_ReqPlayerGiftInfo();
						msgReqGift.m_PID = m_MyData.m_PID;
						m_gamesocket.SendMsg(msgReqGift);
					}
					break;
				case S2L_Flag.CreateTable_Close:
					m_winCreateTable.visible = false;
					break;
				case S2L_Flag.PlayerInfo:
				{
					var nValue:int = msgFlag.m_Value;
					if( nValue == Box_PlayerInfo.BTN_CLOSE ){
						m_winPlayerInfo.visible = false;
					}
					else if( nValue == Box_PlayerInfo.BTN_SENDGIFT ){
						addChild(m_winShop);
						m_winShop.visible = true;
						m_winShop.m_boxShop.Show(GlobleData.m_BasePrice,Box_Shop.ShopType_Friend);
						
						var nRecvPID:int = int(msgFlag.m_msgString);
						m_winShop.m_boxShop.m_PIDSendFriend = nRecvPID;
					}
				}
				break;
				default:
					this.DebugError("OnLobbyFlag Flag="+msgFlag.m_Flag );
			}
		}
		private function OnBtnBank():void
		{
			addChild(m_winBank);
			m_winBank.visible = true;
			m_winBank.m_boxbank.Show(m_MyData.m_nGameMoney,m_MyData.m_nBankMoney);
		}
		private function OnClickTableInfo(msgData:MsgData):void
		{
			DebugLog("OnClickTableInfo");
			
			var msgCT:S2L_ClickTable = new S2L_ClickTable();
			msgCT.Read(msgData);
		}
		private function OnDoubleClickTableInfo(msgData:MsgData):void
		{
			DebugLog("OnDoubleClickTableInfo");
			
			var msgDCT:S2L_DoubleClickTable = new S2L_DoubleClickTable();
			msgDCT.Read(msgData);
			
			DebugLog("OnDoubleClickTableInfo RoomID="+msgDCT.m_RoomID+" TableID="+msgDCT.m_TableID);
			
			if( msgDCT.m_Place == m_TabPlace )
			{
				if( msgDCT.m_RoomID == m_MyData.m_RoomID )
				{
					var msgRJT:Game_ReqJoinTable = new Game_ReqJoinTable();
					msgRJT.m_RoomID = msgDCT.m_RoomID;
					msgRJT.m_TableID = msgDCT.m_TableID;
					this.m_gamesocket.SendMsg(msgRJT);
				}
				else
				{
					DebugError("OnDoubleClickTableInfo ",msgDCT.m_RoomID,m_MyData.m_RoomID);
				}
			}
			else
			{
				DebugError("OnDoubleClickTableInfo evtPlace="+msgDCT.m_Place+" place="+m_TabPlace);
			}
		}
		private function OnReqCreateTable(msgData:MsgData):void
		{
			DebugLog("OnReqCreateTable");
			
			var msgCT:Game_ReqCreateTable = new Game_ReqCreateTable();
			msgCT.Read(msgData);
			
			msgCT.m_FoundPID = m_MyData.m_PID;
			m_gamesocket.SendMsg(msgCT);
		}
		private function GetRoomInfoByID(roomid:int):Data_RoomInfo
		{
			var retDataRI:Data_RoomInfo = null;
			for(var i:int=0;i<m_arrayRoomInfo.length;i++)
			{
				if( (m_arrayRoomInfo[i] as Data_RoomInfo).m_RoomID == roomid )
				{
					retDataRI = m_arrayRoomInfo[i];
					break;
				}
			}
			if( retDataRI == null )
			{
				DebugError("GetRoomInfoByID",roomid);
			}
			return retDataRI;
		}
		
		private function GetTableInfoByID(roomid:int,tableid:int):Data_TableInfo
		{
			var retDataTI:Data_TableInfo = null;
			var TempRI:Data_RoomInfo = GetRoomInfoByID(roomid);
			if( TempRI != null )
			{
				if( TempRI.m_Place < DeZhouDef.Place_TopCommon )
				{
					var ViewRTI:View_RoomTableInfo = GetViewByRoomID(roomid) as View_RoomTableInfo;
					retDataTI = ViewRTI.GetTableInfo(tableid);
					if( retDataTI == null )
					{
						DebugError("GetTableInfoByID",roomid,tableid);
					}
				}
				else if( TempRI.m_Place == DeZhouDef.Place_TaoJingMatch )
				{
					retDataTI = m_spViewTaoJinMatch.GetTableInfo(tableid);
					if( retDataTI == null )
					{
						DebugError("GetTableInfoByID Place_TaoJingMatch",roomid,tableid);
					}
				}
				else
				{
					DebugError("GetTableInfoByID Place RoomID,TableID",roomid,tableid);
				}
			}
			else
			{
				DebugError("GetTableInfoByID",roomid);
			}
			
			return retDataTI;
		}
		
		private function GetMatchViewByPlace(nPlace:int):Sprite
		{
			var TempVS:Vector.<DisplayObject> = m_spViewMatchStack.items;
			for(var i:int=0;i<TempVS.length;++i)
			{
				if( (TempVS[i] as ViewSprite).m_Place == nPlace )
				{
					return TempVS[i];
				}
			}
			return null;
		}
		private function GetViewByRoomID(roomid):Sprite
		{
			var dataRI:Data_RoomInfo = GetRoomInfoByID(roomid);
			if( dataRI != null )
			{
				if( dataRI.m_Place < DeZhouDef.Place_TopCommon ) //说明是普通场
				{
					var TempVS:Vector.<DisplayObject> = m_spViewStackRoomInfo.items;
					for(var i:int=0;i<TempVS.length;++i)
					{
						if( (TempVS[i] as View_RoomTableInfo).m_Place == dataRI.m_Place )
						{
							return TempVS[i];
						}
					}
				}
			}
			DebugError("GetViewByRoomID",roomid);
			return null;
		}
		
		private function ConnectToServer():void
		{
			m_gamesocket = new CGameSocket();
			m_gamesocket.Connect(m_ConfigData.m_ServerIP,m_ConfigData.m_ServerPort);
			//m_gamesocket.Connect("127.0.0.1",5546);
			//m_gamesocket.Connect("218.108.131.23",5546);
			
			m_gamesocket.addEventListener(MsgDataEvent.EVENT_ID,OnGameSocketMsg);
			m_gamesocket.addEventListener(Event.CONNECT,OnGameSocketConnect);
			m_gamesocket.addEventListener(Event.CLOSE,OnGameSocketClose);
			
			m_gamesocket.addEventListener(ErrorEvent.ERROR,OnGameSocketError);
			m_gamesocket.addEventListener(IOErrorEvent.IO_ERROR,OnGameSocketIOError);
			m_gamesocket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,OnGameSocketSecurityError);
		}
		
		private function OnGameSocketError(evt:ErrorEvent):void
		{
			DebugLog("OnGameSocketError ErrorEvent");
		}
		private function OnGameSocketIOError(evt:IOErrorEvent):void
		{
			DebugLog("OnGameSocketIOError IOErrorEvent");
		}
		private function OnGameSocketSecurityError(evt:SecurityErrorEvent):void
		{
			DebugLog("OnGameSocketSecurityError SecurityErrorEvent");
		}
		
		private function OnGameSocketClose(evt:Event):void
		{
			DebugLog("OnGameSocketClose Event");
		}
		
		private function OnGameSocketConnect(evt:Event):void
		{
			DebugLog("OnConnect");
			
			var msgReqKey:ReqKey = new ReqKey();
			m_gamesocket.SendMsg(msgReqKey);
		}
		
		private function OnGameSocketMsg(evt:MsgDataEvent):void
		{
			var msgData:MsgData = evt.m_msgData;
			trace("OnMsg msgID=" + msgData.m_msgID + " Len=" + msgData.m_msgLen);
			DebugLog("OnMsg msgID=" + msgData.m_msgID + " Len=" + msgData.m_msgLen);
			
			switch( msgData.m_msgID )
			{
				case RespKey.ID:
				{
					OnRespKey(msgData);
				}
				break;
				case RespHeart.ID:
				{
					OnRespHeart(msgData);
				}
				break;
				case BatchProtocol.ID:
				{
					OnBatchProtocol(msgData);
				}
				break;
				case Public_XieYiList.ID:
				{
					OnXieYiList(msgData);
				}
				break;
				case RespLobbyConnect.ID:
				{
					OnRespLobbyConnect(msgData);
				}
				break;
				case Game_GameRule.ID:
				{
					OnGameRule(msgData);
				}
				break;
				case Game_GameFlag.ID:
				{
					OnGameFlag(msgData);
				}
				break;
				case Game_JuBaoPengMoney.ID:
				{
					OnJuBaoPengMoney(msgData);
				}
				break;
				case Game_RoomInfo.ID:
				{
					OnRoomInfo(msgData);
				}
				break;
				case Game_RoomInfoList.ID:
				{
					OnRoomInfoList(msgData);
				}
				break;
				case Game_PlayerData.ID:
				{
					OnPlayerData(msgData);
				}
				break;
				case Game_PlayerDataEx.ID:
				{
					OnPlayerDataEx(msgData);
				}
				break;
				case Game_PlayerMatchData.ID:
				{
					OnPlayerMatchData(msgData);
				}
				break;
				case Game_PlayerBaseInfo.ID:
				{
					OnPlayerBaseInfo(msgData);
				}					
				break;
				case Game_PlayerGameInfo.ID:
				{
					OnPlayerGameInfo(msgData);
				}
				break;
				case Game_PlayerStateInfo.ID:
				{
					OnPlayerStateInfo(msgData);
				}
				break;
				case Game_PlayerStateInfoList.ID:
				{
					OnPlayerStateInfoList(msgData);
				}
				break;
				case Game_PlayerGameMoney.ID:
				{
					OnPlayerGameMoney(msgData);
				}
				break;
				case Game_PlayerMoguiMoney.ID:
				{
					OnPlayerMoguiMoney(msgData);
				}
				break;
				case Game_PlayerHonorInfoList.ID:
				{
					OnPlayerHonorInfoList(msgData);
				}
				break;
				case Game_RespSendGift.ID:
				{
					OnRespSendGift(msgData);
				}
				break;
				case Game_SendGift.ID:
				{
					OnSendGift(msgData);
				}
				break;
				case Game_PlayerGiftInfo.ID:
				{
					OnPlayerGiftInfo(msgData);
				}
				break;
				case Game_PlayerGiftInfoList.ID:
				{
					OnPlayerGiftInfoList(msgData);
				}
				break;				
				case Game_TableInfoList.ID:
				{
					OnTableInfoList(msgData);
				}
				break;
				case Game_TableInfo.ID:
				{
					OnTableInfo(msgData);
				}
				break;
				case Game_ShowTable.ID:
				{
					OnShowTable(msgData);
				}
				break;
				case Game_ShowTableList.ID:
				{
					OnShowTableList(msgData);
				}
				break
				case Game_UserAwardList.ID:
				{
					OnUserAwardList(msgData);
				}
				break;
				case Game_MaxMoney.ID:
				{
					OnMaxMoney(msgData);
				}
				break;
				case Game_RespJoinRoom.ID:
				{
					OnRespJoinRoom(msgData);
				}
				break;
				case Game_RespJoinTable.ID:
				{
					OnRespJoinTable(msgData);
				}
				break;
				case Game_RespRoomTableInfo.ID:
				{
					OnRespRoomTableInfo(msgData);
				}
				break;
				case Game_PlayerJoinRoom.ID:
				{
					OnPlayerJoinRoom(msgData);
				}
				break;
				case Game_PlayerLeaveRoom.ID:
				{
					OnPlayerLeaveRoom(msgData);
				}
				break;
				case Game_PlayerJoinTable.ID:
				{
					OnPlayerJoinTable(msgData);
				}
				break;
				case Game_PlayerLeaveTable.ID:
				{
					OnPlayerLeaveTable(msgData);
				}
				break;
				case Game_TablePlayerCountList.ID:
				{
					OnTablePlayerCountList(msgData);
				}
				break;
				case Game_CreateTablePID.ID:
				{
					OnCreateTablePID(msgData);
				}
				break;
				case Game_RespChangeBank.ID:
				{
					OnBankChange(msgData);
				}
				break;
				case Game_RespCreateTable.ID:
				{
					OnRespCreateTable(msgData);
				}
				break;
				case Game_MatchTableState.ID:
				{
					OnMatchTableState(msgData);
				}
				break;
				case Game_MatchRoomState.ID:
				{
					OnMatchRoomState(msgData);
				}
				break;
				//下面是转给客户端处理的消息
				case Game_RespPlayerAct.ID:			
				case Game_PlayerAct.ID:
				{
					SendMsgDataToClient(msgData);
				}
				break;
				case ServerToClientMessage.ID:
				{
					OnServerToClient(msgData);
				}
				break;
				default:
					DebugLog("没处理协议 msgID=" + msgData.m_msgID + " Len=" + msgData.m_msgLen);
			}
			
			//m_gamesocket.PrintRecvSend();
		}
		
		private function OnMatchTableState(msgData:MsgData):void
		{
			//DebugLog("OnMatchTableState");
			
			var msgMTS:Game_MatchTableState = new Game_MatchTableState();
			msgMTS.Read(msgData);
			
			var TempRI:Data_RoomInfo = GetRoomInfoByID(msgMTS.m_RoomID);
			if( TempRI != null )
			{
				if( TempRI.m_Place==m_spViewTaoJinMatch.m_Place && m_spViewTaoJinMatch!=null )
				{
					m_spViewTaoJinMatch.UpdateMatchState(msgMTS);					
				}
			}
		}
		private function OnMatchRoomState(msgData:MsgData):void
		{
			DebugLog("OnMatchRoomState");
			
			var msgMRS:Game_MatchRoomState = new Game_MatchRoomState();
			msgMRS.Read(msgData);
			
			var TempRI:Data_RoomInfo = GetRoomInfoByID(msgMRS.m_RoomID);
			if( TempRI != null )
			{
				if( TempRI.m_Place == DeZhouDef.Place_GuanJunMatch )
				{
					
				}
				else if( TempRI.m_Place == DeZhouDef.Place_JingBiaoMatch )
				{
				}
				else
				{
					DebugError("OnMatchRoomState Place",TempRI.m_Place);
				}
			}
		}
		
		private function OnServerToClient(msgData:MsgData):void
		{
			var msgSTCM:ServerToClientMessage = new ServerToClientMessage();
			msgSTCM.Read(msgData);
			
			DebugLog("ServerToClientMessage MsgID="+msgSTCM.m_MsgID+" MsgLen="+msgSTCM.m_MsgLen);
			
			this.PushMsgToClient(msgData);
		}
		
		private function OnBankChange(msgData:MsgData):void
		{			
			var msgCB:Game_RespChangeBank = new Game_RespChangeBank();
			msgCB.Read(msgData);
			
			DebugLog("OnBankChange changmoney="+msgCB.m_nChangeMoney+" gamemoney="+msgCB.m_nGameMoney+" bankmoney="+msgCB.m_nBankMoney );
			
			if( msgCB.m_Flag == Game_RespChangeBank.SUCCESS )
			{
				m_MyData.m_nGameMoney    = msgCB.m_nGameMoney;
				m_MyData.m_nBankMoney    = msgCB.m_nBankMoney;
				
				if( m_winBank.visible )
				{
					m_winBank.m_boxbank.OnBankChange(msgCB);
				}
			}			
		}
		private function OnRespCreateTable(msgData:MsgData):void
		{
			var msgCT:Game_RespCreateTable = new Game_RespCreateTable();
			msgCT.Read(msgData);
			
			if( msgCT.m_Flag == Game_RespCreateTable.SUCCESS )
			{				
				if( m_winCreateTable.visible )
				{
					m_winCreateTable.visible = false;
					if( m_TabFlag==DeZhouDef.TabFlag_Common )
					{
						var retDataRI:Data_RoomInfo = null;
						for(var i:int=0;i<m_arrayRoomInfo.length;i++)
						{
							retDataRI = m_arrayRoomInfo[i] as Data_RoomInfo;
							if( retDataRI.m_Place==DeZhouDef.Place_Private && retDataRI.m_RoomID!=m_MyData.m_RoomID )
							{
								var viewRI:View_RoomTableInfo =  GetViewByRoomID( retDataRI.m_RoomID ) as View_RoomTableInfo;
								if( viewRI )
								{
									m_TabPlace = viewRI.m_Place;
									m_spTabRoomInfo.selectedIndex = viewRI.m_Idx;
								}
								else
								{
									DebugError("OnRespCreateTable Room="+retDataRI.m_RoomID);
								}
							}
						}
					}
				}
			}
			else
			{
				if( msgCT.m_Flag == Game_RespCreateTable.NOMONEY )
				{						
					m_winCreateTable.m_boxCreateTable.m_TiShi.m_tTishi.SetText("你的游戏币不够创当前房间");					
				}
				else
				{
					m_winCreateTable.m_boxCreateTable.m_TiShi.m_tTishi.SetText("游戏房间创建失败");
				}
				m_winCreateTable.m_boxCreateTable.m_TiShi.ShowTime(3000);
			}
		}
		
		private function OnCreateTablePID(msgData:MsgData):void
		{
			//DebugLog("OnCreateTablePID msgLen="+msgData.m_msgLen,msgData.m_dataArray.length);
			
			var msgCTP:Game_CreateTablePID = new Game_CreateTablePID();
			msgCTP.Read(msgData);
			
			var retDataTI:Data_TableInfo = null;
			var TempRI:Data_RoomInfo = GetRoomInfoByID(msgCTP.m_RoomID);
			if( TempRI != null )
			{
				if( TempRI.m_Private == 0 )
				{
					DebugError("OnCreateTablePID Private",msgCTP.m_RoomID);
				}
				if( TempRI.m_Place < DeZhouDef.Place_TopCommon )
				{
					var ViewRTI:View_RoomTableInfo = GetViewByRoomID(msgCTP.m_RoomID) as View_RoomTableInfo;
					retDataTI = ViewRTI.GetTableInfo(msgCTP.m_TableID);
					if( retDataTI == null )
					{
						DebugError("OnCreateTablePID GetTableID",msgCTP.m_RoomID,msgCTP.m_TableID);
					}
					else
					{
						retDataTI.m_CreatePID = msgCTP.m_PID;
						ViewRTI.UpdateAllTable();
					}
				}
			}
			else
			{
				DebugError("OnCreateTablePID RoomID",msgCTP.m_RoomID);
			}
		}
		
		private function OnTablePlayerCountList(msgData:MsgData):void
		{
			var msgTPCL:Game_TablePlayerCountList = new Game_TablePlayerCountList();
			msgTPCL.Read(msgData);
			
			//trace("OnTablePlayerCountList RoomID="+msgTPCL.m_RoomID);
			
			var TempDataRoomInfo:Data_RoomInfo = this.GetRoomInfoByID(msgTPCL.m_RoomID);
			if( TempDataRoomInfo != null )
			{
				if( TempDataRoomInfo.m_Place < DeZhouDef.Place_TopCommon )
				{
					var TempViewRTI:View_RoomTableInfo = GetViewByRoomID(msgTPCL.m_RoomID) as View_RoomTableInfo;
					if( TempViewRTI != null )
					{
						for(var i:int=0;i<msgTPCL.m_listTablePC.length;++i)
						{
							var TempMsgPC:msgTablePlayerCount = msgTPCL.m_listTablePC[i] as msgTablePlayerCount;
							var TempPC:Data_TablePlayerCount = new Data_TablePlayerCount();
							TempPC.m_RoomID = msgTPCL.m_RoomID;
							TempPC.m_TableID = TempMsgPC.m_TableID;
							TempPC.m_SitPlayer = TempMsgPC.m_nPlayingPlayerCount;
							TempPC.m_SeePlayer = TempMsgPC.m_nSeeingPlayerCount;
							TempViewRTI.UpdatePlayerCount(TempPC);
						}
					}
				}
				else if( TempDataRoomInfo.m_Place == DeZhouDef.Place_TaoJingMatch )
				{
					if( m_spViewTaoJinMatch != null )
					{
						for(i=0;i<msgTPCL.m_listTablePC.length;++i)
						{
							var msgMatchPC:msgTablePlayerCount = msgTPCL.m_listTablePC[i] as msgTablePlayerCount;
							var dataMatchPC:Data_TablePlayerCount = new Data_TablePlayerCount();
							dataMatchPC.m_RoomID = msgTPCL.m_RoomID;
							dataMatchPC.m_TableID = msgMatchPC.m_TableID;
							dataMatchPC.m_SitPlayer = msgMatchPC.m_nPlayingPlayerCount;
							dataMatchPC.m_SeePlayer = msgMatchPC.m_nSeeingPlayerCount;
							m_spViewTaoJinMatch.UpdatePlayerCount(dataMatchPC);
						}
					}
				}
				else
				{
					DebugError("OnTablePlayerCountList Place",msgTPCL.m_RoomID,msgTPCL.m_listTablePC.length,TempDataRoomInfo.m_Place);
				}
			}
			else
			{
				DebugError("OnTablePlayerCountList",msgTPCL.m_RoomID,msgTPCL.m_listTablePC.length);
			}
		}
		
		private function OnPlayerJoinTable(msgData:MsgData):void
		{
			DebugLog("OnPlayerJoinTable");
			
			var msgPJT:Game_PlayerJoinTable = new Game_PlayerJoinTable();
			msgPJT.Read(msgData);
			
			if( msgPJT.m_PID == m_MyData.m_PID )
			{
				if( msgPJT.m_RoomID==m_MyData.m_RoomID && (0==m_MyData.m_TableID||m_MyData.m_TableID==msgPJT.m_TableID) )
				{
					DebugLog("自已加入桌子 RoomID="+msgPJT.m_RoomID+" TableID="+msgPJT.m_TableID);
					m_MyData.m_TableID = msgPJT.m_TableID;
					
					
					if( m_MyData.m_AutoTableID != m_MyData.m_TableID )
					{
						m_MyData.m_AutoRoomID = 0;
						m_MyData.m_AutoTableID = 0;
					}
					
					var TempRI:Data_RoomInfo = GetRoomInfoByID(msgPJT.m_RoomID);
					if( TempRI != null )
					{
						if( TempRI.m_RoomType == DeZhouDef.ROOM_TYPE_Common ) 
							m_GameClient.m_TableType = DeZhouDef.TABLE_TYPE_COMMON;
						else if( TempRI.m_RoomType == DeZhouDef.ROOM_TYPE_TableMatch ) 
							m_GameClient.m_TableType = DeZhouDef.TABLE_TYPE_TableMatch;
						else if( TempRI.m_RoomType == DeZhouDef.ROOM_TYPE_RoomMatch ) 
							m_GameClient.m_TableType = DeZhouDef.TABLE_TYPE_RoomMatch;
						else
							this.DebugError("Type="+TempRI.m_RoomType);
					}
					
					var nClientState:int = m_GameClient.GetClientState();
					if( nClientState == DeZhouDef.ClientState_Init )
					{
						DebugLog("Client OK StartGame 客户端已经准备好，直接启动客户端");
						var TempMsgFlag:LC_Flag = new LC_Flag();
						TempMsgFlag.m_Flag = LC_Flag.StartGame;
						SendMsgToClient(TempMsgFlag);
					}
					else
					{
						DebugLog("OnPlayerJoinTable 客户端未准备好 ClientState="+nClientState);
						if( m_arrayMsgToClient.length > 0 )
						{
							DebugLog("清理多余消息");
							m_arrayMsgToClient.length = 0;
						}
					}
				}
				else
				{
					this.DebugError("OnPlayerLeaveTable",msgPJT.m_RoomID,m_MyData.m_RoomID,msgPJT.m_TableID,m_MyData.m_TableID);
				}					
			}
		}
		private function OnPlayerLeaveTable(msgData:MsgData):void
		{
			DebugLog("OnPlayerLeaveTable");
			
			var msgPLT:Game_PlayerLeaveTable = new Game_PlayerLeaveTable();
			msgPLT.Read(msgData);
			
			if( msgPLT.m_PID == this.m_MyData.m_PID )
			{
				DebugLog("自已退出桌子 RoomID="+msgPLT.m_RoomID+" TableID="+msgPLT.m_TableID);
				if( msgPLT.m_RoomID==m_MyData.m_RoomID && msgPLT.m_TableID==m_MyData.m_TableID)
				{
					m_MyData.m_TableID = 0;
					
					var nGameState:int = m_GameClient.GetClientState();
					if( nGameState == DeZhouDef.ClientState_Gamming )
					{
						if( m_GameClient.visible )
						{
							var TempMsgFlag:LC_Flag = new LC_Flag();
							TempMsgFlag.m_Flag = LC_Flag.CloseClient;
							SendMsgToClient(TempMsgFlag);
						}
						else
						{
							DebugError("OnPlayerLeaveTable Client Hide");
						}
					}
					else
					{
						DebugError("OnPlayerLeaveTable ClientState="+nGameState);
					}
				}
				else
				{
					DebugError("OnPlayerLeaveTable",msgPLT.m_RoomID,m_MyData.m_RoomID,msgPLT.m_TableID,m_MyData.m_TableID);
				}					
			}
			else
			{
				if( msgPLT.m_RoomID==m_MyData.m_RoomID && msgPLT.m_TableID==m_MyData.m_TableID )
				{
					PushMsgToClient(msgData);
				}
				else
				{
					DebugError("OnPlayerLeaveTable",msgPLT.m_RoomID,m_MyData.m_RoomID,msgPLT.m_TableID,m_MyData.m_TableID);
				}
			}
		}
		
		private function OnPlayerLeaveRoom(msgData:MsgData):void
		{
			DebugLog("OnPlayerLeaveRoom");
			
			var msgPLR:Game_PlayerLeaveRoom = new Game_PlayerLeaveRoom();
			msgPLR.Read(msgData);
			
			if( msgPLR.m_PID == this.m_MyData.m_PID )
			{
				if( msgPLR.m_RoomID==m_MyData.m_RoomID )
				{
					this.DebugLog("自已退出房间 RoomID="+m_MyData.m_RoomID);
					m_MyData.m_RoomID = 0;
				}
				else
				{
					this.DebugError("OnPlayerLeaveRoom",msgPLR.m_RoomID,m_MyData.m_RoomID);
				}				
			}
		}
		private function OnPlayerJoinRoom(msgData:MsgData):void
		{
			DebugLog("OnPlayerJoinRoom");
			
			var msgPJR:Game_PlayerJoinRoom = new Game_PlayerJoinRoom();
			msgPJR.Read(msgData);
			
			if( msgPJR.m_PID == this.m_MyData.m_PID )
			{
				if( 0==m_MyData.m_RoomID || m_MyData.m_RoomID==msgPJR.m_RoomID )
				{
					DebugLog("自已加入房间 RoomID="+msgPJR.m_RoomID);
					m_MyData.m_RoomID = msgPJR.m_RoomID;
					
					if( msgPJR.m_RoomID == m_MyData.m_AutoRoomID )
					{
						if( m_MyData.m_AutoTableID == 0 )
						{
							var TempViewRTI:View_RoomTableInfo = GetViewByRoomID(m_MyData.m_AutoRoomID) as View_RoomTableInfo;
							if( TempViewRTI != null )
							{
								var TempTableInfo:Data_TableInfo = TempViewRTI.GetAutoTable(m_MyData.m_nGameMoney);
								if( TempTableInfo != null )
								{
									m_MyData.m_AutoTableID = TempTableInfo.m_TableID;
									
									var msgRJT:Game_ReqJoinTable = new Game_ReqJoinTable();
									msgRJT.m_RoomID  = m_MyData.m_AutoRoomID;
									msgRJT.m_TableID = m_MyData.m_AutoTableID;
									this.m_gamesocket.SendMsg(msgRJT);
								}
							}
						}
						else
						{
							DebugError("OnPlayerJoinRoom Auto ",m_MyData.m_AutoTableID,msgPJR.m_RoomID,m_MyData.m_RoomID);
						}						
					}
					else
					{
						m_MyData.m_AutoRoomID = 0;
						m_MyData.m_AutoTableID = 0;
					}
				}
				else
				{
					DebugError("OnPlayerJoinRoom",msgPJR.m_RoomID,m_MyData.m_RoomID);
				}
			}
		}
		
		private function OnRespRoomTableInfo(msgData:MsgData):void
		{
			DebugLog("OnRespRoomTableInfo");
			
			var msgRespRTI:Game_RespRoomTableInfo = new Game_RespRoomTableInfo();
			msgRespRTI.Read(msgData);
			
			if( msgRespRTI.m_Flag != Game_RespRoomTableInfo.SUCCESS )
			{
				DebugError("OnRespRoomTableInfo Flag="+msgRespRTI.m_Flag);
				switch(msgRespRTI.m_Flag)
				{
					case Game_RespRoomTableInfo.NOROOM:
					{
						
					}
					break;
					default:
				}
			}			
		}
		
		private function OnRespJoinTable(msgData:MsgData):void
		{
			DebugLog("OnRespJoinTable");
			
			var msgRespJT:Game_RespJoinTable = new Game_RespJoinTable();
			msgRespJT.Read(msgData);
			
			if( msgRespJT.m_Flag != Game_RespJoinTable.SUCCESS )
			{
				DebugError("OnRespJoinTable Flag=",msgRespJT.m_Flag);
				switch(msgRespJT.m_Flag)
				{
					case Game_RespJoinTable.NOTABLE:
					{
						
					}
					break;
					default:
				}
			}			
			else
			{
				DebugLog("OnRespJoinTable Success RoomID="+msgRespJT.m_RoomID+" TableID="+msgRespJT.m_TableID);
				
				if( msgRespJT.m_Type == Game_RespJoinRoom.JOIN )
				{
					DebugLog("OnRespJoinTable Join RoomID="+msgRespJT.m_RoomID);
				}
				else if( msgRespJT.m_Type == Game_RespJoinRoom.CHANGE )
				{
					DebugLog("OnRespJoinTable CHANGE RoomID="+msgRespJT.m_RoomID);
				}
				else if( msgRespJT.m_Type == Game_RespJoinRoom.ATTACH )
				{
					DebugLog("OnRespJoinTable ATTACH RoomID="+msgRespJT.m_RoomID);
				}
				else
				{
					DebugError("OnRespJoinTable Type="+msgRespJT.m_Type);
				}
			}			
		}
		
		private function OnRespJoinRoom(msgData:MsgData):void
		{
			var msgRespJR:Game_RespJoinRoom = new Game_RespJoinRoom();
			msgRespJR.Read(msgData);
			
			if( msgRespJR.m_Flag != Game_RespJoinRoom.SUCCESS )
			{
				DebugError("OnRespJoinRoom Flag=",msgRespJR.m_Flag);
				switch(msgRespJR.m_Flag)
				{
					case Game_RespJoinRoom.PLAYERFULL:
					{
						
					}
					break;
					default:
				}
			}
			else
			{
				if( msgRespJR.m_Type == Game_RespJoinRoom.JOIN )
				{
					DebugLog("OnRespJoinRoom Join RoomID="+msgRespJR.m_RoomID);
				}
				else if( msgRespJR.m_Type == Game_RespJoinRoom.CHANGE )
				{
					DebugLog("OnRespJoinRoom CHANGE RoomID="+msgRespJR.m_RoomID);
				}
				else if( msgRespJR.m_Type == Game_RespJoinRoom.ATTACH )
				{
					DebugLog("OnRespJoinRoom ATTACH RoomID="+msgRespJR.m_RoomID);
				}
				else
				{
					DebugError("OnRespJoinRoom Type="+msgRespJR.m_Type);
				}
			}
		}
		
		private function OnUserAwardList(msgData:MsgData):void
		{
			DebugLog("OnUserAwardList");
			
			var msgUAL:Game_UserAwardList = new Game_UserAwardList();
			msgUAL.Read(msgData);
		}
		private function OnMaxMoney(msgData:MsgData):void
		{
			DebugLog("OnMaxMoney");
			
			var msgMM:Game_MaxMoney = new Game_MaxMoney();
			msgMM.Read(msgData);
		}
		
		private function OnShowTable(msgData:MsgData):void
		{
			DebugLog("OnShowTable");
			
			var msgST:Game_ShowTable = new Game_ShowTable();
			msgST.Read(msgData);
			
			var TempDataRoomInfo:Data_RoomInfo = this.GetRoomInfoByID(msgST.m_RoomID);
			if( TempDataRoomInfo != null )
			{
				if( TempDataRoomInfo.m_Place < DeZhouDef.Place_TopCommon )
				{
					var TempViewRTI:View_RoomTableInfo = GetViewByRoomID(msgST.m_RoomID) as View_RoomTableInfo;
					if( TempViewRTI != null )
					{
						TempViewRTI.SetShowFlag(msgST.m_TableID,msgST.m_ShowFlag);
						TempViewRTI.UpdateAllTable();
					}
				}
				else if( TempDataRoomInfo.m_Place == DeZhouDef.Place_TaoJingMatch )
				{
					m_spViewTaoJinMatch.SetShowFlag(msgST.m_TableID,msgST.m_ShowFlag);
					m_spViewTaoJinMatch.UpdateAllTable();
				}
				else
				{
					DebugError("OnShowTable",TempDataRoomInfo.m_Place,msgST.m_RoomID);
				}
			}
			else
			{
				DebugError("OnShowTable",msgST.m_RoomID);
			}
		}
		private function OnShowTableList(msgData:MsgData):void
		{
			DebugLog("OnShowTableList");
			
			var msgSTL:Game_ShowTableList = new Game_ShowTableList();
			msgSTL.Read(msgData);
			
			var TempDataRoomInfo:Data_RoomInfo = this.GetRoomInfoByID(msgSTL.m_RoomID);
			if( TempDataRoomInfo != null )
			{
				if( TempDataRoomInfo.m_Place < DeZhouDef.Place_TopCommon )
				{
					var TempViewRTI:View_RoomTableInfo = GetViewByRoomID(msgSTL.m_RoomID) as View_RoomTableInfo;
					if( TempViewRTI != null )
					{
						TempViewRTI.m_HaveTableInfo = 1;
						for(var i:int=0;i<msgSTL.m_arrayTableID.length;++i)
						{
							TempViewRTI.SetShowFlag(msgSTL.m_arrayTableID[i],msgSTL.m_ShowFlag);
						}
						TempViewRTI.UpdateAllTable();
					}
				}
				else if( TempDataRoomInfo.m_Place == DeZhouDef.Place_TaoJingMatch )
				{
					m_spViewTaoJinMatch.m_HaveTableInfo = 1;
					for(var j:int=0;j<msgSTL.m_arrayTableID.length;++j)
					{
						m_spViewTaoJinMatch.SetShowFlag(msgSTL.m_arrayTableID[j],msgSTL.m_ShowFlag);
					}
					m_spViewTaoJinMatch.UpdateAllTable();
				}
				else
				{
					DebugError("OnShowTableList",TempDataRoomInfo.m_Place,msgSTL.m_RoomID);
				}
			}
			else
			{
				DebugError("OnShowTableList",msgSTL.m_RoomID);
			}
		}
		
		private function OnTableInfoList(msgData:MsgData):void
		{
			var msgTIL:Game_TableInfoList = new Game_TableInfoList();
			msgTIL.Read(msgData);		
			
			DebugLog("OnTableInfoList RoomID="+msgTIL.m_RoomID + " Size="+msgTIL.m_TableList.length);
			
			var TempRoomInfo:Data_RoomInfo = this.GetRoomInfoByID(msgTIL.m_RoomID);
			if( TempRoomInfo != null )
			{
				if( TempRoomInfo.m_Place < DeZhouDef.Place_TopCommon )
				{
					var TempViewRTI:View_RoomTableInfo = GetViewByRoomID(msgTIL.m_RoomID) as View_RoomTableInfo;
					if( TempViewRTI != null )
					{
						for(var i:int=0;i<msgTIL.m_TableList.length;++i){
							var TempTableInfo:Data_TableInfo = new Data_TableInfo();
							TempTableInfo.GetDataFromMsg(msgTIL.m_TableList[i]);
							TempViewRTI.AddTableInfo(TempTableInfo);
						}
					}
				}
				else if( TempRoomInfo.m_Place == DeZhouDef.Place_TaoJingMatch )
				{
					for(var nLoop:int=0;nLoop<msgTIL.m_TableList.length;++nLoop)
					{
						var MatchTableInfo:Data_TableInfo = new Data_TableInfo();
						MatchTableInfo.GetDataFromMsg(msgTIL.m_TableList[nLoop]);
						m_spViewTaoJinMatch.AddTableInfo(MatchTableInfo);
					}
				}
				else
				{
					DebugError("OnTableInfoList",TempRoomInfo.m_Place,msgTIL.m_RoomID,msgTIL.m_TableList.length);
				}
			}
			else
			{
				DebugError("OnTableInfoList",msgTIL.m_RoomID,msgTIL.m_TableList.length);
			}
			
			trace("OnTableInfoList End");
		}
		private function OnTableInfo(msgData:MsgData):void
		{
			DebugLog("OnTableInfo");
			
			var msgTI:Game_TableInfo = new Game_TableInfo();
			msgTI.Read(msgData);
			
			var TempRoomInfo:Data_RoomInfo = this.GetRoomInfoByID(msgTI.m_RoomID);
			if( TempRoomInfo != null )
			{
				var TempTableInfo:Data_TableInfo = new Data_TableInfo();
				TempTableInfo.GetDataFromMsg(msgTI);
				
				if( TempRoomInfo.m_Place < DeZhouDef.Place_TopCommon )
				{
					var TempViewRTI:View_RoomTableInfo = GetViewByRoomID(msgTI.m_RoomID) as View_RoomTableInfo;
					if( TempViewRTI != null )
					{
						TempViewRTI.AddTableInfo(TempTableInfo);
					}
				}
				else if( TempRoomInfo.m_Place == DeZhouDef.Place_TaoJingMatch )
				{
					m_spViewTaoJinMatch.AddTableInfo(TempTableInfo);
				}
				else
				{
					DebugError("OnTableInfo",TempRoomInfo.m_Place,msgTI.m_RoomID,msgTI.m_TableID);
				}
			}
			else
			{
				DebugError("OnTableInfo",msgTI.m_RoomID,msgTI.m_TableID);
			}
		}
		
		private function OnPlayerHonorInfoList(msgData:MsgData):void
		{
			DebugLog("OnPlayerHonorInfoList");
			
			var msgPHIL:Game_PlayerHonorInfoList = new Game_PlayerHonorInfoList();
			msgPHIL.Read(msgData);
			
			if( msgPHIL.m_PID==m_MyData.m_PID )
			{
				DebugLog("OnPlayerHonorInfoList 收到自已的信息");
				m_MyData.SetHonorInfo(msgPHIL.m_ArrayHonorID);				
			}
		}
		
		private function OnRespSendGift(msgData:MsgData):void
		{
			DebugLog("OnRespSendGift");
			
			var msgRespSG:Game_RespSendGift = new Game_RespSendGift();
			msgRespSG.Read(msgData);
			
			if( m_winShop.m_boxShop.visible && msgRespSG.m_Flag==DeZhouDef.MsgFlag_Success ){
				if( m_winShop.m_boxShop.m_SendType == Box_Shop.ShopType_MySelf){
					m_winShop.m_boxShop.m_TiShi.m_tTishi.SetText("购买成功");
				}
				else{
					m_winShop.m_boxShop.m_TiShi.m_tTishi.SetText("赠送成功");
				}
				m_winShop.m_boxShop.m_TiShi.ShowTime(3000);
			}
		}
		private function OnSendGift(msgData:MsgData):void
		{
			DebugLog("OnSendGift");
			
			var msgSG:Game_SendGift = new Game_SendGift();
			msgSG.Read(msgData);			
		}
		
		private function OnPlayerGiftInfo(msgData:MsgData):void
		{
			DebugLog("OnPlayerGiftInfo");
			
			var msgGI:Game_PlayerGiftInfo = new Game_PlayerGiftInfo();
			msgGI.Read(msgData);
			
			var curPI:Data_PlayerInfo = null;
			if( msgGI.m_PID == m_MyData.m_PID ){
				curPI = m_MyData;
			}
			else{
				var TempPI:Data_PlayerInfo = null;
				for(var Idx:int=0;Idx<GlobleData.s_arrayPlayerInfo.length;++Idx){
					if( GlobleData.s_arrayPlayerInfo[Idx].m_PID == msgGI.m_PID ){
						TempPI = GlobleData.s_arrayPlayerInfo[Idx];
						break;
					}
				}
				if( TempPI == null ){
					TempPI = new Data_PlayerInfo();
					GlobleData.s_arrayPlayerInfo.push(TempPI);
				}
				curPI = TempPI;
			}
			if( curPI ){
				curPI.AddGiftInfo(msgGI.m_msgGift,DeZhouDef.CurGift);
			}
		}
		private function OnPlayerGiftInfoList(msgData:MsgData):void
		{
			DebugLog("OnPlayerGiftInfoList");
			
			var msgGIL:Game_PlayerGiftInfoList = new Game_PlayerGiftInfoList();
			msgGIL.Read(msgData);
			
			var curPI:Data_PlayerInfo;
			
			var i:int=0;
			if( msgGIL.m_PID == m_MyData.m_PID ){
				for(i=0;i<msgGIL.m_arrayGiftInfo.length;++i){
					m_MyData.AddGiftInfo(msgGIL.m_arrayGiftInfo[i],msgGIL.m_Flag);
				}
				curPI = m_MyData;
			}
			else{
				var TempPI:Data_PlayerInfo = null;
				for(var Idx:int=0;Idx<GlobleData.s_arrayPlayerInfo.length;++Idx){
					if( GlobleData.s_arrayPlayerInfo[Idx].m_PID == msgGIL.m_PID ){
						TempPI = GlobleData.s_arrayPlayerInfo[Idx];
						break;
					}
				}
				if( TempPI == null ){
					TempPI = new Data_PlayerInfo();
					GlobleData.s_arrayPlayerInfo.push(TempPI);
				}
				for(i=0;i<msgGIL.m_arrayGiftInfo.length;++i){
					TempPI.AddGiftInfo(msgGIL.m_arrayGiftInfo[i],msgGIL.m_Flag);
				}
				curPI = TempPI;
			}
			if( m_winPlayerInfo.visible && m_winPlayerInfo.m_boxInfo.m_CurPID==curPI.m_PID ){
				m_winPlayerInfo.m_boxInfo.UpdateCurGift();
				if( curPI.m_PID == m_MyData.m_PID ){
					m_winPlayerInfo.m_boxInfo.UpdatePassGift();
				}
			}
		}
		private function OnPlayerGameMoney(msgData:MsgData):void
		{
			DebugLog("OnPlayerGameMoney");
			
			var msgPGM:Game_PlayerGameMoney = new Game_PlayerGameMoney();
			msgPGM.Read(msgData);
			
			if( msgPGM.m_PID==m_MyData.m_PID )
			{
				DebugLog("OnPlayerGameMoney 收到自已的信息");
				m_MyData.m_nGameMoney = msgPGM.m_nGameMoney;
			}
		}
		private function OnPlayerMoguiMoney(msgData:MsgData):void
		{
			DebugLog("OnPlayerMoguiMoney");
			
			var msgPMM:Game_PlayerMoguiMoney = new Game_PlayerMoguiMoney();
			msgPMM.Read(msgData);
			
			if( msgPMM.m_PID==m_MyData.m_PID )
			{
				DebugLog("OnPlayerMoguiMoney 收到自已的信息");
				m_MyData.m_nMoguiMoney = msgPMM.m_nMoguiMoney;
			}
		}
		private function OnPlayerStateInfoList(msgData:MsgData):void
		{
			//DebugLog("OnPlayerStateInfoList");
			
			var msgPSIL:Game_PlayerStateInfoList = new Game_PlayerStateInfoList();
			msgPSIL.Read(msgData);
			
			for(var i:int=0;i<msgPSIL.m_ArrayPlayerStateInfoList.length;++i)
			{
				var TempPSIL:Game_PlayerStateInfo = msgPSIL.m_ArrayPlayerStateInfoList[i] as Game_PlayerStateInfo;
				if( TempPSIL.m_PID==m_MyData.m_PID )
				{
					DebugLog("OnPlayerStateInfoList 收到自已的信息",TempPSIL.m_Flag);
				}
			}
		}
		
		private function OnPlayerGameInfo(msgData:MsgData):void
		{
			//DebugLog("OnPlayerGameInfo");
			
			var msgPGI:Game_PlayerGameInfo = new Game_PlayerGameInfo();
			msgPGI.Read(msgData);
			
			if( msgPGI.m_PID==m_MyData.m_PID )
			{
				DebugLog("OnPlayerGameInfo 收到自已的信息");
			}
		}
		
		private function OnPlayerStateInfo(msgData:MsgData):void
		{
			//DebugLog("OnPlayerStateInfo");
			
			var msgPSI:Game_PlayerStateInfo = new Game_PlayerStateInfo();
			msgPSI.Read(msgData);
			
			if( msgPSI.m_PID==m_MyData.m_PID )
			{
				DebugLog("OnPlayerStateInfo 收到自已的信息",msgPSI.m_Flag,msgPSI.m_State);
			}
			
			if( msgPSI.m_Flag == Game_PlayerStateInfo.Friend )
			{
				if( msgPSI.m_State == DeZhouDef.PLAYER_ST_NONE )
				{
					m_spViewFriend.RemovePlayerInfo(msgPSI.m_PID);
				}
				else
				{
					m_spViewFriend.UpdatePlayerState(msgPSI);
				}
			}
			else if( msgPSI.m_Flag == Game_PlayerStateInfo.SameCity )
			{
				if( msgPSI.m_State == DeZhouDef.PLAYER_ST_NONE )
				{
					m_spViewSameCity.RemovePlayerInfo(msgPSI.m_PID);					
				}
				else
				{
					m_spViewSameCity.UpdatePlayerState(msgPSI);
				}
			}
		}
		
		private function OnPlayerBaseInfo(msgData:MsgData):void
		{
			//DebugLog("OnPlayerBaseInfo");
			
			var msgPBI:Game_PlayerBaseInfo = new Game_PlayerBaseInfo();
			msgPBI.Read(msgData);
			
			if( msgPBI.m_PID==m_MyData.m_PID )
			{		
				DebugLog("OnPlayerBaseInfo 收到自已的信息 Flag="+msgPBI.m_Flag);
			}
			
			if( msgPBI.m_Flag == Game_PlayerBaseInfo.TablePlayer )
			{
				PushMsgToClient(msgData);
			}
			else if( msgPBI.m_Flag == Game_PlayerBaseInfo.Friend )
			{
				var TempFriendInfo:Data_SNSPlayerInfo = new Data_SNSPlayerInfo();
				TempFriendInfo.m_PID         = msgPBI.m_PID;
				TempFriendInfo.m_NickName    = msgPBI.m_NickName;
				TempFriendInfo.m_HeadURL     = msgPBI.m_HeadPicURL;
				TempFriendInfo.m_nMoney      = msgPBI.m_nGameMoney;
				TempFriendInfo.m_GameLevel   = msgPBI.m_GameLevel;
				m_spViewFriend.AddPlayerInfo(TempFriendInfo);
				m_spViewFriend.UpdateAllPlayer();
				
				var TempFI:Data_FriendInfo = new Data_FriendInfo();
				TempFI.m_PID         = msgPBI.m_PID;
				TempFI.m_NickName    = msgPBI.m_NickName;
				TempFI.m_HeadURL     = msgPBI.m_HeadPicURL;
				TempFI.m_nGameMoney  = msgPBI.m_nGameMoney;
				TempFI.m_GameLevel   = msgPBI.m_GameLevel;
				m_MyData.AddFrindInfo(TempFI);
				
				if( m_winPlayerInfo.visible && m_winPlayerInfo.m_boxInfo.m_CurPID==m_MyData.m_PID ){
					m_winPlayerInfo.m_boxInfo.UpdataFriend();
				}
			}
			else if( msgPBI.m_Flag == Game_PlayerBaseInfo.SameCity )
			{
				var TempCityInfo:Data_SNSPlayerInfo = new Data_SNSPlayerInfo();
				TempCityInfo.m_PID         = msgPBI.m_PID;
				TempCityInfo.m_NickName    = msgPBI.m_NickName;
				TempCityInfo.m_HeadURL     = msgPBI.m_HeadPicURL;
				TempCityInfo.m_nMoney      = msgPBI.m_nGameMoney;
				TempCityInfo.m_GameLevel   = msgPBI.m_GameLevel;
				m_spViewSameCity.AddPlayerInfo(TempCityInfo);
				m_spViewSameCity.UpdateAllPlayer();
			}
		}
		
		private function OnPlayerMatchData(msgData:MsgData):void
		{
			DebugLog("OnPlayerMatchData");
			
			var msgPMD:Game_PlayerMatchData = new Game_PlayerMatchData();
			msgPMD.Read(msgData);
		}
		
		private function OnPlayerDataEx(msgData:MsgData):void
		{
			DebugLog("OnPlayerDataEx");
			
			var msgPDEx:Game_PlayerDataEx = new Game_PlayerDataEx();
			msgPDEx.Read(msgData);
			
			m_MyData.m_VipLevel        = msgPDEx.m_VipLevel;
			m_MyData.m_FriendCount     = msgPDEx.m_FriendCount;
			
			m_MyData.m_MaxPai.Copy(msgPDEx.m_dataMaxPai);
			m_MyData.m_MaxPaiTime      = msgPDEx.m_MaxPaiTime;
			m_MyData.m_MaxMoney        = msgPDEx.m_MaxMoney;
			m_MyData.m_MaxMoneyTime    = msgPDEx.m_MaxMoneyTime;
			m_MyData.m_MaxWin          = msgPDEx.m_MaxWin;
			m_MyData.m_MaxWinTime      = msgPDEx.m_MaxWinTime;
		}
		
		private function OnPlayerData(msgData:MsgData):void
		{
			DebugLog("OnPlayerData");
			
			var msgPD:Game_PlayerData = new Game_PlayerData();
			msgPD.Read(msgData);
			
			GlobleData.s_MyPID = msgPD.m_PID;
			
			m_MyData.m_Sex             = msgPD.m_Sex;
			//m_MyData.m_PlayerType      = msgPD.m_PlayerType;
			//m_MyData.m_ChangeName      = msgPD.m_ChangeName;			
			
			m_MyData.m_NickName        = msgPD.m_NickName;
			m_MyData.m_HeadPicURL      = msgPD.m_HeadPicURL;
			m_MyData.m_HomePageURL     = msgPD.m_HomePageURL;
			m_MyData.m_City            = msgPD.m_City;

			m_MyData.m_nBankMoney      = msgPD.m_nBankMoney;
			m_MyData.m_nOpenBank       = msgPD.m_OpenBank;
			m_MyData.m_nGameMoney      = msgPD.m_nGameMoney;
			m_MyData.m_nMoguiMoney     = msgPD.m_nMoGuiMoney;
			m_MyData.m_nMatchJF        = msgPD.m_nMatchJF;
			
			m_MyData.m_nJF             = msgPD.m_nJF;
			m_MyData.m_nEP             = msgPD.m_nEP;
			m_MyData.m_nWinTimes       = msgPD.m_nWinTimes;
			m_MyData.m_nLossTimes      = msgPD.m_nLossTimes;
			m_MyData.m_nGameTime       = msgPD.m_nGameTime;
			
			m_MyData.m_JoinTime        = msgPD.m_JoinTime;
			//m_MyData.m_LandTime        = msgPD.m_LandTime;
			
			m_MyData.m_RoomID          = msgPD.m_RoomID;
			m_MyData.m_TableID         = msgPD.m_TableID;
			m_MyData.m_SitID           = msgPD.m_SitID;
			m_MyData.m_PlayerState     = msgPD.m_PlayerState;
			
			DebugLog("OnPlayerData Position State",m_MyData.m_RoomID,m_MyData.m_TableID,m_MyData.m_SitID,m_MyData.m_PlayerState);
			
			m_MyData.m_GameLevel       = msgPD.m_GameLevel;
			
			m_spTitle.SetGameMoney(msgPD.m_nGameMoney);
			m_spTitle.SetMoGuiMoney(msgPD.m_nMoGuiMoney);
			
			m_spPlayerInfoBoard.SetPlayerHeadURL(msgPD.m_HeadPicURL);
			m_spPlayerInfoBoard.SetPlayerNickName(msgPD.m_NickName);
			
			if( m_MyData.m_RoomID != 0 )
			{
				var TempRI:Data_RoomInfo = this.GetRoomInfoByID(m_MyData.m_RoomID);
				if( TempRI != null )
				{
					if( TempRI.m_Place < DeZhouDef.Place_TopCommon )
					{
						m_TabFlag = DeZhouDef.TabFlag_Common;
						
						m_spTabRoomInfo.visible = true;
						m_spViewStackRoomInfo.visible = true;
						m_btnQuickStartGame.visible = true;
						m_btnCreateRoom.visible = true;
						
						m_spTabMatch.visible = false;
						m_spViewMatchStack.visible = false;
						
						var viewRI:View_RoomTableInfo =  GetViewByRoomID( m_MyData.m_RoomID ) as View_RoomTableInfo;
						if( viewRI )
						{
							m_TabPlace = viewRI.m_Place;
							m_spTabRoomInfo.selectedIndex = viewRI.m_Idx;
							
							DebugLog("PlayerData RoomID Idx",m_MyData.m_RoomID,viewRI.m_Idx);
						}
						else
						{
							DebugError("PlayerData GetViewByRoomID Room="+m_MyData.m_RoomID);
						}
					}
					else
					{
						m_TabFlag = DeZhouDef.TabFlag_Match;
						
						m_spTabRoomInfo.visible = false;
						m_spViewStackRoomInfo.visible = false;
						m_btnQuickStartGame.visible = false;
						m_btnCreateRoom.visible = false;
						
						m_spTabMatch.visible = true;
						m_spViewMatchStack.visible = true;
						
						if( TempRI.m_Place == DeZhouDef.Place_TaoJingMatch )
						{
							m_TabPlace = TempRI.m_Place;
							m_spTabMatch.selectedIndex = m_spViewTaoJinMatch.m_Idx;
						}
						else if( TempRI.m_Place == DeZhouDef.Place_GuanJunMatch )
						{
							m_TabPlace = TempRI.m_Place;	
							m_spTabMatch.selectedIndex = m_spViewGuanJunMatch.m_Idx;
						}
						else if( TempRI.m_Place == DeZhouDef.Place_JingBiaoMatch )
						{
							m_TabPlace = TempRI.m_Place;
							m_spTabMatch.selectedIndex = m_spViewJingBiaoMatch.m_Idx;
						}
						else
						{
							DebugError("PlayerData GetViewByRoomID Room="+m_MyData.m_RoomID);
						}
					}
				}
				else
				{
					this.DebugError("OnPlayerData GetRoomInfoByID ",m_MyData.m_RoomID);
				}
			}
			else
			{
				var TempJointRoomID:int = 0;
				if( ConfigData.m_TabFlag>DeZhouDef.TabFlag_Match || ConfigData.m_TabFlag<DeZhouDef.TabFlag_Common )
				{
					ConfigData.m_TabFlag = DeZhouDef.TabFlag_Common;
				}
				
				if( ConfigData.m_TabFlag == DeZhouDef.TabFlag_Common )
				{
					m_TabFlag = DeZhouDef.TabFlag_Common;
					
					m_spTabRoomInfo.visible = true;
					m_spViewStackRoomInfo.visible = true;
					m_btnQuickStartGame.visible = true;
					m_btnCreateRoom.visible = true;
					
					m_spTabMatch.visible = false;
					m_spViewMatchStack.visible = false;					
					
					var SelectIdx:int = -1;
					var TempVS:Vector.<DisplayObject> = m_spViewStackRoomInfo.items;
					for( var i:int=0;i<TempVS.length;++i)
					{
						if( (TempVS[i] as View_RoomTableInfo).m_Place == ConfigData.m_TabPlace )
						{
							SelectIdx = i;
							
							m_TabPlace = ConfigData.m_TabPlace;
							m_spTabRoomInfo.selectedIndex = SelectIdx;							
							
							TempJointRoomID = (TempVS[SelectIdx] as View_RoomTableInfo).m_RoomID;
							
							break;
						}
					}
					if( SelectIdx == -1 )
					{
						DebugError("Set RoomPlace ",ConfigData.m_TabPlace);
					}					
				}
				else if( ConfigData.m_TabFlag == DeZhouDef.TabFlag_Match )
				{
					m_TabFlag = DeZhouDef.TabFlag_Match;
					
					m_spTabRoomInfo.visible = false;
					m_spViewStackRoomInfo.visible = false;
					m_btnQuickStartGame.visible = false;
					m_btnCreateRoom.visible = false;
					
					m_spTabMatch.visible = true;
					m_spViewMatchStack.visible = true;					
					
					var MatchIdx:int = -1;
					var TempMatchVS:Vector.<DisplayObject> = m_spViewMatchStack.items;
					for( i=0;i<TempMatchVS.length;++i)
					{
						if( (TempMatchVS[i] as ViewSprite).m_Place == ConfigData.m_TabPlace )
						{
							MatchIdx = i;
							
							m_TabPlace = ConfigData.m_TabPlace;
							m_spTabMatch.selectedIndex = MatchIdx;
							
							if( m_TabPlace == DeZhouDef.Place_TaoJingMatch )
							{
								TempJointRoomID = m_spViewTaoJinMatch.m_RoomID;
							}
							
							break;
						}
					}
					if( MatchIdx == -1 )
					{
						DebugError("Set MatchPlace ",ConfigData.m_TabPlace);
					}
				}
				
				m_spChangeDi.SetSelect(m_TabFlag);				
				
				/*
				if( TempJointRoomID > 0 )
				{
					var msgReqRTI:Game_ReqRoomTableInfo = new Game_ReqRoomTableInfo();
					msgReqRTI.m_RoomID = TempJointRoomID;
					m_gamesocket.SendMsg(msgReqRTI);
					
					var msgReqJR:Game_ReqJoinRoom = new Game_ReqJoinRoom();
					msgReqJR.m_RoomID = TempJointRoomID;
					m_gamesocket.SendMsg(msgReqJR);
				}*/			
			}
		}
		
		private function OnRoomInfoList(msgData:MsgData):void
		{
			DebugLog("OnRoomInfoList");
			
			var msgRIL:Game_RoomInfoList = new Game_RoomInfoList();
			msgRIL.Read(msgData);
			
			for(var i:int;i<msgRIL.m_nCount;++i)
			{
				var TempRI:Game_RoomInfo = msgRIL.m_ArrayRoomInfo[i];
				var TempDataRI:Data_RoomInfo = new Data_RoomInfo();
				TempDataRI.GetDataFromMsg(TempRI);
				m_arrayRoomInfo.push(TempDataRI);
				
				this.DebugLog(TempRI.m_RoomRule);
			}
		}
		
		private function OnRoomInfo(msgData:MsgData):void
		{
			DebugLog("OnRoomInfo");
			
			var msgRI:Game_RoomInfo = new Game_RoomInfo();
			msgRI.Read(msgData);
		}		
		
		private function OnJuBaoPengMoney(msgData:MsgData):void
		{
			DebugLog("OnJuBaoPengMoney");
			
			var msgJBPM:Game_JuBaoPengMoney = new Game_JuBaoPengMoney();
			msgJBPM.Read(msgData);
			
			//this.m_spTitle.m_tJuBaoPeng.text = String(msgJBPM.m_JuBaoPengMoney);
		}		
		
		private function OnRespLobbyConnect(msgData:MsgData):void
		{
			DebugLog("OnRespLobbyConnect");
			
			var msgRLC:RespLobbyConnect = new RespLobbyConnect();
			msgRLC.Read(msgData);
			
			if( msgRLC.m_Flag == RespLobbyConnect.SUCCESS )
			{
				DebugLog("AID="+msgRLC.m_AID+" PID="+msgRLC.m_PID+" 登陆成功！");
				
				m_MyData.m_AID = msgRLC.m_AID;
				m_MyData.m_PID = msgRLC.m_PID;
			}
			else
			{
				DebugLog("AID="+msgRLC.m_AID+" PID="+msgRLC.m_PID+" 登陆失败！"+" Flag="+msgRLC.m_Flag);
			}
		}
		
		private function OnBatchProtocol(msgData:MsgData):void
		{
			DebugLog("OnBatchProtocol");
			
			var msgBP:BatchProtocol = new BatchProtocol();
			msgBP.Read(msgData);
			
			if( msgBP.m_Flag == BatchProtocol.START )
			{
				DebugLog("协议开始 ID=" + msgBP.m_XYID);
			}
			else if( msgBP.m_Flag == BatchProtocol.END )
			{
				DebugLog("协议结束 ID=" + msgBP.m_XYID);
				if( msgBP.m_XYID == Game_RoomInfoList.ID )
				{
					var strRoomName:String = "";
					var strMatchLabel:String = "";
					
					var HaveTaoJing:int = 0;
					var HaveGuanJun:int = 0;
					var HaveJingBiao:int = 0;
					
					var nCommonIdx:int = 0;
					var nMatchIdx:int = 0;
					for(var i:int=0;i<m_arrayRoomInfo.length;++i)
					{
						var TempDataRI:Data_RoomInfo = m_arrayRoomInfo[i];
						if( TempDataRI.m_Place < DeZhouDef.Place_TopCommon )
						{
							var TempViewRTI:View_RoomTableInfo = new View_RoomTableInfo();
							TempViewRTI.m_RoomID = TempDataRI.m_RoomID;
							TempViewRTI.m_Place  = TempDataRI.m_Place;
							TempViewRTI.m_Idx    = nCommonIdx++;
							m_spViewStackRoomInfo.addItem(TempViewRTI);
							
							if( strRoomName == "") strRoomName = TempDataRI.m_RoomName;
							else strRoomName += (","+TempDataRI.m_RoomName);
						}
						else if( TempDataRI.m_Place == DeZhouDef.Place_TaoJingMatch )
						{
							if( HaveTaoJing == 0 )
							{
								HaveTaoJing = 1;
								
								if( strMatchLabel == "" ) strMatchLabel = TempDataRI.m_RoomName;
								else strMatchLabel += (","+TempDataRI.m_RoomName);							
								
								m_spViewTaoJinMatch = new View_TaoJinMatch();
								m_spViewTaoJinMatch.m_Idx = nMatchIdx++;
								m_spViewMatchStack.addItem(m_spViewTaoJinMatch);
								
								m_spViewTaoJinMatch.m_RoomID = TempDataRI.m_RoomID;
							}												
						}
						else if( TempDataRI.m_Place == DeZhouDef.Place_GuanJunMatch )
						{
							if( HaveGuanJun == 0 )
							{
								HaveGuanJun = 1;
								
								if( strMatchLabel == "" ) strMatchLabel = TempDataRI.m_RoomName;
								else strMatchLabel += (","+TempDataRI.m_RoomName);
								
								m_spViewGuanJunMatch = new View_GuanJunMatch();
								m_spViewGuanJunMatch.m_Idx = nMatchIdx++;
								m_spViewMatchStack.addItem(m_spViewGuanJunMatch);
							}
						}
						else if( TempDataRI.m_Place == DeZhouDef.Place_JingBiaoMatch )
						{
							if( HaveJingBiao == 0 )
							{
								HaveJingBiao = 1;
								
								if( strMatchLabel == "" ) strMatchLabel = TempDataRI.m_RoomName;
								else strMatchLabel += (","+TempDataRI.m_RoomName);
								
								m_spViewJingBiaoMatch = new View_JingBiaoMatch();
								m_spViewJingBiaoMatch.m_Idx = nMatchIdx++;
								m_spViewMatchStack.addItem(m_spViewJingBiaoMatch);
							}
						}						
						else
						{
							DebugError("不能处理的房间 RoomID="+TempDataRI.m_RoomID);
						}
					}
					
					m_spTabRoomInfo.labels = strRoomName;
					m_spTabRoomInfo.selectedIndex = 0;
					
					var TempBtnArray:Vector.<ISelect> = m_spTabRoomInfo.items;
					for each(var TempBtn:ISelect in TempBtnArray )
					{
						(TempBtn as Button).labelBold = true;
						(TempBtn as Button).btnLabel.alpha = 0.5;
					}
					(m_spTabRoomInfo.selection as Button).btnLabel.alpha = 1;
					
					m_spTabMatch.labels = strMatchLabel;
					m_spTabMatch.selectedIndex = 0;
					
					TempBtnArray = m_spTabMatch.items;
					for each(TempBtn in TempBtnArray )
					{
						(TempBtn as Button).labelBold = true;
						(TempBtn as Button).btnLabel.alpha = 0.5;
					}
					//(m_spTabMatch.selection as Button).btnLabel.alpha = 1;
				}
				else if( msgBP.m_XYID == Game_TableInfoList.ID )
				{
					
				}
			}
		}
		private function OnGameRule(msgData:MsgData):void
		{
			DebugLog("OnGameRule");
			
			var msgGR:Game_GameRule = new Game_GameRule();
			msgGR.Read(msgData);
			
			DebugLog(msgGR.m_strGameRule);
			
			GlobleData.InitGameRule(msgGR.m_strGameRule);
		}
		private function OnGameFlag(msgData:MsgData):void
		{
			DebugLog("OnGameFlag");
			
			var msgGF:Game_GameFlag = new Game_GameFlag();
			msgGF.Read(msgData);
			
			if( msgGF.m_Flag == Game_GameFlag.LAND_OTHER_PLACE )
			{
				DebugLog("你的帐号在其它地方登陆");
			}
			else if( msgGF.m_Flag == Game_GameFlag.CheckClientExist )
			{
				m_gamesocket.SendMsg(msgGF);
			}
			else if( msgGF.m_Flag == Game_GameFlag.LobbyReady )
			{
				DebugLog("开始显示大厅");
			}
		}
		
		private function OnXieYiList(msgData:MsgData):void
		{			
			var msgXYList:Public_XieYiList = new Public_XieYiList();
			msgXYList.Read(msgData);
			
			trace("OnXieYiList ID="+msgXYList.m_XieYiID+" Len="+msgData.m_msgLen);
			
			var i:int = 0;
			switch( msgXYList.m_XieYiID )
			{
				case Game_CreateTablePID.ID:
				{
					for(i=0;i<msgXYList.m_XYCount;++i)
					{
						var msgCTP:Game_CreateTablePID = new Game_CreateTablePID();
						msgCTP.Read(msgData);
						
						m_gamesocket.DisPatchMsg(msgCTP);
					}
				}
				break;
				case Game_MatchTableState.ID:
				{
					for(i=0;i<msgXYList.m_XYCount;++i)
					{
						var msgMTS:Game_MatchTableState = new Game_MatchTableState();
						msgMTS.Read(msgData);
						
						m_gamesocket.DisPatchMsg(msgMTS);
					}
				}
				break;
				default:
					DebugError("msgXYList 未处理协议 ID="+msgXYList.m_XieYiID);
			}
		}
		
		private function OnRespHeart(msgData:MsgData):void
		{
			//trace("OnRespHeart");
			
			var msgRH:RespHeart = new RespHeart();
			msgRH.Read(msgData);
			
			var msgReqHeart:ReqHeart = new ReqHeart();
			msgReqHeart.m_nHeart = msgRH.m_nHeart;
			m_gamesocket.SendMsg(msgReqHeart,false);
		}

		private function OnRespKey(msgData:MsgData):void
		{
			DebugLog("OnRespKey");
			
			var msgRK:RespKey = new RespKey();
			msgRK.Read(msgData);
			
			m_gamesocket.InitCrypt(msgRK.m_KeyBA);
			
			var msgPLC:PlayerLobbyConnect = new PlayerLobbyConnect();
			msgPLC.m_AID = 1;
			msgPLC.m_PID = 1;
			
			//msgPLC.m_AID = m_webPrama.m_AID;
			//msgPLC.m_PID = m_webPrama.m_PID;
			
			m_gamesocket.SendMsg(msgPLC);
			DebugLog("请求认证 AID="+msgPLC.m_AID+" PID="+msgPLC.m_PID);			
		}
	}
}