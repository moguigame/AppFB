package
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.utils.getTimer;
	
	import Data.Data_ChatMsg;
	import Data.Data_GamePlayer;
	import Data.Data_GameTable;
	import Data.Data_PlayerInfo;
	import Data.Data_ShowChipBoard;
	import Data.Data_ShowPreChipBoard;
	
	import Game.Game_PlayerAct;
	import Game.Game_PlayerBaseInfo;
	import Game.Game_PlayerLeaveTable;
	import Game.Game_ReqLeaveTable;
	import Game.Game_ReqPlayerAct;
	import Game.Game_RespPlayerAct;
	import Game.ServerToClientMessage;
	
	import L2C.L2C_TableInfo;
	import L2C.LC_Flag;
	import L2C.S2C_AddChipInfo;
	import L2C.S2C_ClickSitDownButton;
	import L2C.S2C_Flag;
	import L2C.S2C_MoveMinPai;
	import L2C.S2C_MoveMoney;
	import L2C.S2C_TableChatMsg;
	
	import Logic.Logic_AddChipInfo;
	import Logic.Logic_AddMoneyInfo;
	import Logic.Logic_BankInfo;
	import Logic.Logic_C2SAddMoney;
	import Logic.Logic_DezhouResult;
	import Logic.Logic_GamePlayerInfo;
	import Logic.Logic_GameState;
	import Logic.Logic_JoinJuBaoPeng;
	import Logic.Logic_MatchBlind;
	import Logic.Logic_MatchResult;
	import Logic.Logic_MoneyPool;
	import Logic.Logic_PlayerGameMoney;
	import Logic.Logic_PlayerPower;
	import Logic.Logic_PlayerTurn;
	import Logic.Logic_PromoteTime;
	import Logic.Logic_Relink;
	import Logic.Logic_ReqAddChip;
	import Logic.Logic_ReqShowFace;
	import Logic.Logic_RespSendGift;
	import Logic.Logic_RespShowFace;
	import Logic.Logic_SitPlayerInfo;
	import Logic.Logic_Start;
	import Logic.Logic_StartInfo;
	import Logic.Logic_TableChat;
	import Logic.Logic_TableMoney;
	import Logic.Logic_TablePai;
	import Logic.Logic_TableQuickChat;
	import Logic.Logic_WashOutPlayerInfo;
	import Logic.Logic_XieYiID;
	import Logic.Logic_msgGamePlayerInfo;
	import Logic.Logic_msgMoneyPool;
	import Logic.Logic_msgPlayerWinMoney;
	import Logic.Logic_msgResultPai;
	import Logic.Logic_msgStartPlayerInfo;
	
	import MoGui.display.CLoadImage;
	import MoGui.net.CLoadResource;
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	import UILogic.BigHandPai;
	import UILogic.Box_TakeMoney;
	import UILogic.BtnSitDown;
	import UILogic.CChatDialog;
	import UILogic.CChatPaoPao;
	import UILogic.CFaceSprite;
	import UILogic.CHeGuanDialog;
	import UILogic.CMoneyMotion;
	import UILogic.COperatorBoard;
	import UILogic.CPaiTypeSprite;
	import UILogic.CPlayerActon;
	import UILogic.CPreOperateBoard;
	import UILogic.CShowFaceBoard;
	import UILogic.CSitDownMotion;
	import UILogic.CSpriteWin;
	import UILogic.CTurnLight;
	import UILogic.CWinerLight;
	import UILogic.GamePlayerBoard;
	import UILogic.GamePlayerDetail;
	import UILogic.MinHandPai;
	import UILogic.MingYanBoard;
	import UILogic.QuickStartBoard;
	import UILogic.ResClass;
	import UILogic.SpriteTablePai;
	import UILogic.TableInfoBoard;
	
	import events.ClientToLobby;
	import events.LobbyToClient;
	import events.StageToClient;
	
	import morn.core.components.Button;
	import morn.core.handlers.Handler;
	
	public class DezhouGame extends Sprite
	{
		private static const MaxPlayerOnTable:int          = 9;     //一桌最大的玩家数
		
		private var m_ClientState:int;            //客户端的状态
		private var m_bRelinkEnd:Boolean;         //指是否完成批量房间信息的收取
		private var m_FaPaiTime:int;              //指发牌动画的时间大于0表示正在进行中
		private var m_DivideTime:int;             //指分筹码的动画大于0表示进行中
		private var m_WatchSitID:int;
		private var m_MyData:Data_PlayerInfo;
		private var m_MaxSitPlayerCount:int;      //本桌最多可以坐的玩家个数
		public  var m_TableType:int;              //客户端是比赛模式还是普通模式
		
		//玩家数据，游戏数据
		private var m_dataArrayPlayerData:Vector.<Data_PlayerInfo>;
		private var m_dataArrayGamePlayerInfo:Vector.<Data_GamePlayer>;
		private var m_dataGameTable:Data_GameTable;
		private var m_msgResult:Logic_DezhouResult;
		
		//资源配置
		private var m_pLobby:DezhouLobby;         //指向大厅的对象
		private var m_pLobbyRes:CLoadResource;    //指向皮肤对象
		public  var m_pConfigData:ConfigData;
		private var m_GameRes:CLoadResource;
		private var m_GameConfig:GameConfig;
		
		//显示对象
		private var m_spBackGroud:Sprite;
		private var m_spDownBack:Sprite;
		private var m_spZhouZi:CLoadImage;
		private var m_spTableInfo:TableInfoBoard;
		private var m_spZhuang:ResClass;
		private var m_spBigBlind:ResClass;
		private var m_spSmallBlind:ResClass;
		private var m_spTurnLight:CTurnLight;		
		private var m_mcMySitDown:CSitDownMotion;
		private var m_spPlayerAction:CPlayerActon;
		
		private var m_ptGamePlayerBoard:Vector.<Point>;       //游戏玩家面板的位置
		private var m_ptMinHandPaiStart:Vector.<Point>;       //小牌显示及动画位置
		private var m_ptMinHandPaiEnd:Vector.<Point>;
		private var m_ptBtnSitDown:Vector.<Point>;
		private var m_ptMoneyPool:Vector.<Point>;
		private var m_ptChipMoney:Vector.<Point>;
		private var m_ptBigHandPai:Vector.<Point>;
		private var m_ptBanker:Vector.<Point>;
		private var m_roTurnLight:Vector.<int>;
		private var m_ptPlayerMoney:Vector.<Point>;           //记录一个玩家游戏进出的位置 加注动，赢筹码动画
		private var m_ptShowFace:Vector.<Point>;
		private var m_ptAction:Vector.<Point>;
		private var m_ptChatPao:Vector.<Point>;
		
		private var m_spArrayMinHandPai:Vector.<MinHandPai>;       //显示的小牌以及小牌的位置
		private var m_spArrayBigHandPai:Vector.<BigHandPai>;
		private var m_spArrayChipMoney:Vector.<CMoneyMotion>;      //每个玩家当前下注的显示
		private var m_spArrayAddMoney:Vector.<CMoneyMotion>;       //每个玩家当前加注的显示，这个是动画用的
		private var m_spArrayDivideMoney:Vector.<CMoneyMotion>;
		private var m_spArrayWinerLight:Vector.<CWinerLight>;
		private var m_spArrayPaiType:Vector.<CPaiTypeSprite>;
		private var m_spArrayFace:Vector.<CFaceSprite>;
		private var m_spArrayChatPao:Vector.<CChatPaoPao>;
		
		private var m_spArrayGamePlayerBoard:Vector.<GamePlayerBoard>;//桌面游戏玩家的面板
		private var m_spArrayBtnSitDown:Vector.<BtnSitDown>;          //每个坐伴上的坐下按钮
		private var m_spArrayMoneyPool:Vector.<CMoneyMotion>;         //桌上每个分池的显示
		private var m_spTablePai:SpriteTablePai;
		
		private var m_spOperatorBoard:COperatorBoard;
		private var m_spPreOperateBoard:CPreOperateBoard;
		private var m_spChatDialog:CChatDialog;
		private var m_spHeGuanDialog:CHeGuanDialog;
		private var m_spQuickStart:QuickStartBoard;
		private var m_spMingYan:MingYanBoard;
		private var m_spGamePlayerDetail:GamePlayerDetail;
		private var m_spShowFaceBoard:CShowFaceBoard;
		private var m_spWinMotion:CSpriteWin;
		
		private var m_btnStandUp:Button;
		private var m_btnLobby:Button;
		private var m_btnShowFace:SimpleButton;
		
		private var m_btnAutoBuyMoney:SimpleButton;
		private var m_btnHelp:SimpleButton;
		private var m_btnSeePlayer:SimpleButton;
		private var m_btnJuBaoPeng:SimpleButton;
		
		private var m_boxTakeMoney:Box_TakeMoney;
		
		//声音对象
		private var m_sdAllIn:Sound        = new SD_AllIn();
		private var m_sdChip:Sound         = new SD_Blind();
		private var m_sdCheck:Sound        = new SD_Check();
		private var m_sdClockWarn:Sound    = new SD_ClockWarning();
		private var m_sdGiveUp:Sound       = new SD_GiveUp();
		private var m_sdHandCard:Sound     = new SD_HandCard();
		private var m_sdRaise:Sound        = new SD_Raise();
		private var m_sdRotateCard:Sound   = new SD_RotateCard();
		private var m_sdShowCard:Sound     = new SD_ShowCard();
		private var m_sdTogetherChip:Sound = new SD_TogetherChip();
		private var m_sdVictory:Sound      = new SD_Victory();
		
		public function DezhouGame()
		{
			var Sit:int = 0;
			
			m_MaxSitPlayerCount = MaxPlayerOnTable;
			
			m_WatchSitID = 0;
			m_bRelinkEnd = false;			
			m_FaPaiTime = 0;
			m_DivideTime = 0;
			m_ClientState = DeZhouDef.ClientState_None;
			m_MyData = new Data_PlayerInfo();
			
			m_dataGameTable = new Data_GameTable();
			
			m_msgResult = new Logic_DezhouResult();
			
			m_dataArrayPlayerData = new Vector.<Data_PlayerInfo>();
			m_dataArrayGamePlayerInfo = new Vector.<Data_GamePlayer>(MaxPlayerOnTable);
			
			m_ptMinHandPaiStart = new Vector.<Point>(MaxPlayerOnTable*2);
			m_ptMinHandPaiEnd = new Vector.<Point>(MaxPlayerOnTable*2);
			m_ptBtnSitDown = new Vector.<Point>(MaxPlayerOnTable);
			m_ptGamePlayerBoard = new Vector.<Point>(MaxPlayerOnTable);
			m_ptMoneyPool = new Vector.<Point>(MaxPlayerOnTable);
			m_ptChipMoney = new Vector.<Point>(MaxPlayerOnTable);
			m_ptBigHandPai = new Vector.<Point>(MaxPlayerOnTable);
			m_ptBanker = new Vector.<Point>(MaxPlayerOnTable);
			m_roTurnLight = new Vector.<int>(MaxPlayerOnTable);
			m_ptPlayerMoney = new Vector.<Point>(MaxPlayerOnTable);
			m_ptShowFace = new Vector.<Point>(MaxPlayerOnTable);
			m_ptAction = new Vector.<Point>(MaxPlayerOnTable);
			m_ptChatPao = new Vector.<Point>(MaxPlayerOnTable);
			
			var TempHandPaiStartPtArray:Array = 
				[
					462,132,462,132,
					462,132,462,132,
					462,132,462,132,
					462,132,462,132,
					462,132,462,132,
					462,132,462,132,
					462,132,462,132,
					462,132,462,132,
					462,132,462,132
				];
			var TempHandPaiEndPtArray:Array = 
				[
					490,325,485,325,
					300,325,295,325,
					180,280,177,277,
					195,165,200,162,
					320,145,325,145,
					700,145,705,145,
					830,185,830,190,
					820,296,818,300,
					675,325,670,325
				];

			var TempGamePlayerBoardArray:Array = 
				[
					455,340,
					261,340,
					65,275,
					65,70,
					257,0,
					652,0,
					855,70,
					855,275,
					647,340
				];
			var TempBtnSitDownArray:Array = 
				[
					461,372,
					266,372,
					77,300,
					75,103,
					266,30,
					656,30,
					859,103,
					855,302,
					656,372
				];
			var TempMoneyPoolArray:Array = 
				[
					280,185,
					220,225,
					290,250,
					645,185,
					740,220,
					645,255,
					400,255,
					520,255,
					360,150
				];
			var TempChipMoneyArray:Array = 
				[
					510,295,
					320,295,
					190,290,
					155,190,
					250,120,
					635,120,
					760,160,
					795,240,
					690,295
				];
			
			var TempBigHandPaiArray:Array = 
				[
					560,400,
					190,400,
					60,250,
					160,85,
					365,70,
					580,70,
					790,85,
					900,250,
					760,400
				];
			var TempBankerArray:Array = 
				[
					455,323,
					265,323,
					160,253,
					205,145,
					340,140,
					720,135,
					830,200,
					795,310,
					640,323
				];
			var TempRotationTurnLightArray:Array = 
				[
					0,
					48,
					75,
					100,
					128,
					230,
					259,
					285,
					313
				];
			var TempShowFaceArray:Array = 
				[
					468,300,
					274,300,
					155,257,
					155,145,
					273,110,
					669,110,
					785,150,
					785,270,
					661,300
				];
			var TempPlayerActionArray:Array = 
				[
					50,0,
					50,0,
					50,0,
					50,0,
					50,0,
					50,0,
					-240,0,
					-240,0,
					50,0
				];
			var TempChatPaoArray:Array = 
				[
					-30,-45,
					-30,-45,
					-30,-45,
					-30,70,
					-30,70,
					-30,70,
					-30,70,
					-30,-45,
					-30,-45
				];

			for(Sit=0;Sit<MaxPlayerOnTable;++Sit)
			{
				m_dataArrayGamePlayerInfo[Sit] = new Data_GamePlayer();
				m_dataArrayGamePlayerInfo[Sit].m_SitID = Sit+1;
				
				m_ptMinHandPaiStart[Sit*2] = new Point();
				m_ptMinHandPaiStart[Sit*2+1] = new Point();
				m_ptMinHandPaiEnd[Sit*2] = new Point();
				m_ptMinHandPaiEnd[Sit*2+1] = new Point();
				
				m_ptBtnSitDown[Sit] = new Point();
				m_ptGamePlayerBoard[Sit] = new Point();
				m_ptMoneyPool[Sit] = new Point();
				m_ptChipMoney[Sit] = new Point();
				m_ptBigHandPai[Sit] = new Point();
				m_ptBanker[Sit] = new Point();
				m_ptPlayerMoney[Sit] = new Point();
				m_ptShowFace[Sit] = new Point();
				m_ptAction[Sit] = new Point();
				m_ptChatPao[Sit] = new Point();
				
				m_ptMinHandPaiStart[Sit*2].x   = TempHandPaiStartPtArray[Sit*4];
				m_ptMinHandPaiStart[Sit*2].y   = TempHandPaiStartPtArray[Sit*4+1];
				m_ptMinHandPaiStart[Sit*2+1].x = TempHandPaiStartPtArray[Sit*4+2];
				m_ptMinHandPaiStart[Sit*2+1].y = TempHandPaiStartPtArray[Sit*4+3];
				
				m_ptMinHandPaiEnd[Sit*2].x   = TempHandPaiEndPtArray[Sit*4];
				m_ptMinHandPaiEnd[Sit*2].y   = TempHandPaiEndPtArray[Sit*4+1];
				m_ptMinHandPaiEnd[Sit*2+1].x = TempHandPaiEndPtArray[Sit*4+2];
				m_ptMinHandPaiEnd[Sit*2+1].y = TempHandPaiEndPtArray[Sit*4+3];
				
				m_ptBtnSitDown[Sit].x        = TempBtnSitDownArray[Sit*2];
				m_ptBtnSitDown[Sit].y        = TempBtnSitDownArray[Sit*2+1];
				m_ptGamePlayerBoard[Sit].x   = TempGamePlayerBoardArray[Sit*2];
				m_ptGamePlayerBoard[Sit].y   = TempGamePlayerBoardArray[Sit*2+1];
				m_ptMoneyPool[Sit].x         = TempMoneyPoolArray[Sit*2];
				m_ptMoneyPool[Sit].y         = TempMoneyPoolArray[Sit*2+1];
				m_ptChipMoney[Sit].x         = TempChipMoneyArray[Sit*2];
				m_ptChipMoney[Sit].y         = TempChipMoneyArray[Sit*2+1];
				m_ptBigHandPai[Sit].x        = TempBigHandPaiArray[Sit*2];
				m_ptBigHandPai[Sit].y        = TempBigHandPaiArray[Sit*2+1];
				m_ptBanker[Sit].x            = TempBankerArray[Sit*2];
				m_ptBanker[Sit].y            = TempBankerArray[Sit*2+1];				
				m_roTurnLight[Sit]           = TempRotationTurnLightArray[Sit];
				m_ptPlayerMoney[Sit].x       = m_ptGamePlayerBoard[Sit].x+35;
				m_ptPlayerMoney[Sit].y       = m_ptGamePlayerBoard[Sit].y+45;
				
				m_ptShowFace[Sit].x          = TempShowFaceArray[Sit*2];
				m_ptShowFace[Sit].y          = TempShowFaceArray[Sit*2+1];
				
				m_ptAction[Sit].x            = TempGamePlayerBoardArray[Sit*2]+TempPlayerActionArray[Sit*2];
				m_ptAction[Sit].y            = TempGamePlayerBoardArray[Sit*2+1]+TempPlayerActionArray[Sit*2+1];
				
				m_ptChatPao[Sit].x           = TempGamePlayerBoardArray[Sit*2]  +TempChatPaoArray[Sit*2];
				m_ptChatPao[Sit].y           = TempGamePlayerBoardArray[Sit*2+1]+TempChatPaoArray[Sit*2+1];		
			}			
			
			m_spArrayGamePlayerBoard = new Vector.<GamePlayerBoard>(MaxPlayerOnTable);
			m_spArrayBtnSitDown  = new Vector.<BtnSitDown>(MaxPlayerOnTable);
			m_spArrayMoneyPool   = new Vector.<CMoneyMotion>(MaxPlayerOnTable);
			
			m_spArrayMinHandPai  = new Vector.<MinHandPai>(MaxPlayerOnTable*2);
			m_spArrayBigHandPai  = new Vector.<BigHandPai>(MaxPlayerOnTable);
			
			m_spArrayChipMoney   = new Vector.<CMoneyMotion>(MaxPlayerOnTable);
			m_spArrayAddMoney    = new Vector.<CMoneyMotion>(MaxPlayerOnTable);	
			m_spArrayDivideMoney = new Vector.<CMoneyMotion>(MaxPlayerOnTable);
			m_spArrayWinerLight  = new Vector.<CWinerLight>(MaxPlayerOnTable);
			m_spArrayPaiType     = new Vector.<CPaiTypeSprite>(MaxPlayerOnTable);
			m_spArrayFace        = new Vector.<CFaceSprite>(MaxPlayerOnTable);
			m_spArrayChatPao     = new Vector.<CChatPaoPao>(MaxPlayerOnTable);
			
			this.addEventListener(Event.ADDED_TO_STAGE, OnAddToStage);
		}
		public function SetLobby(pLobby:DezhouLobby):void
		{
			m_pLobby = pLobby;
		}
		public function SetLobbyRes(pRes:CLoadResource):void
		{
			m_pLobbyRes = pRes;
		}
		public function SetConfigData(pconfigdata:ConfigData):void
		{
			m_pConfigData = pconfigdata;
		}
		public function GetClientState():int
		{
			return m_ClientState;
		}
		public function IsMatchTable():Boolean
		{
			return m_TableType==DeZhouDef.TABLE_TYPE_TableMatch || m_TableType==DeZhouDef.TABLE_TYPE_RoomMatch;
		}
		private function InitClient():void
		{
			m_FaPaiTime = 0;
			m_DivideTime = 0;
			
			m_dataArrayPlayerData.length = 0;
			m_dataGameTable.Init();
			m_msgResult.Init();
			for(var Sit:int=0;Sit<MaxPlayerOnTable;Sit++)
			{
				m_dataArrayGamePlayerInfo[Sit].Init();
			}
			
			m_spTableInfo.visible = false;
			m_spTurnLight.visible = false;
			m_spZhuang.visible = false;
			m_spBigBlind.visible = false;
			m_spSmallBlind.visible = false;
			m_spPlayerAction.visible = false;
			
			m_spTablePai.visible = false;
			for(var i:int=0;i<MaxPlayerOnTable;i++)
			{
				m_spArrayMinHandPai[i*2].visible = false;
				m_spArrayMinHandPai[i*2+1].visible = false;
				
				m_spArrayChipMoney[i].visible = false;
				m_spArrayAddMoney[i].visible = false;
				m_spArrayDivideMoney[i].visible = false;
				m_spArrayGamePlayerBoard[i].visible = false;
				m_spArrayMoneyPool[i].visible = false;
				m_spArrayWinerLight[i].visible = false;
				m_spArrayPaiType[i].visible = false;
				m_spArrayFace[i].visible = false;
				m_spArrayChatPao[i].visible = false;
				//m_spArrayFace[i].ShowFace(i+1,1000*1000);
			}
			
			m_spOperatorBoard.Hide();
			m_spPreOperateBoard.Hide();
			m_spQuickStart.visible = false;
			m_spMingYan.visible = false;
			m_spGamePlayerDetail.visible = false;
			m_spShowFaceBoard.visible = false;
			m_spWinMotion.visible = false;
		}
		private function InitGameData():void
		{
			var ServerSit:int = 0;
			var ClientSit:int = 0;
			var Idx:int = 0;
			
			for(ClientSit=0;ClientSit<MaxPlayerOnTable;++ClientSit)
			{
				Idx = ClientSit*2;
				m_spArrayMinHandPai[Idx].visible = false;
				m_spArrayMinHandPai[Idx].SetPoint(m_ptMinHandPaiStart[Idx]);
				
				Idx = ClientSit*2+1;
				m_spArrayMinHandPai[Idx].visible = false;
				m_spArrayMinHandPai[Idx].SetPoint(m_ptMinHandPaiStart[Idx]);
				
				m_spArrayBigHandPai[ClientSit].Init();
				m_spArrayBigHandPai[ClientSit].visible = false;
				
				m_spArrayBigHandPai[ClientSit].InitResult();
			}
			
			for(ServerSit=0;ServerSit<MaxPlayerOnTable;++ServerSit)
			{
				var dataGPI:Data_GamePlayer = m_dataArrayGamePlayerInfo[ServerSit];
				dataGPI.m_FaPaiCount = 0;
				dataGPI.m_arrayHandPai[0] = dataGPI.m_arrayHandPai[1] = 0;
			}
			
			m_spTablePai.visible = false;
			m_spTablePai.InitResult();
			m_spTablePai.Init();			
			m_dataGameTable.InitEveryGame();
			
			m_spPreOperateBoard.Hide();
			m_spOperatorBoard.Hide();
		}
		private function OnAddToStage(evt:Event):void
		{
			DebugLog("GameClient OnAddToStage");
			
			stage.addEventListener(LobbyToClient.EVENT_ID,OnLobbyToClient);
			stage.addEventListener(StageToClient.EVENT_ID,OnStageToClient);	
			
			if( m_ClientState == DeZhouDef.ClientState_None )
			{
				m_GameConfig = new GameConfig();
				m_GameConfig.addEventListener(Event.COMPLETE,OnGameConfigComplete);				
			}
		}
		private function OnGameConfigComplete(evt:Event):void
		{
			GlobleData.s_PlayerTailTime = m_GameConfig.m_PlayerTailTime;
			
			m_GameRes = new CLoadResource(m_pConfigData.m_GameRes,m_pConfigData.m_GameResVer);
			m_GameRes.addEventListener(Event.COMPLETE,OnGameResComplete);
		}
		private function OnGameResComplete(evt:Event):void
		{
			DebugLog("OnGameResComplete");
			
			m_ClientState = DeZhouDef.ClientState_Init;
			
			GlobleData.S_pResGame = m_GameRes;
			GlobleData.StaticInitChipClass(m_GameRes);
			GlobleData.StaticInitPaiClass(m_GameRes);			
			
			var i:int=0;
			var TempClass:Class;
			
			//TempClass = m_pLobbyRes.GetResource("lobby_bg");
			//m_spBackGroud = new TempClass();
			
			TempClass = m_GameRes.GetResource("DownPanelBG");
			m_spDownBack = new TempClass();
			
			m_spZhouZi = new CLoadImage(1000,620);
			m_spZhouZi.SetPic("game_bj.jpg");
			
			m_spTableInfo = new TableInfoBoard();			
			m_spPlayerAction = new CPlayerActon();
			
			m_btnLobby = new Button("png.comp.button_back","返回大厅");
			m_btnLobby.labelColors = "0xffffff,0xffffff,0xffffff,0xffffff";
			m_btnLobby.addEventListener(MouseEvent.CLICK,OnBtnLobby);
			
			m_btnStandUp = new Button("png.comp.button_back","站起旁观");
			m_btnStandUp.labelColors = "0xffffff,0xffffff,0xffffff,0xffffff";
			m_btnStandUp.addEventListener(MouseEvent.CLICK,OnBtnStandUp);
			
			TempClass = m_GameRes.GetResource("ShowFaceBtn");
			m_btnShowFace = new TempClass();
			m_btnShowFace.addEventListener(MouseEvent.CLICK,OnBtnShowFace);
			
			TempClass = m_GameRes.GetResource("AutoBuySmallBtn");
			m_btnAutoBuyMoney = new TempClass();
			m_btnAutoBuyMoney.addEventListener(MouseEvent.CLICK,OnBtnBuyMoney);
			
			TempClass = m_GameRes.GetResource("HelpSmallBtn");
			m_btnHelp = new TempClass();
			m_btnHelp.addEventListener(MouseEvent.CLICK,OnBtnHelp);
			
			TempClass = m_GameRes.GetResource("SeePlayerBtn");
			m_btnSeePlayer = new TempClass();
			m_btnSeePlayer.addEventListener(MouseEvent.CLICK,OnBtnSeePlayer);
			
			TempClass = m_GameRes.GetResource("JBP_Btn");
			m_btnJuBaoPeng = new TempClass();
			m_btnJuBaoPeng.addEventListener(MouseEvent.CLICK,OnBtnJuBaoPeng);
			
			m_spTablePai = new SpriteTablePai();
			
			m_spZhuang = new ResClass();
			m_spZhuang.InitRes(m_GameRes,"Banker");
			
			m_spBigBlind = new ResClass();
			m_spBigBlind.InitRes(m_GameRes,"BigLog");
			
			m_spSmallBlind = new ResClass();
			m_spSmallBlind.InitRes(m_GameRes,"SmallLog");
			
			m_spTurnLight = new CTurnLight();
			m_mcMySitDown = new CSitDownMotion();
			
			m_spOperatorBoard    = new COperatorBoard();
			m_spPreOperateBoard  = new CPreOperateBoard();
			m_spChatDialog       = new CChatDialog();
			m_spHeGuanDialog     = new CHeGuanDialog();
			m_spQuickStart       = new QuickStartBoard();
			m_spMingYan          = new MingYanBoard();
			m_spGamePlayerDetail = new GamePlayerDetail();
			m_spShowFaceBoard    = new CShowFaceBoard();
			m_spWinMotion        = new CSpriteWin();
			
			for(i=0;i<MaxPlayerOnTable;++i)
			{
				m_spArrayGamePlayerBoard[i] = new GamePlayerBoard(i);
				m_spArrayMoneyPool[i]        = new CMoneyMotion();
				m_spArrayBtnSitDown[i]       = new BtnSitDown();
				m_spArrayBtnSitDown[i].m_Idx = i;
				
				m_spArrayMinHandPai[i*2]   = new MinHandPai();
				m_spArrayMinHandPai[i*2+1] = new MinHandPai();
				
				m_spArrayBigHandPai[i]     = new BigHandPai();
				
				m_spArrayChipMoney[i]      = new CMoneyMotion();				
				m_spArrayAddMoney[i]       = new CMoneyMotion();
				m_spArrayDivideMoney[i]    = new CMoneyMotion();
				m_spArrayWinerLight[i]     = new CWinerLight();			
				m_spArrayPaiType[i]        = new CPaiTypeSprite();
				m_spArrayFace[i]           = new CFaceSprite(false);
				
				if( i>=3 && i<=6 ) {
					m_spArrayChatPao[i] = new CChatPaoPao(CChatPaoPao.Type_Up);
				}
				else{
					m_spArrayChatPao[i] = new CChatPaoPao(CChatPaoPao.Type_Down);
				}
				
				m_spArrayChipMoney[i].m_ClientStartSit = i;
				m_spArrayChipMoney[i].m_ClientEndSit = i;
				m_spArrayAddMoney[i].m_ClientStartSit = i;
				m_spArrayDivideMoney[i].m_ClientEndSit = i;
			}
			
			m_boxTakeMoney = new Box_TakeMoney();
			
			//addChild(m_spBackGroud);
			addChild(m_spZhouZi);
			addChild(m_spTableInfo);
			addChild(m_spDownBack);
			addChild(m_spPlayerAction);
			
			addChild(m_btnShowFace);
			addChild(m_btnStandUp);
			addChild(m_btnLobby);
			addChild(m_btnAutoBuyMoney);
			addChild(m_btnHelp);
			addChild(m_btnSeePlayer);
			addChild(m_btnJuBaoPeng);
			addChild(m_spTablePai);
			addChild(m_spZhuang);
			addChild(m_spBigBlind);
			addChild(m_spSmallBlind);
			
			addChild(m_spTurnLight);			
			
			for(i=0;i<MaxPlayerOnTable;++i)
			{
				addChild(m_spArrayWinerLight[i]);
				addChild(m_spArrayMoneyPool[i]);
				addChild(m_spArrayBtnSitDown[i]);
				addChild(m_spArrayGamePlayerBoard[i]);
				
				addChild(m_spArrayMinHandPai[i*2]);
				addChild(m_spArrayMinHandPai[i*2+1]);
				m_spArrayMinHandPai[i*2].visible = false;
				m_spArrayMinHandPai[i*2+1].visible = false;
				
				addChild(m_spArrayBigHandPai[i]);
				
				addChild(m_spArrayChipMoney[i]);
				addChild(m_spArrayAddMoney[i]);
				addChild(m_spArrayDivideMoney[i]);
				
				addChild(m_spArrayPaiType[i]);
				addChild(m_spArrayFace[i]);
				addChild(m_spArrayChatPao[i]);
			}
			addChild(m_mcMySitDown);
			m_mcMySitDown.visible = false;
			
			addChild(m_spOperatorBoard);
			addChild(m_spPreOperateBoard);
			addChild(m_spChatDialog);
			addChild(m_spHeGuanDialog);
			addChild(m_spQuickStart);
			addChild(m_spMingYan);
			addChild(m_spGamePlayerDetail);
			addChild(m_spShowFaceBoard);
			addChild(m_spWinMotion);
			
			m_spZhouZi.x = 0;
			m_spZhouZi.y = -40;
			
			m_spDownBack.x = 0;
			m_spDownBack.y = PositionConfig.s_GameHeight - m_spDownBack.height;
			
			m_btnStandUp.x = 840;
			m_btnStandUp.y = 5;
			
			m_btnLobby.x = 920;
			m_btnLobby.y = 5;
			
			m_btnSeePlayer.x = 20;
			m_btnSeePlayer.y = 458;
			m_btnHelp.x      = 70;
			m_btnHelp.y      = 458;
			m_btnJuBaoPeng.x = 120;
			m_btnJuBaoPeng.y = 458;
			m_btnAutoBuyMoney.x = 170;
			m_btnAutoBuyMoney.y = 458;
			
			m_btnShowFace.x = 720;
			m_btnShowFace.y = 458;
			
			m_spTablePai.x = 390;
			m_spTablePai.y = 226;
			
			m_spTurnLight.x = 500;
			m_spTurnLight.y = 225;
			
			m_mcMySitDown.x = m_ptGamePlayerBoard[0].x + 42;
			m_mcMySitDown.y = m_ptGamePlayerBoard[0].y + 45;
			
			for(i=0;i<MaxPlayerOnTable;++i)
			{
				m_spArrayGamePlayerBoard[i].x = m_ptGamePlayerBoard[i].x;
				m_spArrayGamePlayerBoard[i].y = m_ptGamePlayerBoard[i].y;
				m_spArrayBtnSitDown[i].x      = m_ptBtnSitDown[i].x;
				m_spArrayBtnSitDown[i].y      = m_ptBtnSitDown[i].y;
				m_spArrayMoneyPool[i].x       = m_ptMoneyPool[i].x;
				m_spArrayMoneyPool[i].y       = m_ptMoneyPool[i].y;
				m_spArrayBigHandPai[i].x      = m_ptBigHandPai[i].x;
				m_spArrayBigHandPai[i].y      = m_ptBigHandPai[i].y;
				m_spArrayChipMoney[i].x       = m_ptChipMoney[i].x;
				m_spArrayChipMoney[i].y       = m_ptChipMoney[i].y;
				
				m_spArrayWinerLight[i].x      = m_spTurnLight.x;
				m_spArrayWinerLight[i].y      = m_spTurnLight.y;
				m_spArrayWinerLight[i].rotation = m_roTurnLight[i];
				
				m_spArrayPaiType[i].x         = m_ptGamePlayerBoard[i].x;
				m_spArrayPaiType[i].y         = m_ptGamePlayerBoard[i].y + 30;
				
				m_spArrayFace[i].SetPoint(m_ptShowFace[i]);
				
				m_spArrayChatPao[i].x         = m_ptChatPao[i].x;
				m_spArrayChatPao[i].y         = m_ptChatPao[i].y;
			}
			
			m_spArrayMinHandPai[0].rotation = 0;
			m_spArrayMinHandPai[1].rotation = 20;
			
			m_spArrayMinHandPai[2].rotation = 0;
			m_spArrayMinHandPai[3].rotation = 20;
			
			m_spArrayMinHandPai[4].rotation = 45;
			m_spArrayMinHandPai[5].rotation = 60;
			
			m_spArrayMinHandPai[6].rotation = 115;
			m_spArrayMinHandPai[7].rotation = 135;
			
			m_spArrayMinHandPai[8].rotation = 0;
			m_spArrayMinHandPai[9].rotation = 20;
			
			m_spArrayMinHandPai[10].rotation = 0;
			m_spArrayMinHandPai[11].rotation = 15;
			
			m_spArrayMinHandPai[12].rotation = 65;
			m_spArrayMinHandPai[13].rotation = 85;
			
			m_spArrayMinHandPai[14].rotation = -60;
			m_spArrayMinHandPai[15].rotation = -45;
			
			m_spArrayMinHandPai[16].rotation = 0;
			m_spArrayMinHandPai[17].rotation = 20;
			
			m_spOperatorBoard.x = 252;
			m_spOperatorBoard.y = 470;
			
			m_spPreOperateBoard.x = 252;
			m_spPreOperateBoard.y = 470;
			
			m_spQuickStart.x = 230;
			m_spQuickStart.y = 470;
			
			m_spMingYan.x = 252;
			m_spMingYan.y = 470;
			
			m_spChatDialog.x = 750;
			m_spChatDialog.y = 450;
			
			m_spHeGuanDialog.x = 0;
			m_spHeGuanDialog.y = 485;
			
			m_spGamePlayerDetail.x = 0;
			m_spGamePlayerDetail.y = PositionConfig.s_GameHeight - m_spGamePlayerDetail.height;
			
			m_spShowFaceBoard.x = 795;
			m_spShowFaceBoard.y = 250;
			
			m_spWinMotion.SetPoint(new Point(500,180));
			
			m_spChatDialog.InitQuickChat(m_GameConfig.m_arrayFastChat);
			m_spMingYan.InitWordSet(m_GameConfig.m_arrayWordSet);
			m_spShowFaceBoard.InitFaceInfo(m_GameConfig.m_arrayFaceInfo);
			
			var TempMsgFlag:LC_Flag = new LC_Flag();
			TempMsgFlag.m_Flag = LC_Flag.InitClient;
			SendMsgToLobby(TempMsgFlag);
			
			m_spZhouZi.addEventListener(MouseEvent.CLICK,OnGameBackClick);
			
			//addChild(m_boxTakeMoney);
			//m_boxTakeMoney.visible = false;
		}
		
		private function SendMsgToLobby(msg:Public_XYBase):void
		{
			if( stage != null )
			{
				var evtC2L:ClientToLobby = new ClientToLobby();
				var TempMsgData:MsgData = new MsgData();
				msg.Write(TempMsgData);
				TempMsgData.ResetDataPosition();
				evtC2L.m_msgData = TempMsgData;
				stage.dispatchEvent(evtC2L);
			}
			else
			{
				this.DebugError("SendMsgToLobby stage=null");
			}
		}
		
		private function OnOperateChipInfo(msgdata:MsgData):void
		{
			var msgACI:S2C_AddChipInfo = new S2C_AddChipInfo();
			msgACI.Read(msgdata);
			
			if( m_spOperatorBoard.visible && m_MyData.m_SitID==m_dataGameTable.m_CurPlayerSitID )
			{
				var reqAC:Logic_ReqAddChip = new Logic_ReqAddChip();
				reqAC.m_CurPlayerSitID        = m_MyData.m_SitID;
				reqAC.m_ChipAction            = msgACI.m_ChipAction;
				reqAC.m_nCurChipMoney         = msgACI.m_ChipValue;
				SendLogicMsg(reqAC);
			}
			else
			{
				DebugError("OnOperateChipInfo ",m_spOperatorBoard.visible,m_MyData.m_SitID,m_dataGameTable.m_CurPlayerSitID);
			}
		}
		private function OnTableChat(msgdata:MsgData):void
		{
			var msgTC:S2C_TableChatMsg = new S2C_TableChatMsg();
			msgTC.Read(msgdata);
			
			var msgChat:Logic_TableChat = new Logic_TableChat();
			msgChat.m_PID         = m_MyData.m_PID;
			msgChat.m_strChat     = msgTC.m_ChatMsg;
			SendLogicMsg(msgChat);
		}
		private function AddChatMsg(nFlag:int,PID:int,NickName:String,strChat:String):void
		{
			var dataCM:Data_ChatMsg = new Data_ChatMsg();
			dataCM.m_Flag          = nFlag;
			dataCM.m_PID           = PID;
			dataCM.m_Name          = NickName;
			dataCM.m_Msg           = strChat;
			this.m_spChatDialog.AddChatLog(dataCM);
		}
		
		private function OnStateToClientFlag(msgdata:MsgData):void
		{
			var msgFlag:S2C_Flag = new S2C_Flag();
			msgFlag.Read(msgdata);
			
			switch(msgFlag.m_Flag)
			{
				case S2C_Flag.ChipSpriteClick:
				{
					if( m_spOperatorBoard.visible )
					{
						m_spOperatorBoard.OnChipSprite(msgFlag.m_Value);
					}
					else
					{
						DebugError("S2C_Flag.ChipSpriteClick Value="+msgFlag.m_Value);
					}
				}
				break;
				case S2C_Flag.ChipSliderChange:
				{
					if( m_spOperatorBoard.visible )
					{
						m_spOperatorBoard.OnSliderChange(msgFlag.m_Value);
					}
					else
					{
						DebugError("S2C_Flag.ChipSliderChange Value="+msgFlag.m_Value);
					}
				}
				break;
				case S2C_Flag.ShowWordList:
				{
					m_spShowFaceBoard.visible = false;
				}
				break;
				case S2C_Flag.MouseOverHeadPic:
				{
					ShowGamePlayerDetail(msgFlag.m_Value);
				}
				break;
				case S2C_Flag.MouseOutHeadPic:
				{
					HideGamePlayerDetail(msgFlag.m_Value);
				}
				break;
				case S2C_Flag.ClickPlayerHead:
				{
					OnPlayerHeadClick(msgFlag.m_Value);
				}
				break;				
				case S2C_Flag.QuickStart:
				{
					OnQuickStart(msgFlag.m_Value);
				}
				break;
				case S2C_Flag.QuickChat:
				{
					OnQuickChat(msgFlag.m_Value);
				}
				break;
				case S2C_Flag.ShowFace:
				{
					OnReqShowFace(msgFlag.m_Value);
				}
				break;				
				default:
					DebugError("OnStateToClientFlag Flag="+msgFlag.m_Flag);
			}
		}
		
		private function OnReqShowFace(nValue:Number):void
		{
			if( nValue > 0 && m_MyData.m_SitID )
			{
				var msgSF:Logic_ReqShowFace = new Logic_ReqShowFace();
				msgSF.m_FaceID        = nValue;
				msgSF.m_SitID         = m_MyData.m_SitID;
				SendLogicMsg(msgSF);
			}
			else
			{					
				AddChatMsg(DeZhouDef.ChatFlag_Sys,0,"系统","您当前不在座位上，不能使用表情。");
			}
		}
		private function OnQuickChat(nValue:Number):void
		{
			if( nValue > 0 )
			{
				var msgTC:Logic_TableQuickChat = new Logic_TableQuickChat();
				msgTC.m_PID     = m_MyData.m_PID;
				msgTC.m_Idx     = nValue;
				SendLogicMsg(msgTC);
			}
		}
		
		private function OnQuickStart(nMoney:Number):void
		{
			DebugLog("OnQuickStart");
			
			var EmptySitID:int = GetEmptySitID();
			if( m_MyData.m_SitID==0 && EmptySitID )
			{
				var msgReqPA:Game_ReqPlayerAct = new Game_ReqPlayerAct();
				msgReqPA.m_Action     = Game_ReqPlayerAct.SITDOWN;
				msgReqPA.m_TableID    = m_MyData.m_TableID;
				msgReqPA.m_SitID      = EmptySitID;
				msgReqPA.m_nTakeMoney = nMoney;
				SendGameMsg(msgReqPA);
			}
			else
			{
				DebugError("OnQuickStart SitID="+m_MyData.m_SitID+" EmptySitID="+EmptySitID);
			}
		}
		
		private function ShowGamePlayerDetail(nVaule:Number):void
		{
			DebugLog("ShowGamePlayerDetail");
			
			var PID:int = nVaule;
			if( PID != m_MyData.m_PID ){
				var dataPI:Data_PlayerInfo = GetPlayerInfoByPID(PID);
				if( dataPI != null ){
					m_spGamePlayerDetail.SetData(dataPI);
				}
				if( m_spGamePlayerDetail.visible == false )	{
					m_spGamePlayerDetail.visible = true;
				}
			}
		}
		
		private function OnGameBackClick(evt:MouseEvent):void
		{
			if( m_spPlayerAction ){
				m_spPlayerAction.visible = false;
			}
		}
		
		private function OnPlayerHeadClick(nVaule:Number):void
		{
			var ClientSit:int = nVaule;
			var ServerSitID:int = ClientSitToServerSitID(ClientSit);
			
			if( ClientSit >=0 && ClientSit<m_MaxSitPlayerCount ){
				addChild(m_spPlayerAction);
				
				m_spPlayerAction.m_Sit = ClientSit;
				m_spPlayerAction.Show(m_dataArrayGamePlayerInfo[ServerSitID-1],3000);
				m_spPlayerAction.x = m_ptAction[ClientSit].x;
				m_spPlayerAction.y = m_ptAction[ClientSit].y;				
			}
		}
		private function HideGamePlayerDetail(nVaule:Number):void
		{
			m_spGamePlayerDetail.visible = false;
		}
		
		private function OnMoveMinPaiEnd(msgdata:MsgData):void
		{
			var msgMMP:S2C_MoveMinPai = new S2C_MoveMinPai();
			msgMMP.Read(msgdata);
			
			if( msgMMP.m_StartSit==S2C_MoveMinPai.FaPaiQu && IsRightSit(msgMMP.m_EndSit) )
			{
				if( msgMMP.m_EndSit==0 && msgMMP.m_Idx>=2 && IsRightSitID(m_MyData.m_SitID) )
				{
					var ServerSit:int = m_MyData.m_SitID - 1;
					var ClientSit:int = 0;
					
					var dataGP:Data_GamePlayer = m_dataArrayGamePlayerInfo[ServerSit];					
					if(  GlobleFunc.IsPaiMian(dataGP.m_arrayHandPai[0])
						&& GlobleFunc.IsPaiMian(dataGP.m_arrayHandPai[1]) )
					{
						m_spArrayBigHandPai[ClientSit].visible = true;
						m_spArrayBigHandPai[ClientSit].SetHandPai(dataGP.m_arrayHandPai[0],dataGP.m_arrayHandPai[1]);
						
						m_spArrayMinHandPai[ClientSit*2].visible = false;
						m_spArrayMinHandPai[ClientSit*2+1].visible = false;
					}
				}
			}
			else if( msgMMP.m_EndSit==S2C_MoveMinPai.FaPaiQu && IsRightSit(msgMMP.m_StartSit) )
			{
				m_spArrayMinHandPai[msgMMP.m_StartSit*2].visible = false;
				m_spArrayMinHandPai[msgMMP.m_StartSit*2+1].visible = false;
			}
			else
			{
				DebugError("OnMoveMinPaiEnd ",msgMMP.m_StartSit,msgMMP.m_EndSit);
			}
		}
		
		private function OnMoveMoneyEnd(msgdata:MsgData):void
		{
			var msgMM:S2C_MoveMoney = new S2C_MoveMoney();
			msgMM.Read(msgdata);
			
			DebugLog("OnMoveMoneyEnd",msgMM.m_MoneyFlag,msgMM.m_ServerStartSitID,msgMM.m_ServerEndSitID,msgMM.m_ClientStartSit,msgMM.m_ClientEndSit);
			
			var ServerSit:int = 0;
			var ClientSit:int = 0;
			if( msgMM.m_MoneyFlag == CMoneyMotion.Flag_AddChip )
			{
				ServerSit = msgMM.m_ServerStartSitID - 1;
				var AddChipClientSit:int = ServerSitIDToClientSit(msgMM.m_ServerStartSitID);
				if( AddChipClientSit != msgMM.m_ClientStartSit )
				{
					DebugError("OnMoveMoneyEnd Flag_AddChip",AddChipClientSit,msgMM.m_ClientStartSit );
				}
				DebugLog("Flag_AddChip ",msgMM.m_ServerStartSitID,AddChipClientSit);
				if( IsRightSit(AddChipClientSit) )
				{
					m_spArrayAddMoney[AddChipClientSit].visible = false;
					
					m_spArrayChipMoney[AddChipClientSit].SetPoint(m_ptChipMoney[AddChipClientSit]);
					m_spArrayChipMoney[AddChipClientSit].Money = m_dataArrayGamePlayerInfo[ServerSit].m_ChipMoney;
					m_spArrayChipMoney[AddChipClientSit].visible = true;
				}
			}
			else if( msgMM.m_MoneyFlag == CMoneyMotion.Flag_ChipToPool )
			{
				ClientSit = ServerSitIDToClientSit(msgMM.m_ServerStartSitID);
				if( ClientSit != msgMM.m_ClientStartSit )
				{
					DebugError("OnMoveMoneyEnd Flag_ChipToPool",ClientSit,msgMM.m_ClientStartSit );
				}
				DebugLog("Flag_ChipToPool ",msgMM.m_ServerStartSitID,ClientSit);
				if( IsRightSit(ClientSit) )
				{
					m_spArrayChipMoney[ClientSit].visible = false;
				}
				if( msgMM.m_ServerEndSitID != 0 )
				{
					UpdateMoneyPool();
				}
			}
			else if( msgMM.m_MoneyFlag == CMoneyMotion.Flag_Divide )
			{
				ClientSit = ServerSitIDToClientSit(msgMM.m_ServerEndSitID);
				if( ClientSit != msgMM.m_ClientEndSit )
				{
					DebugError("OnMoveMoneyEnd Flag_Divide",ClientSit,msgMM.m_ClientEndSit );
				}
				DebugLog("Flag_Divide ",msgMM.m_ServerEndSitID,ClientSit);
				if( IsRightSit(ClientSit) )
				{
					m_spArrayDivideMoney[ClientSit].visible = false;
					m_spArrayGamePlayerBoard[ClientSit].AddTableMoney(m_spArrayDivideMoney[ClientSit].Money);
				}
			}
		}
		private function MotionAddChip(ServerSitID:int,ClientSit:int,nChipMoney:Number):void
		{
			if( IsRightSit(ClientSit) && IsRightSitID(ServerSitID) && nChipMoney>0 )
			{
				var TempAddMoney:CMoneyMotion = m_spArrayAddMoney[ClientSit];
				
				TempAddMoney.m_MoneyFlag          = CMoneyMotion.Flag_AddChip;
				TempAddMoney.m_ServerStartSitID   = ServerSitID;
				TempAddMoney.m_ServerEndSitID     = ServerSitID;				
			
				TempAddMoney.Money = nChipMoney;
				TempAddMoney.SetPoint(m_ptPlayerMoney[ClientSit]);
				TempAddMoney.visible = true;
				TempAddMoney.MoveToPointByTime(m_ptChipMoney[ClientSit],0.3);
			}
		}
		private function MotionGiveUpPai(ServerSitID:int):void
		{
			if( IsRightSitID(ServerSitID) )
			{
				var ClientSit:int = this.ServerSitIDToClientSit(ServerSitID);
				if( IsRightSit(ClientSit) )
				{
					var TempPaiIdx:int = ClientSit*2;
					m_spArrayMinHandPai[TempPaiIdx].SetPoint(m_ptMinHandPaiEnd[TempPaiIdx]);
					m_spArrayMinHandPai[TempPaiIdx].visible = true;
					m_spArrayMinHandPai[TempPaiIdx].m_StartSit = ClientSit;
					m_spArrayMinHandPai[TempPaiIdx].m_EndSit = S2C_MoveMinPai.FaPaiQu;
					m_spArrayMinHandPai[TempPaiIdx].MoveToPointByTime(m_ptMinHandPaiStart[TempPaiIdx],0.3);
					
					TempPaiIdx = ClientSit*2+1;
					m_spArrayMinHandPai[TempPaiIdx].SetPoint(m_ptMinHandPaiEnd[TempPaiIdx]);
					m_spArrayMinHandPai[TempPaiIdx].visible = true;
					m_spArrayMinHandPai[TempPaiIdx].m_StartSit = ClientSit;
					m_spArrayMinHandPai[TempPaiIdx].m_EndSit = S2C_MoveMinPai.FaPaiQu;
					m_spArrayMinHandPai[TempPaiIdx].MoveToPointByTime(m_ptMinHandPaiStart[TempPaiIdx],0.3);
					
					m_sdGiveUp.play();
				}
			}
		}
		private function GetEmptySitID():int
		{
			var SitID:int = 0;		
			for(var ServerSit:int=0;ServerSit<m_MaxSitPlayerCount;++ServerSit)
			{
				if( m_dataArrayGamePlayerInfo[ServerSit].IsEmpty() )
				{
					SitID = ServerSit + 1;
					break;
				}
			}
			return SitID;
		}
		private function HideOperateArea():void
		{
			m_spOperatorBoard.visible = false;
			m_spPreOperateBoard.visible = false;
			m_spQuickStart.visible = false;
			m_spMingYan.visible = false;
		}
		private function OnClickSitDownButton(msgdata:MsgData):void
		{
			var msgSB:S2C_ClickSitDownButton = new S2C_ClickSitDownButton();
			msgSB.Read(msgdata);
			
			var TempSit:int = msgSB.m_ButtonIdx;
			if( IsRightSit(TempSit) )
			{
				var ServerSitID:int = ClientSitToServerSitID(TempSit);
				if( IsRightSitID(ServerSitID) )
				{
					var ServerSit:int = ServerSitID - 1;
					if( m_dataArrayGamePlayerInfo[ServerSit].IsEmpty() )
					{
						var msgReqPA:Game_ReqPlayerAct = new Game_ReqPlayerAct();
						if( m_MyData.m_SitID == 0 )
							msgReqPA.m_Action     = Game_ReqPlayerAct.SITDOWN;
						else
							msgReqPA.m_Action     = Game_ReqPlayerAct.CHANGESIT;
						msgReqPA.m_TableID    = m_MyData.m_TableID;
						msgReqPA.m_SitID      = ServerSitID;
						msgReqPA.m_nTakeMoney = m_dataGameTable.m_nMaxTakeIn/2;
						SendGameMsg(msgReqPA);
						DebugLog("OnClickSitDownButton ",msgReqPA.m_TableID,msgReqPA.m_Action,m_WatchSitID,TempSit,ServerSitID);
					}
					else
					{
						DebugError("OnClickSitDownButton HavePlayer WatchSitID="+m_WatchSitID+" ClickSit="+TempSit+" ServerSitID="+ServerSitID);
					}
				}
				else
				{
					DebugError("OnClickSitDownButton ServerSitID="+ServerSitID);
				}
			}
			else
			{
				DebugError("OnClickSitDownButton TempSit="+TempSit);
			}
		}
		
		private function ShowPreChipBoard():void
		{
			if( m_dataGameTable.IsGamePlaying() )
			{
				if( IsRightSitID(m_MyData.m_SitID) )
				{
					var ServerSit:int = m_MyData.m_SitID - 1;
					var myGP:Data_GamePlayer = m_dataArrayGamePlayerInfo[ServerSit];
					if( myGP.IsPlaying() && 
						( myGP.m_Action==DeZhouDef.ACTION_WaitChip
						  || myGP.m_Action==DeZhouDef.ACTION_SMALLBLIND 
						  || myGP.m_Action==DeZhouDef.ACTION_POT 
						  || (m_dataGameTable.m_MaxChipOnTable>myGP.m_ChipMoney) ) )
					{
						var dataSPCB:Data_ShowPreChipBoard = new Data_ShowPreChipBoard();
						dataSPCB.m_ChipMoney      = myGP.m_ChipMoney;
						dataSPCB.m_TableMoney     = myGP.m_TableMoney;
						dataSPCB.m_nBigBlind      = m_dataGameTable.m_nBigBlind;
						dataSPCB.m_MaxChipOnTable = m_dataGameTable.m_MaxChipOnTable;
						m_spPreOperateBoard.Show(dataSPCB);
					}
					else
					{
						DebugError("Player ST="+myGP.m_PlayerGameState+" Act="+myGP.m_Action+" PID="+myGP.m_PID);
					}
				}
			}
		}
		
		private function OnLobbyToClient(evt:LobbyToClient):void
		{
			//DebugLog("OnLobbyToClient MsgID="+evt.m_msgData.m_msgID,"<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
			
			var msgData:MsgData = evt.m_msgData;
			msgData.ResetDataPosition();
			switch(msgData.m_msgID)
			{
				case ServerToClientMessage.ID:
				{
					OnLogicMsg(msgData);
				}
				break;
				case Game_PlayerBaseInfo.ID:
				{
					OnPlayerBaseInfo(msgData);
				}
				break;
				case Game_PlayerLeaveTable.ID:
				{
					OnPlayerLeaveTable(msgData);
				}
				break;
				case Game_RespPlayerAct.ID:
				{
					OnRespPlayerAct(msgData);
				}
				break;
				case Game_PlayerAct.ID:
				{
					OnPlayerAct(msgData);
				}
				break;
				case L2C_TableInfo.ID:
				{
					OnTableInfo(msgData);
				}
				break;
				case LC_Flag.ID:
				{
					OnLCFlag(msgData);
				}
				break;
				default:
					DebugError("OnLobbyToClient MsgID="+msgData.m_msgID+" MsgLen="+msgData.m_msgLen);
			}
		}
		
		private function OnStageToClient(evt:StageToClient):void
		{
			var msgData:MsgData = evt.m_msgData;
			msgData.ResetDataPosition();
			switch(msgData.m_msgID)
			{
				case S2C_ClickSitDownButton.ID:
				{
					OnClickSitDownButton(msgData);
				}
				break;
				case S2C_MoveMoney.ID:
				{
					OnMoveMoneyEnd(msgData);
				}
				break;
				case S2C_MoveMinPai.ID:
				{
					OnMoveMinPaiEnd(msgData);
				}
				break;
				case S2C_Flag.ID:
				{
					OnStateToClientFlag(msgData);
				}
				break;
				case S2C_AddChipInfo.ID:
				{
					OnOperateChipInfo(msgData);
				}
				break;
				case S2C_TableChatMsg.ID:
				{
					OnTableChat(msgData);
				}
				break;
				default:
					DebugError("OnStageToClient MsgID="+msgData.m_msgID+" MsgLen="+msgData.m_msgLen);
			}
		}	
		
		private function DebugError(...args):void
		{
			Logger.log("Client ?????????????????????",args);
			trace(new Date().toLocaleTimeString(),"Client ?????????????????????",args);
		}
		private function DebugLog(...args):void
		{
			Logger.log("Client ",args);
			trace(new Date().toLocaleTimeString(),"Client",args);
		}
		
		private function OnBtnBuyMoney(evt:MouseEvent):void
		{
			var bCanAdd:Boolean = false;
			var strChat:String = "";		
			
			if( IsRightSitID(m_MyData.m_SitID) )
			{
				var ServerSit:int          = m_MyData.m_SitID - 1;
				var dataGP:Data_GamePlayer = m_dataArrayGamePlayerInfo[ServerSit];
				var dataPI:Data_PlayerInfo = GetPlayerInfoByPID(m_MyData.m_PID);
				if( dataGP!=null && dataPI!=null )
				{
					if( dataGP.m_TableMoney >= m_dataGameTable.m_nMaxTakeIn )
					{
						strChat = "您已经有足够的游戏币，不需要补充游戏币。";
					}
					else if( dataPI.m_nGameMoney-dataGP.m_TableMoney <= 0 )
					{
						strChat = "您的游戏币不足，不能补充游戏币。";
					}
					else
					{
						bCanAdd = true;
						
						var msgAM:Logic_C2SAddMoney = new Logic_C2SAddMoney();
						msgAM.m_SitID     = m_MyData.m_SitID;
						msgAM.m_AddMoney  = Number(GlobleData.s_AddMoney)*m_dataGameTable.m_nBigBlind;
						SendLogicMsg(msgAM);
					}
				}
			}
			else
			{
				strChat = "您当前不在座位上，不能快速补充游戏币。";
			}
			
			if( !bCanAdd )
			{
				AddChatMsg(DeZhouDef.ChatFlag_Sys,0,"系统",strChat);
			}
		}
		private function OnBtnHelp(evt:MouseEvent):void
		{
		}
		private function OnBtnSeePlayer(evt:MouseEvent):void
		{
		}
		private function OnBtnJuBaoPeng(evt:MouseEvent):void
		{
		}		
		private function OnBtnShowFace(evt:MouseEvent):void
		{
			m_spShowFaceBoard.visible = !m_spShowFaceBoard.visible;
			m_spChatDialog.ShowWordList(false);
		}
		private function OnBtnStandUp(evt:MouseEvent):void
		{
			if( IsRightSitID(m_MyData.m_SitID) && m_MyData.m_TableID>0 )
			{
				var msgRespAct:Game_ReqPlayerAct = new Game_ReqPlayerAct();
				msgRespAct.m_TableID       = m_MyData.m_TableID;
				msgRespAct.m_SitID         = m_MyData.m_SitID;
				msgRespAct.m_Action        = Game_ReqPlayerAct.STANDUP;
				SendGameMsg(msgRespAct);
			}
			else
			{
				this.DebugLog("OnBtnStandUp SitID="+m_MyData.m_SitID);
			}
		}
		private function OnBtnLobby(evt:MouseEvent):void
		{
			if( m_ClientState == DeZhouDef.ClientState_Gamming )
			{
				this.DebugLog("ReqLeaveTable RoomID="+m_MyData.m_RoomID+" TableID="+m_MyData.m_TableID);
				var msgRLT:Game_ReqLeaveTable = new Game_ReqLeaveTable();
				msgRLT.m_RoomID  = m_MyData.m_RoomID;
				msgRLT.m_TableID = m_MyData.m_TableID;
				SendGameMsg(msgRLT);
			}
			else
			{
				DebugError("OnBtnLobby ClientState="+m_ClientState);
			}
		}
		
		private function SendGameMsg(msg:Public_XYBase):void
		{
			m_pLobby.ClientSendGameMsg(msg);
		}
		private function SendLogicMsg(msg:Public_XYBase):void
		{
			m_pLobby.ClientSengLogicMsg(msg);
		}
		public function OnTimer(nGameTime:int):void
		{
			var ServerSit:int;
			var ClientSit:int;
			var spGPB:GamePlayerBoard;
			
			m_mcMySitDown.OnTime(nGameTime);
			for(ClientSit=0;ClientSit<MaxPlayerOnTable;++ClientSit)
			{
				m_spArrayWinerLight[ClientSit].OnTime(nGameTime);
				m_spArrayPaiType[ClientSit].OnTime(nGameTime);
				m_spArrayFace[ClientSit].OnTime(nGameTime);
				m_spArrayGamePlayerBoard[ClientSit].OnTime(nGameTime);
				m_spArrayChatPao[ClientSit].OnTime(nGameTime);
			}
			m_spMingYan.OnGameTime(nGameTime);
			m_spWinMotion.OnTime(nGameTime);
			
			OnTimeFaPai(nGameTime);
			OnTimeDivideMoney(nGameTime);
		}
		private function OnTimeDivideMoney(nGameTime:int):void
		{
			var ServerSit:int = 0;
			var ClientSit:int = 0;
			if( m_DivideTime > 0 )
			{
				if( nGameTime - m_DivideTime >= 2000 )
				{
					m_DivideTime = nGameTime;
					var PoolIdx:int = -1;
					var msgLMP:Logic_msgMoneyPool;
					var msgPW:Logic_msgPlayerWinMoney;
					for(ServerSit=0;ServerSit<m_msgResult.m_MoneyPoolCount;++ServerSit)
					{
						if( m_msgResult.m_arrayMoneyPool[ServerSit].m_nMoney > 0 )
						{
							PoolIdx = ServerSit;
							msgLMP = m_msgResult.m_arrayMoneyPool[ServerSit];
						}
					}
					
					if( PoolIdx >= 0 )
					{
						var dataCM:Data_ChatMsg = new Data_ChatMsg();
						dataCM.m_Flag   = DeZhouDef.ChatFlag_HeGuan;
						dataCM.m_Name   = "荷官";
						dataCM.m_Msg    = "第"+(PoolIdx+1)+"池分筹情况如下：";
						dataCM.m_PID    = 0;
						m_spHeGuanDialog.AddChatLog(dataCM);
						
						for(ClientSit=0;ClientSit<MaxPlayerOnTable;++ClientSit)
						{
							m_spArrayWinerLight[ClientSit].visible = false;
						}
						
						var bHaveShowTablePai:Boolean = false;
						var bHaveFlag:Boolean = false;
						var SitIdx:int = 0;
						for(SitIdx=0;SitIdx<msgLMP.m_nPlayerCount;++SitIdx)
						{
							msgPW = msgLMP.m_arrayPlayerInPool[SitIdx];
							ClientSit = ServerSitIDToClientSit(msgPW.m_SitID);							
							if( IsRightSit(ClientSit) )
							{
								var TempWinSit:int = msgPW.m_SitID - 1;
								var dataGP:Data_GamePlayer = m_dataArrayGamePlayerInfo[TempWinSit];
								
								if( !bHaveShowTablePai )
								{
									bHaveShowTablePai = true;
									m_spTablePai.ShowResult(dataGP.m_WinPaiType);
								}
								
								dataCM.Init();
								dataCM.m_Flag   = DeZhouDef.ChatFlag_HeGuan;
								dataCM.m_Name   = dataGP.m_NickName;
								dataCM.m_Msg    = "赢 $" + GlobleFunc.MoneyToString(msgPW.m_nWinMoney);
								m_spHeGuanDialog.AddChatLog(dataCM);
								
								var spDivideMoney:CMoneyMotion = m_spArrayDivideMoney[ClientSit];
								spDivideMoney.Money = msgPW.m_nWinMoney;
								spDivideMoney.SetPoint(m_ptMoneyPool[PoolIdx]);
								spDivideMoney.visible = true;
								
								spDivideMoney.m_MoneyFlag = CMoneyMotion.Flag_Divide;
								spDivideMoney.m_ServerEndSitID = msgPW.m_SitID;
								
								spDivideMoney.MoveToPointByTime(m_ptPlayerMoney[ClientSit],0.5);
								
								if( GlobleFunc.IsRightPaiType(dataGP.m_PaiType) )
								{
									m_spArrayPaiType[ClientSit].SetPaiType(dataGP.m_PaiType);
									m_spArrayPaiType[ClientSit].ShowTime(2000);
									
									m_spArrayBigHandPai[ClientSit].ShowResult(dataGP.m_WinPaiType);
								}
								
								m_sdTogetherChip.play();
								m_spArrayWinerLight[ClientSit].Play();
							}
						}
						msgLMP.m_nMoney = 0;
						m_spArrayMoneyPool[PoolIdx].Money = 0;
						m_spArrayMoneyPool[PoolIdx].visible = false;
						
						if( PoolIdx == 0 )
						{
							m_DivideTime = 0;
						}
					}
					else
					{
						m_DivideTime = 0;
					}
				}
				if( m_dataGameTable.m_GameState != DeZhouDef.GAME_ST_DIVIDEMONEY )
				{
					m_DivideTime = 0;
				}
			}
		}
		private function OnTimeFaPai(nGameTime:int):void
		{
			var ServerSit:int = 0;
			var ClientSit:int = 0;
			if( m_FaPaiTime > 0 )
			{
				var DiffTime:int = 120 + (MaxPlayerOnTable - m_dataGameTable.m_StartPlayer)*10;
				if( nGameTime-m_FaPaiTime >= DiffTime )
				{
					m_FaPaiTime = nGameTime;
					
					var minPaiCount:int = 2;
					var maxPaiCount:int = 0;
					
					for(ServerSit=0;ServerSit<MaxPlayerOnTable;++ServerSit)
					{
						var TempDataGPI:Data_GamePlayer = m_dataArrayGamePlayerInfo[ServerSit];
						if( TempDataGPI.HavePai() )
						{
							if(TempDataGPI.m_FaPaiCount>maxPaiCount)
								maxPaiCount = TempDataGPI.m_FaPaiCount;
							if(TempDataGPI.m_FaPaiCount<minPaiCount)
								minPaiCount = TempDataGPI.m_FaPaiCount;
						}
					}
					
					if( minPaiCount < 2 )
					{
						if( minPaiCount == maxPaiCount )
						{
							maxPaiCount++;
						}
						var EndSit:int = (m_dataGameTable.m_SmallBlindSitID-1-1+MaxPlayerOnTable)%MaxPlayerOnTable;
						for(ServerSit=m_dataGameTable.m_SmallBlindSitID-1;;++ServerSit)
						{
							ServerSit = ServerSit%MaxPlayerOnTable;
							TempDataGPI = m_dataArrayGamePlayerInfo[ServerSit];
							if( TempDataGPI.HavePai() && TempDataGPI.m_FaPaiCount<maxPaiCount )
							{
								ClientSit = ServerSitIDToClientSit(ServerSit+1);
								if( IsRightSit(ClientSit) )
								{
									var PaiIdx:int = ClientSit*2+TempDataGPI.m_FaPaiCount;
									var spHP:MinHandPai = m_spArrayMinHandPai[PaiIdx];
									spHP.SetPoint(m_ptMinHandPaiStart[PaiIdx]);
									spHP.visible = true;
									spHP.m_StartSit = S2C_MoveMinPai.FaPaiQu;
									spHP.m_EndSit   = ClientSit;
									spHP.m_Idx      = TempDataGPI.m_FaPaiCount+1;
									spHP.MoveToPointByTime(m_ptMinHandPaiEnd[PaiIdx],0.3);
									m_sdHandCard.play();
								}
								else
								{
									DebugError("FaPai ServerSit="+ServerSit);
								}
								TempDataGPI.m_FaPaiCount++;
								break;
							}
							if( ServerSit == EndSit )
							{
								break;
							}
						}
					}
					else
					{
						m_FaPaiTime = 0;
					}
				}
			}
		}		
		//客户端的Sit范围是0-8
		private function IsRightSit(Sit:int):Boolean
		{
			return Sit>=0 && Sit<MaxPlayerOnTable;
		}
		//服务器的SitID范围是1-9
		private function IsRightSitID(SitID:int):Boolean
		{
			return SitID>0 && SitID<=MaxPlayerOnTable;
		}
		private function ServerSitIDToClientSit(SitID:int):int
		{
			var RetSit:int = -1;
			if( IsRightSitID(m_WatchSitID) && IsRightSitID(SitID) )
			{
				RetSit = (SitID - m_WatchSitID + MaxPlayerOnTable) % MaxPlayerOnTable;
			}
			else
			{
				this.DebugError("ServerSitIDToClientSit WatchSitID="+m_WatchSitID+" SitID="+SitID);
			}
			return RetSit;
		}
		private function ClientSitToServerSitID(Sit:int):int
		{
			var RetSitID:int = 0;
			
			if( IsRightSitID(m_WatchSitID) && IsRightSit(Sit) )
			{
				RetSitID = (Sit + m_WatchSitID - 1 ) % MaxPlayerOnTable + 1;
			}
			else
			{
				this.DebugError("ClientSitToServerSitID WatchSitID="+m_WatchSitID+" Sit="+Sit);
			}
			return RetSitID;			
		}
		
		private function UpdatePlayerTableMoney(SitID:int,TableMoney:Number,bUpdateBoard:Boolean):void
		{
			var ServerSit:int = 0;
			var ClientSit:int = 0;
			if( IsRightSitID(SitID) )
			{
				ServerSit = SitID - 1;
				ClientSit = ServerSitIDToClientSit(SitID);
				var dataGP:Data_GamePlayer = m_dataArrayGamePlayerInfo[ServerSit];
				if( TableMoney>= 0 )
				{					
					dataGP.m_TableMoney = TableMoney;
					if( bUpdateBoard )
					{
						var spGPB:GamePlayerBoard = m_spArrayGamePlayerBoard[ClientSit];
						spGPB.SetTableMoney(TableMoney);
					}
				}
				else
				{
					DebugError("UpdatePlayerTableMoney TableMoney="+TableMoney);
				}				
			}
			else
			{
				DebugError("UpdatePlayerTableMoney SitID="+SitID);
			}
		}
		private function UpdatePlayerGameMoney(PID:int,GameMoney:Number):void
		{
			var dataPI:Data_PlayerInfo = GetPlayerInfoByPID(PID);
			if( dataPI!=null && GameMoney>=0 )
			{
				dataPI.m_nGameMoney = GameMoney;
			}
			else
			{
				DebugError("UpdatePlayerGameMoney GameMoney="+GameMoney);
			}
		}		
		private function UpdateBankerInfo():void
		{
			//显示庄，大小盲
			var TempBankerSit:int = ServerSitIDToClientSit(m_dataGameTable.m_BankerSitID);
			var TempBigBlindSit:int = ServerSitIDToClientSit(m_dataGameTable.m_BigBlindSitID);
			var TempSmallBlindSit:int = ServerSitIDToClientSit(m_dataGameTable.m_SmallBlindSitID);
			if( IsRightSit(TempBankerSit) )
			{
				m_spZhuang.visible = true;
				m_spZhuang.MoveToByTime(m_ptBanker[TempBankerSit].x,m_ptBanker[TempBankerSit].y,0.5);				
			}
			if( IsRightSit(TempBigBlindSit) )
			{
				m_spBigBlind.visible = true;
				m_spBigBlind.MoveToByTime(m_ptBanker[TempBigBlindSit].x,m_ptBanker[TempBigBlindSit].y,0.5);				
			}
			if( IsRightSit(TempSmallBlindSit) )
			{
				m_spSmallBlind.visible = true;
				m_spSmallBlind.MoveToByTime(m_ptBanker[TempSmallBlindSit].x,m_ptBanker[TempSmallBlindSit].y,0.5);				
			}
			if( !(IsRightSit(TempBankerSit)&&IsRightSit(TempBigBlindSit)&&IsRightSit(TempSmallBlindSit)) )
			{
				DebugError("UpdateBankerInfo",TempBankerSit,TempBigBlindSit,TempSmallBlindSit);
			}
		}
		private function UpdateChipMoney():void
		{
			
		}
		private function UpdateMoneyPool():void
		{
			var PoolIdx:int = 0;
			for(PoolIdx=0;PoolIdx<MaxPlayerOnTable;++PoolIdx)
			{
				if( m_dataGameTable.m_MoneyPool[PoolIdx] > 0 )
				{
					m_spArrayMoneyPool[PoolIdx].visible = true;
					m_spArrayMoneyPool[PoolIdx].Money = m_dataGameTable.m_MoneyPool[PoolIdx];
				}
				else
				{
					m_spArrayMoneyPool[PoolIdx].visible = false;
				}				
			}
		}
		private function UpdateClient():void
		{
			DebugLog("UpdateClient");
			
			var Sit:int = 0;			
			
			//将所有的动画结束掉
			for(Sit=0;Sit<MaxPlayerOnTable;++Sit)
			{
				m_spArrayAddMoney[Sit].EndMotion(false);
				m_spArrayDivideMoney[Sit].EndMotion(false);
			}		
			
			if( m_MyData.m_SitID == 0 )
			{
				if( m_MyData.m_PlayerState != DeZhouDef.PLAYER_ST_SEEING )
				{
					DebugError("UpdateClient SitID="+m_MyData.m_SitID+" PlayerState="+m_MyData.m_PlayerState );
				}
				m_btnStandUp.visible = false;
			}			
			
			for(Sit=0;Sit<MaxPlayerOnTable;++Sit)
			{
				m_spArrayGamePlayerBoard[Sit].visible = false;
				m_spArrayBtnSitDown[Sit].visible = true;
				
				m_spArrayMinHandPai[Sit*2].visible = false;
				m_spArrayMinHandPai[Sit*2+1].visible = false;
				
				m_spArrayBigHandPai[Sit].Init();
				m_spArrayBigHandPai[Sit].visible = false;
				
				m_spArrayAddMoney[Sit].Money = 0;
				m_spArrayAddMoney[Sit].visible = false;
				
				m_spArrayChipMoney[Sit].Money = 0;
				m_spArrayChipMoney[Sit].visible = false;
				
				m_spArrayPaiType[Sit].visible = false;
				m_spArrayFace[Sit].visible = false;
				
				m_spArrayBigHandPai[Sit].InitResult();
			}
			
			var MaxSitPlayer:int = m_dataGameTable.m_MaxSitPlayer;
			var SitPlayerCount:int = 0;
			var ServerSit:int = 0;
			var dataGamePlayer:Data_GamePlayer;
			for(ServerSit=0;ServerSit<MaxPlayerOnTable;++ServerSit)
			{
				dataGamePlayer = m_dataArrayGamePlayerInfo[ServerSit];
				if( dataGamePlayer.IsSitPlayer() )
				{
					SitPlayerCount++;
					var TempSitID:int = dataGamePlayer.m_SitID;
					var TempSit:int   = ServerSitIDToClientSit(TempSitID);
					if( IsRightSit(TempSit) )
					{
						m_spArrayGamePlayerBoard[TempSit].UpdatePlayerInfo(dataGamePlayer);
						m_spArrayGamePlayerBoard[TempSit].visible = true;
						m_spArrayBtnSitDown[TempSit].visible = false;
						
						if( GlobleFunc.IsPaiBack(dataGamePlayer.m_arrayHandPai[0]) 
							&& GlobleFunc.IsPaiBack(dataGamePlayer.m_arrayHandPai[1]) )
						{
							var TempPaiIdx:int = TempSit*2;
							m_spArrayMinHandPai[TempPaiIdx].visible = true;
							m_spArrayMinHandPai[TempPaiIdx].x = m_ptMinHandPaiEnd[TempPaiIdx].x;
							m_spArrayMinHandPai[TempPaiIdx].y = m_ptMinHandPaiEnd[TempPaiIdx].y;
							
							TempPaiIdx = TempSit*2+1;
							m_spArrayMinHandPai[TempPaiIdx].visible = true;
							m_spArrayMinHandPai[TempPaiIdx].x = m_ptMinHandPaiEnd[TempPaiIdx].x;
							m_spArrayMinHandPai[TempPaiIdx].y = m_ptMinHandPaiEnd[TempPaiIdx].y;
						}
						else if(  GlobleFunc.IsPaiMian(dataGamePlayer.m_arrayHandPai[0])
                                   && GlobleFunc.IsPaiMian(dataGamePlayer.m_arrayHandPai[1]) )
						{
							m_spArrayBigHandPai[TempSit].visible = true;
							m_spArrayBigHandPai[TempSit].SetHandPai(dataGamePlayer.m_arrayHandPai[0],dataGamePlayer.m_arrayHandPai[1]);
						}
						else if( GlobleFunc.IsPaiNone(dataGamePlayer.m_arrayHandPai[0]) 
							&& GlobleFunc.IsPaiNone(dataGamePlayer.m_arrayHandPai[1]) )
						{
						}
						else
						{
							DebugError("Big Hand Pai ServerSit",ServerSit,dataGamePlayer.m_arrayHandPai[0],dataGamePlayer.m_arrayHandPai[1] );
						}
						
						if( dataGamePlayer.m_ChipMoney > 0 )
						{
							m_spArrayChipMoney[TempSit].Money = dataGamePlayer.m_ChipMoney;
							m_spArrayChipMoney[TempSit].visible = true;
						}
						
						//if( dataGamePlayer.is)
					}
					else
					{
						DebugError("UpdateClient PlayerBoard SitID="+dataGamePlayer.m_SitID+" TempSit="+TempSit);
					}
				}
			}
			
			UpdateMoneyPool();
			UpdateBankerInfo();
			
			m_spTablePai.SetTablePai(m_dataGameTable.m_TablePai,false);
			
			if( IsRightSitID(m_dataGameTable.m_CurPlayerSitID) )
			{
				var TempCurTurn:int = ServerSitIDToClientSit(m_dataGameTable.m_CurPlayerSitID);
				if(IsRightSit(TempCurTurn))
				{
					m_spTurnLight.MoveToByTime(m_roTurnLight[TempCurTurn],0.4);
				}
				else
				{
					DebugError ("UpdateClient",m_dataGameTable.m_CurPlayerSitID,TempCurTurn);
				}
			}
			else
			{
				m_spTurnLight.visible = false;
			}
			
			HideOperateArea();
			if( IsRightSitID(m_MyData.m_SitID) )
			{
				ServerSit = m_MyData.m_SitID - 1;
				var dataGP:Data_GamePlayer = m_dataArrayGamePlayerInfo[ServerSit];
				if( dataGP.IsPlaying() )
				{
					if( m_dataGameTable.m_CurPlayerSitID == m_MyData.m_SitID )
					{
						//由power来显示操作板
					}
					else
					{						
						ShowPreChipBoard();
					}
				}
				else
				{
					m_spMingYan.visible = true;
				}
			}
			else
			{
				if( SitPlayerCount < MaxSitPlayer )
				{
					m_spQuickStart.visible = true;
				}
				else
				{
					m_spMingYan.visible = true;
				}
			}			
		}
		private function UpdateSitIDPlayerBoard(SitID:int):void
		{
			if( IsRightSitID(SitID) )
			{
				var ClientSit:int = ServerSitIDToClientSit(SitID);
				if( IsRightSit(ClientSit) )
				{
					var datdGPI:Data_GamePlayer = m_dataArrayGamePlayerInfo[SitID-1];
					m_spArrayGamePlayerBoard[ClientSit].UpdatePlayerInfo(datdGPI);
					if( datdGPI.IsEmpty() )
					{
						m_spArrayBtnSitDown[ClientSit].visible = true;
						m_spArrayGamePlayerBoard[ClientSit].visible = false;
					}
					else
					{
						m_spArrayBtnSitDown[ClientSit].visible = false;
						m_spArrayGamePlayerBoard[ClientSit].visible = true;
					}
				}
				else
				{
					DebugError("UpdateSitPlayerBoard SitID="+SitID+" ClientSit="+ClientSit);
				}
			}
			else
			{
				DebugError("UpdateSitPlayerBoard Sit="+SitID);
			}
		}
		
		private function GetGamePlayerInfoByPID(PID:int):Data_GamePlayer
		{
			var retGPI:Data_GamePlayer = null;
			for(var i:int=0;i<m_dataArrayGamePlayerInfo.length;++i){
				if( m_dataArrayGamePlayerInfo[i].m_PID == PID ){
					retGPI = m_dataArrayGamePlayerInfo[i];
					break;
				}
			}
			if( retGPI == null ){
				DebugError("GetGamePlayerInfoByPID PID="+PID);
			}
			return retGPI;
		}
		private function GetPlayerInfoByPID(PID:int):Data_PlayerInfo
		{
			var RetPI:Data_PlayerInfo = null;
			for(var i:int=0;i<m_dataArrayPlayerData.length;++i)
			{
				if( m_dataArrayPlayerData[i].m_PID == PID )
				{
					RetPI = m_dataArrayPlayerData[i];
					break;
				}
			}
			if( RetPI == null )
			{
				DebugError("GetPlayerInfoByPID PID="+PID);
			}
			return RetPI;
		}			
		
		private function OnPlayerBaseInfo(msgData:MsgData):void
		{
			var msgPBI:Game_PlayerBaseInfo = new Game_PlayerBaseInfo();
			msgPBI.Read(msgData);
			
			DebugLog("OnPlayerBaseInfo PID="+msgPBI.m_PID);
			
			var bFind:Boolean = false;
			var TempDataPI:Data_PlayerInfo;
			for(var i:int=0;i<m_dataArrayPlayerData.length;++i)
			{
				TempDataPI = m_dataArrayPlayerData[i];
				if( TempDataPI.m_PID == msgPBI.m_PID )
				{
					bFind = true;
					TempDataPI.SetPlayerBaseInfo(msgPBI);
					break;
				}
			}
			if( !bFind )
			{
				TempDataPI = new Data_PlayerInfo();
				TempDataPI.m_AID   = msgPBI.m_AID;
				TempDataPI.m_PID   = msgPBI.m_PID;
				TempDataPI.SetPlayerBaseInfo(msgPBI);
				m_dataArrayPlayerData.push(TempDataPI);
			}
			if( msgPBI.m_PID == m_MyData.m_PID )
			{
				m_MyData.SetPlayerBaseInfo(msgPBI);
			}
		}
		
		private function OnPlayerLeaveTable(msgData:MsgData):void
		{
			var msgPLT:Game_PlayerLeaveTable = new Game_PlayerLeaveTable();
			msgPLT.Read(msgData);
			
			DebugLog("OnPlayerLeaveTable PID="+msgPLT.m_PID);
			
			var bFind:Boolean = false;
			var TempDataPI:Data_PlayerInfo;
			for(var i:int=0;i<m_dataArrayPlayerData.length;++i)
			{
				TempDataPI = m_dataArrayPlayerData[i];
				if( TempDataPI.m_PID == msgPLT.m_PID )
				{
					bFind = true;
					break;
				}
			}
			if( bFind )
			{
				m_dataArrayPlayerData.splice(i,1);	
			}
			else
			{
				DebugError("OnPlayerLeaveTable Can't Find");
			}
			if( msgPLT.m_PID == m_MyData.m_PID )
			{
				DebugError("OnPlayerLeaveTable 不能是本玩家");
			}
		}
		
		private function OnTableInfo(msgData:MsgData):void
		{
			var msgTI:L2C_TableInfo = new L2C_TableInfo();
			msgTI.Read(msgData);
			
			m_dataGameTable.SetData(msgTI);
			
			m_spTableInfo.visible = true;
			m_spTableInfo.m_tName.SetText("桌  子 : " + msgTI.m_TableName);
			m_spTableInfo.m_tBlind.SetText("盲  注 : " + msgTI.m_nSmallBlind + "/" + msgTI.m_nBigBlind);
			if( IsMatchTable() ){
				m_spTableInfo.m_tService.SetText("报名费 : " + msgTI.m_Ticket);
			}
			else{
				m_spTableInfo.m_tService.SetText("服务费 : " + msgTI.m_nServiceMoney);
			}		
			
			m_MaxSitPlayerCount = msgTI.m_MaxSitPlayer;
			
			var QuickTakeMoney:Number  = Math.min(Math.ceil(m_dataGameTable.m_nMaxTakeIn/2),Math.ceil(m_dataGameTable.m_nMinTakeIn));
			QuickTakeMoney				= Math.max(QuickTakeMoney,m_dataGameTable.m_nBigBlind*100);
			QuickTakeMoney				= Math.min(QuickTakeMoney,m_MyData.m_nGameMoney);
			m_spQuickStart.SetTakeMoney(QuickTakeMoney);
			
			for(var Sit:int=0;Sit<MaxPlayerOnTable;++Sit)
			{
				m_spArrayGamePlayerBoard[Sit].m_nChipTime = msgTI.m_nChipTime;
			}
		}
		
		private function OnRespPlayerAct(msgData:MsgData):void
		{
			var msgRespPA:Game_RespPlayerAct = new Game_RespPlayerAct();
			msgRespPA.Read(msgData);
			
			DebugLog("OnRespPlayerAct Flag="+msgRespPA.m_Flag+" Msg="+msgRespPA.m_strMsg);
		}
		private function OnPlayerAct(msgData:MsgData):void
		{
			var msgPA:Game_PlayerAct = new Game_PlayerAct();
			msgPA.Read(msgData);
		
			var ServerSit:int;
			var ClientSit:int;
			
			if( !IsRightSitID(msgPA.m_SitID) )
			{
				DebugError("OnPlayerAct msgPA.m_SitID",msgPA.m_SitID );
			}
			
			if( msgPA.m_Action == Game_PlayerAct.ACT_SITDOWN )
			{
				if( msgPA.m_TableID==m_MyData.m_TableID )
				{
					if( msgPA.m_PID == m_MyData.m_PID )
					{
						m_MyData.m_SitID = msgPA.m_SitID;
						m_btnStandUp.visible = true;
						
						m_mcMySitDown.ShowTime(1200);
						
						HideOperateArea();
						m_spMingYan.visible = true;						
					}
					else
					{
						
					}
					
					if( m_MyData.m_SitID==0 && GetEmptySitID()==0 )
					{
						HideOperateArea();
						m_spMingYan.visible = true;
					}
				}
				else
				{
					DebugError("OnPlayerAct SitDown msgPA.m_TableID",msgPA.m_TableID,m_MyData.m_TableID );
				}
			}
			else if( msgPA.m_Action == Game_PlayerAct.ACT_STANDUP )
			{
				if( msgPA.m_TableID==m_MyData.m_TableID )
				{
					if( msgPA.m_PID == m_MyData.m_PID )
					{
						DebugLog("玩家自己站起来 SitID="+msgPA.m_SitID);
						m_MyData.m_SitID = 0;
						m_btnStandUp.visible = false;
						
						var QuickTakeMoney:Number = Math.min(Math.ceil(m_dataGameTable.m_nMaxTakeIn/2),m_MyData.m_nGameMoney);
						m_spQuickStart.SetTakeMoney(QuickTakeMoney);
					}
					
					ServerSit = msgPA.m_SitID-1;
					var nChipMoney:Number = m_dataArrayGamePlayerInfo[ServerSit].m_ChipMoney;
					m_dataArrayGamePlayerInfo[ServerSit].Init();
					m_dataArrayGamePlayerInfo[ServerSit].m_ChipMoney = nChipMoney;
					
					UpdateSitIDPlayerBoard(msgPA.m_SitID);
					MotionGiveUpPai(msgPA.m_SitID);
					
					ClientSit = ServerSitIDToClientSit(msgPA.m_SitID);
					if(IsRightSit(ClientSit))
					{
						m_spArrayBigHandPai[ClientSit].visible = false;
					}
					
					if( m_MyData.m_SitID==0 && GetEmptySitID() )
					{						
						HideOperateArea();
						m_spQuickStart.visible = true;											
					}
				}
				else
				{
					DebugError("OnPlayerAct StandUp msgPA.m_TableID",msgPA.m_TableID,m_MyData.m_TableID );
				}
			}
			else
			{
				DebugError("OnPlayerAct Action="+msgPA.m_Action);
			}
		}
		
		private function OnLCFlag(msgData:MsgData):void
		{
			DebugLog("Client OnLCFlag ");
			var msgFlag:LC_Flag = new LC_Flag();
			msgFlag.Read(msgData);
			
			switch(msgFlag.m_Flag)
			{
				case LC_Flag.StartGame:
				{
					DebugLog("StartGame 启动客户端");
					
					InitClient();
					m_ClientState = DeZhouDef.ClientState_Gamming;
					m_WatchSitID = 5;
					
					m_bRelinkEnd = false;
					m_dataArrayPlayerData.length = 0;
					m_MyData.Copy(m_pLobby.m_MyData);
					m_pLobby.m_MyData.m_AutoRoomID = 0;
					m_pLobby.m_MyData.m_AutoTableID = 0;
					
					var TempMsgFlag:LC_Flag = new LC_Flag();
					TempMsgFlag.m_Flag = LC_Flag.GetMsg;
					SendMsgToLobby(TempMsgFlag);
				}
				break;
				case LC_Flag.CloseClient:
				{
					DebugLog("CloseClient ");
					this.m_ClientState = DeZhouDef.ClientState_Init;
					this.visible = false;
					
					m_dataArrayPlayerData.length = 0;
					var Sit:int;
					for(Sit=0;Sit<MaxPlayerOnTable;++Sit)
					{
						m_dataArrayGamePlayerInfo[Sit].Init();
					}
					for(Sit=0;Sit<MaxPlayerOnTable;++Sit)
					{
						m_spArrayGamePlayerBoard[Sit].visible = false;
						m_spArrayGamePlayerBoard[Sit].Init();
					}
					
					var MsgFlag:LC_Flag = new LC_Flag();
					MsgFlag.m_Flag = LC_Flag.ClientHide;
					SendMsgToLobby(MsgFlag);
				}
				break;
				default:
					DebugError("OnLCFlag MsgID="+msgData.m_msgID+" MsgLen="+msgData.m_msgLen);
			}
		}
		
		private function OnLogicMsg(msgData:MsgData):void
		{
			var msgSTCM:ServerToClientMessage = new ServerToClientMessage();
			msgSTCM.Read(msgData);
			msgSTCM.m_msgData.position = 0;
			
			var TempMsgData:MsgData = new MsgData();
			TempMsgData.m_msgID = msgSTCM.m_MsgID;
			TempMsgData.m_msgLen = msgSTCM.m_MsgLen;
			TempMsgData.WriteBytes(msgSTCM.m_msgData,msgSTCM.m_MsgLen);
			TempMsgData.ResetDataPosition();
			
			switch(TempMsgData.m_msgID)
			{
				case Logic_Start.ID:
				{
					OnLogicStart(TempMsgData);
				}
				break;
				case Logic_Relink.ID:
				{
					OnLogicReLink(TempMsgData);
				}
				break;
				case Logic_GamePlayerInfo.ID:
				{
					OnLogicGamePlayerInfo(TempMsgData);
				}
				break;
				case Logic_SitPlayerInfo.ID:
				{
					OnLogicSitPlayerInfo(TempMsgData);
				}
				break;
				case Logic_GameState.ID:
				{
					OnLogicGameState(TempMsgData);
				}
				break;
				case Logic_BankInfo.ID:
				{
					OnLogicBankInfo(TempMsgData);
				}
				break;
				case Logic_TableMoney.ID:
				{
					OnLogicTableMoney(TempMsgData);
				}
				break;
				case Logic_PlayerGameMoney.ID:
				{
					OnLogicPlayerGameMoney(TempMsgData);
				}
				break;
				case Logic_PromoteTime.ID:
				{
					OnLogicPromoteTime(TempMsgData);
				}
				break;
				case Logic_MoneyPool.ID:
				{
					OnLogicMoneyPool(TempMsgData);
				}
				break;
				case Logic_StartInfo.ID:
				{
					OnLogicStartGameInfo(TempMsgData);
				}
				break;
				case Logic_DezhouResult.ID:
				{
					OnLogicResultGame(TempMsgData);
				}
				break;
				case Logic_PlayerTurn.ID:
				{
					OnLogicPlayerTurn(TempMsgData);
				}
				break;
				case Logic_PlayerPower.ID:
				{
					OnLogicPlayerPower(TempMsgData);
				}
				break;
				case Logic_AddChipInfo.ID:
				{
					OnLogicAddChipInfo(TempMsgData);
				}
				break;
				case Logic_TablePai.ID:	
				{
					OnLogicTablePai(TempMsgData);
				}
				break;
				case Logic_TableChat.ID:
				{
					OnLogicTableChat(TempMsgData);
				}				
				break;
				case Logic_TableQuickChat.ID:
				{
					OnLogicTableQuickChat(TempMsgData);
				}
				break;
				case Logic_XieYiID.GameXYID_RespShowFace:
				{
					OnLogicShowFace(TempMsgData);
				}
				break;
				case Logic_AddMoneyInfo.ID:
				{
					OnLogicAddMoneyInfo(TempMsgData);
				}
				break;
				case Logic_WashOutPlayerInfo.ID:
				{
					OnLogicWashOutPlayerInfo(TempMsgData);
				}
				break;
				case Logic_MatchBlind.ID:
				{
					OnLogicMatchBlind(TempMsgData);
				}
				break;
				case Logic_MatchResult.ID:
				{
					OnLogicMatchResult(TempMsgData);
				}
				break;
				case Logic_RespSendGift.ID:
				{
					OnLogicRespSendGift(TempMsgData);
				}
				break;
				
				//以下是未处理的消息
				case Logic_JoinJuBaoPeng.ID:
				
				case Logic_GamePlayerInfo.ID:
				{
					DebugLog("有消息未处理 ID="+TempMsgData.m_msgID);
				}
				break;
				default:
					DebugError("OnLogicMsg MsgID="+TempMsgData.m_msgID+" MsgLen="+TempMsgData.m_msgLen);
			}
		}
		
		private function OnLogicMatchResult(msgdata:MsgData):void
		{
			var msgMR:Logic_MatchResult = new Logic_MatchResult();
			msgMR.Read(msgdata);
			
			this.DebugError("OnLogicMatchResult");
			
		}
		
		private function OnLogicMatchBlind(msgdata:MsgData):void
		{
			var msgMB:Logic_MatchBlind = new Logic_MatchBlind();
			msgMB.Read(msgdata);
			
			m_spTableInfo.m_tBlind.text ="盲  注 : " + msgMB.m_SmallBlind + "/" + msgMB.m_BigBlind;
			if( m_bRelinkEnd )
			{
				DebugError("比赛中更新盲注");
			}
		}
		
		private function OnLogicWashOutPlayerInfo(msgdata:MsgData):void
		{
			var msgWOPI:Logic_WashOutPlayerInfo = new Logic_WashOutPlayerInfo();
			msgWOPI.Read(msgdata);
			
			var ServerSit:int = 0;
			if( IsRightSitID(msgWOPI.m_SitID) )
			{
				ServerSit = msgWOPI.m_SitID - 1;
				var dataGPI:Data_GamePlayer = m_dataArrayGamePlayerInfo[ServerSit];
				
				dataGPI.m_PID              = msgWOPI.m_PID;
				dataGPI.m_NickName         = msgWOPI.m_NickName;
				dataGPI.m_HeadPicURL       = msgWOPI.m_HeadPicURL;
				dataGPI.m_PlayerGameState  = DeZhouDef.GAME_PLAYER_ST_WASHOUT;
				dataGPI.m_MatchRank        = msgWOPI.m_Position;
				
				UpdateSitIDPlayerBoard(msgWOPI.m_SitID);
			}
		}
		
		private function OnLogicAddMoneyInfo(msgdata:MsgData):void
		{
			var msgAMI:Logic_AddMoneyInfo = new Logic_AddMoneyInfo();
			msgAMI.Read(msgdata);
			
			if( msgAMI.m_Flag == Logic_AddMoneyInfo.SUCCESS )
			{
				var ServerSit:int = m_MyData.m_SitID - 1;
				var dataGP:Data_GamePlayer = m_dataArrayGamePlayerInfo[ServerSit];
				
				UpdatePlayerTableMoney(m_MyData.m_SitID,msgAMI.m_TableMoney,true);
				UpdatePlayerGameMoney(dataGP.m_PID,msgAMI.m_GameMoney);
			}
			else
			{				
				var strChat:String = "";
				if( msgAMI.m_Flag == Logic_AddMoneyInfo.OUTMONEY )
				{
					strChat = "游戏币不足，不能补充";
				}
				else if( msgAMI.m_Flag == Logic_AddMoneyInfo.PLAYING )
				{
					strChat = "您不需要补充游戏币";
				}
				else if( msgAMI.m_Flag == Logic_AddMoneyInfo.PLAYING )
				{
					strChat = "您正在游戏中，不能补充游戏币";
				}
				else if( msgAMI.m_Flag == Logic_AddMoneyInfo.MATCH )
				{
					strChat = "您正在比赛中，不能补充游戏币";
				}
				if( strChat != "" )
				{
					AddChatMsg(DeZhouDef.ChatFlag_Sys,0,"系统",strChat);
				}				
			}
		}		
		private function OnLogicShowFace(msgdata:MsgData):void
		{			
			var msgSF:Logic_RespShowFace = new Logic_RespShowFace();
			msgSF.Read(msgdata);
			
			DebugLog("OnLogicShowFace",msgSF.m_SitID,msgSF.m_FaceID,msgSF.m_PayMoney,msgSF.m_TableMoney);
			
			var ClientSit:int = ServerSitIDToClientSit(msgSF.m_SitID);
			if( IsRightSit(ClientSit) )
			{
				m_spArrayFace[ClientSit].ShowFace(msgSF.m_FaceID,3000);
			}
		}
		
		private function OnLogicTableQuickChat(msgdata:MsgData):void
		{
			DebugLog("OnLogicTableQuickChat");
			var msgTC:Logic_TableQuickChat = new Logic_TableQuickChat();
			msgTC.Read(msgdata);
			
			var dataGPI:Data_PlayerInfo = GetPlayerInfoByPID(msgTC.m_PID);
			var TempChat:String = m_GameConfig.GetWordByIdx(msgTC.m_Idx);
			if( dataGPI!=null && TempChat!="" )
			{
				AddChatMsg(DeZhouDef.ChatFlag_Player,msgTC.m_PID,dataGPI.m_NickName,TempChat);
			}
			else
			{
				DebugError("OnLogicTableQuickChat PID="+msgTC.m_PID+" Idx="+msgTC.m_Idx);
			}
		}
		private function OnLogicTableChat(msgdata:MsgData):void
		{
			DebugLog("OnLogicTableChat");
			var msgTC:Logic_TableChat = new Logic_TableChat();
			msgTC.Read(msgdata);
			
			var dataGPI:Data_GamePlayer = GetGamePlayerInfoByPID(msgTC.m_PID);
			if( dataGPI ){
				var ClientSit:int = ServerSitIDToClientSit(dataGPI.m_SitID);
				m_spArrayChatPao[ClientSit].ShowChatMsg(msgTC.m_strChat,3000);
			}
			
			var dataPI:Data_PlayerInfo = GetPlayerInfoByPID(msgTC.m_PID);
			if( dataPI != null ){				
				AddChatMsg(DeZhouDef.ChatFlag_Player,msgTC.m_PID,dataPI.m_NickName,msgTC.m_strChat);
			}
			else{
				DebugError("OnLogicTableChat PID="+msgTC.m_PID);
			}
		}
		private function OnLogicTablePai(msgdata:MsgData):void
		{
			DebugLog("OnLogicTablePai");
			var msgTP:Logic_TablePai = new Logic_TablePai();
			msgTP.Read(msgdata);
			
			for(var i:int=0;i<5;++i)
			{
				m_dataGameTable.m_TablePai[i] = msgTP.m_arrayTablePai[i];
			}
			
			m_spTablePai.visible = true;
			m_spTablePai.SetTablePai(msgTP.m_arrayTablePai);
		}
		private function OnLogicAddChipInfo(msgdata:MsgData):void
		{
			var msgACI:Logic_AddChipInfo = new Logic_AddChipInfo();
			msgACI.Read(msgdata);
			
			DebugLog("OnLogicAddChipInfo",msgACI.m_CurPlayerSitID,msgACI.m_ChipAction,msgACI.m_nCurChipMoney,msgACI.m_nTableMoney);
			
			if( IsRightSitID(msgACI.m_CurPlayerSitID) )
			{
				var ServerSit:int = msgACI.m_CurPlayerSitID - 1;
				var ClientSit:int = ServerSitIDToClientSit(msgACI.m_CurPlayerSitID);
				if( IsRightSit(ClientSit) )
				{
					var dataGP:Data_GamePlayer = m_dataArrayGamePlayerInfo[ServerSit];
					var AddChip:Number      = msgACI.m_nCurChipMoney - dataGP.m_ChipMoney;
					var nCurChipMoney:Number= msgACI.m_nCurChipMoney;
					var dataCM:Data_ChatMsg = new Data_ChatMsg();
					
					dataCM.m_Flag         = DeZhouDef.ChatFlag_HeGuan;
					dataCM.m_PID          = dataGP.m_PID;
					dataCM.m_Name         = dataGP.m_NickName;
					dataCM.m_PID          = 1;
					
					if( msgACI.m_ChipAction == DeZhouDef.ACTION_AllIn
					    || msgACI.m_ChipAction==DeZhouDef.ACTION_Chip
						|| msgACI.m_ChipAction==DeZhouDef.ACTION_Follow
					    || msgACI.m_ChipAction == DeZhouDef.ACTION_AddChip )
					{
						if( AddChip > 0 )
						{
							MotionAddChip(msgACI.m_CurPlayerSitID,ClientSit,AddChip);
						}						
					}
					
					if( msgACI.m_ChipAction == DeZhouDef.ACTION_AllIn )
					{
						dataGP.m_PlayerGameState = DeZhouDef.GAME_PLAYER_ST_ALLIN;
						m_sdAllIn.play();
						
						dataCM.m_Msg = "全下 " + "$" + GlobleFunc.MoneyToString(nCurChipMoney);
					}
					else if( msgACI.m_ChipAction==DeZhouDef.ACTION_Chip )
					{
						m_sdChip.play();
						dataCM.m_Msg = "下注 " + "$" + GlobleFunc.MoneyToString(nCurChipMoney);
					}
					else if( msgACI.m_ChipAction==DeZhouDef.ACTION_Follow )
					{
						m_sdChip.play();
						dataCM.m_Msg = "跟注 " + "$" + GlobleFunc.MoneyToString(nCurChipMoney);
					}
					else if( msgACI.m_ChipAction == DeZhouDef.ACTION_AddChip )
					{
						m_sdRaise.play();
						dataCM.m_Msg = "加注 " + "$" + GlobleFunc.MoneyToString(nCurChipMoney);
					}
					else if( msgACI.m_ChipAction == DeZhouDef.ACTION_GiveUp )
					{
						dataGP.m_PlayerGameState = DeZhouDef.GAME_PLAYER_ST_GIVEUP;
						dataGP.m_arrayHandPai[0] = dataGP.m_arrayHandPai[1] = 0;
						m_spArrayBigHandPai[ClientSit].visible = false;
						MotionGiveUpPai(msgACI.m_CurPlayerSitID);
						
						dataCM.m_Msg = "弃牌 ";
					}
					else if( msgACI.m_ChipAction == DeZhouDef.ACTION_KanPai )
					{
						m_sdCheck.play();
						dataCM.m_Msg = "看牌 ";
					}
					m_spHeGuanDialog.AddChatLog(dataCM);
					
					dataGP.m_ChipMoney  = msgACI.m_nCurChipMoney;
					dataGP.m_TableMoney = msgACI.m_nTableMoney;
					dataGP.m_Action     = msgACI.m_ChipAction;
					
					if( msgACI.m_nCurChipMoney > m_dataGameTable.m_MaxChipOnTable )
					{
						var nAddMoney:Number = msgACI.m_nCurChipMoney - m_dataGameTable.m_MaxChipOnTable;
						m_dataGameTable.m_MaxChipOnTable = msgACI.m_nCurChipMoney;
						if( nAddMoney > m_dataGameTable.m_MinAddChip )
						{
							m_dataGameTable.m_MinAddChip = nAddMoney;
						}
					}
					
					var spGPB:GamePlayerBoard = m_spArrayGamePlayerBoard[ClientSit];
					spGPB.m_EndTurnTime = 0;
					spGPB.m_spDaoJiShi.visible = false;						
					spGPB.SetAction(dataGP.m_Action);
					spGPB.SetTableMoney(dataGP.m_TableMoney);
					
					if( msgACI.m_CurPlayerSitID == m_MyData.m_SitID )
					{
						if( ClientSit != 0 )
						{
							DebugError("OnAddChipInfo MySitID="+m_MyData.m_SitID,msgACI.m_CurPlayerSitID,ClientSit);
						}
						m_spOperatorBoard.Hide();
					}
					else
					{
						if( IsRightSitID(m_MyData.m_SitID) )
						{
							var MySit:int = m_MyData.m_SitID - 1;
							var MyData:Data_GamePlayer = m_dataArrayGamePlayerInfo[MySit];
							if( MyData.IsPlaying() )
							{
								HideOperateArea();
								ShowPreChipBoard();
							}
							else
							{
								m_spMingYan.visible = true;
							}							
						}
					}
				}
				else
				{
					DebugError("OnAddChipInfo ClientSit=" + ClientSit);
				}
			}
			else
			{
				DebugError("OnAddChipInfo CurPlayerSitID=" + msgACI.m_CurPlayerSitID);
			}
		}
		
		private function OnLogicPlayerPower(msgdata:MsgData):void
		{
			var msgPP:Logic_PlayerPower = new Logic_PlayerPower();
			msgPP.Read(msgdata);
			
			DebugLog("OnLogicPlayerTurn 轮到自己",msgPP.m_ActionFlag,msgPP.m_nMaxChip,msgPP.m_nMinAddChip,msgPP.m_nTopChip);	
			
			if( IsRightSitID(m_MyData.m_SitID) )
			{
				var dataGPI:Data_GamePlayer = m_dataArrayGamePlayerInfo[m_MyData.m_SitID-1];
				
				if( m_spPreOperateBoard.IsSelect() )
				{
					var reqAC:Logic_ReqAddChip = new Logic_ReqAddChip();
					reqAC.m_CurPlayerSitID        = m_MyData.m_SitID;
					
					var nAction:int         = m_spPreOperateBoard.m_Action;
					var nSelectMoney:Number = m_spPreOperateBoard.m_nMoney;
					var nGameMoney:Number   = dataGPI.m_ChipMoney + dataGPI.m_TableMoney;
					
					if( nAction == CPreOperateBoard.Action_KanPai 
						|| nAction == CPreOperateBoard.Action_KanOrPass )
					{
						reqAC.m_ChipAction            = DeZhouDef.ACTION_KanPai;
						reqAC.m_nCurChipMoney         = 0;
					}
					else if( nAction == CPreOperateBoard.Action_FollowAny )
					{
						reqAC.m_ChipAction            = DeZhouDef.ACTION_Follow;
						reqAC.m_nCurChipMoney         = Math.min(m_dataGameTable.m_MaxChipOnTable,nGameMoney);	
					}
					else if( nAction == CPreOperateBoard.Action_Follow )
					{
						reqAC.m_ChipAction            = DeZhouDef.ACTION_Follow;
						reqAC.m_nCurChipMoney         = m_spPreOperateBoard.m_nMoney;
					}
					SendLogicMsg(reqAC);
					m_spPreOperateBoard.Hide();
				}
				else
				{
					HideOperateArea();
					m_spPreOperateBoard.Hide();
					
					var dataSCB:Data_ShowChipBoard = new Data_ShowChipBoard();
					dataSCB.m_MaxChipOnTable     = msgPP.m_nMaxChip;
					dataSCB.m_MinAddChip         = msgPP.m_nMinAddChip;
					dataSCB.m_TopCanChip         = msgPP.m_nTopChip;
					dataSCB.m_ChipMoney          = dataGPI.m_ChipMoney;
					dataSCB.m_TableMoney         = dataGPI.m_TableMoney;
					dataSCB.m_nBigBlind          = m_dataGameTable.m_nBigBlind;
					
					m_spOperatorBoard.Show(dataSCB);
				}
			}
			else
			{
				DebugError("OnLogicPlayerPower MySit=0");
			}
		}
		
		private function OnLogicPlayerTurn(msgdata:MsgData):void
		{
			DebugLog("OnLogicPlayerTurn");
			var msgPT:Logic_PlayerTurn = new Logic_PlayerTurn();
			msgPT.Read(msgdata);		
			
			var ClientSit:int = ServerSitIDToClientSit(msgPT.m_SitID);
			if( IsRightSit(ClientSit) )
			{
				m_spArrayGamePlayerBoard[ClientSit].m_EndTurnTime = getTimer() + msgPT.m_LeftTime*1000;
				m_spArrayGamePlayerBoard[ClientSit].m_spDaoJiShi.visible = true;
				
				m_dataGameTable.m_CurPlayerSitID = msgPT.m_SitID;
				if( m_spTurnLight.visible )
				{
					m_spTurnLight.MoveToByTime(m_roTurnLight[ClientSit],0.4);
				}
				else
				{
					m_spTurnLight.visible = true;
					m_spTurnLight.rotation = m_roTurnLight[ClientSit];
				}
				
				for(var TempSit:int=0;TempSit<MaxPlayerOnTable;++TempSit)
				{
					if( TempSit != ClientSit )
					{
						m_spArrayGamePlayerBoard[TempSit].m_EndTurnTime = 0;
						m_spArrayGamePlayerBoard[TempSit].m_spDaoJiShi.visible = false;
					}
				}
			}
		}
		private function OnLogicStartGameInfo(msgdata:MsgData):void
		{
			DebugLog("OnLogicStartGameInfo 游戏开始");
			
			var msgSI:Logic_StartInfo = new Logic_StartInfo();
			msgSI.Read(msgdata);
			
			var dataCM:Data_ChatMsg = new Data_ChatMsg();
			dataCM.m_Flag   = DeZhouDef.ChatFlag_HeGuan;
			dataCM.m_Name   = "";
			dataCM.m_Msg    = "游戏开始";
			dataCM.m_PID    = 2;
			m_spHeGuanDialog.AddChatLog(dataCM);
			
			m_FaPaiTime = 1;
			m_dataGameTable.m_StartPlayer = msgSI.m_nPlayerCount;
			m_dataGameTable.m_MinAddChip  = m_dataGameTable.m_nBigBlind;
			
			var nTempMaxChip:Number = 0;
			
			var ServerSit:int = 0;
			var ClientSit:int = 0;
			var dataGPI:Data_GamePlayer;
			
			for(var i:int=0;i<msgSI.m_nPlayerCount;++i)
			{
				var msgSPI:Logic_msgStartPlayerInfo = msgSI.m_arrayPlayerInfo[i];
				if( IsRightSitID(msgSPI.m_SitID) )
				{
					ServerSit = msgSPI.m_SitID - 1;
					dataGPI = m_dataArrayGamePlayerInfo[ServerSit];
					
					dataCM.Init();
					dataCM.m_PID    = dataGPI.m_PID;
					dataCM.m_Flag   = DeZhouDef.ChatFlag_HeGuan;
					dataCM.m_Name   = dataGPI.m_NickName;
					if( msgSPI.m_SitID == m_dataGameTable.m_SmallBlindSitID )
					{
						dataCM.m_Msg    = "下小盲注 "+"$"+GlobleFunc.MoneyToString(dataGPI.m_ChipMoney);						
					}
					else if( msgSPI.m_SitID == m_dataGameTable.m_BigBlindSitID )
					{
						dataCM.m_Msg    = "下大盲注 "+"$"+GlobleFunc.MoneyToString(dataGPI.m_ChipMoney);
					}
					else if( dataGPI.m_ChipMoney > 0 )
					{
						dataCM.m_Msg    = "下底 "+"$"+GlobleFunc.MoneyToString(dataGPI.m_ChipMoney);
					}
					if( dataGPI.m_ChipMoney > 0 )
					{
						m_spHeGuanDialog.AddChatLog(dataCM);
					}
					
					if( msgSPI.m_Action )
					{
						dataGPI.m_Action           = msgSPI.m_Action;
					}
					else
					{
						dataGPI.m_Action           = DeZhouDef.ACTION_WaitChip;
					}
					dataGPI.m_arrayHandPai[0]  = msgSPI.m_arrayHandPai[0];
					dataGPI.m_arrayHandPai[1]  = msgSPI.m_arrayHandPai[1];
					dataGPI.m_ChipMoney        = msgSPI.m_nChip;
					dataGPI.m_TableMoney       = msgSPI.m_nTableMoney;
					
					if( msgSPI.m_nChip > nTempMaxChip)
					{
						nTempMaxChip = msgSPI.m_nChip;
					}
					
					dataGPI.m_PlayerGameState = DeZhouDef.GAME_PLAYER_ST_PLAYING;
					if( dataGPI.m_Action == DeZhouDef.ACTION_AllIn )
					{
						dataGPI.m_PlayerGameState = DeZhouDef.GAME_PLAYER_ST_ALLIN;
					}
					
					ClientSit = ServerSitIDToClientSit(msgSPI.m_SitID);
					if( IsRightSit(ClientSit) )
					{
						var spGPB:GamePlayerBoard = m_spArrayGamePlayerBoard[ClientSit];
						spGPB.SetAction(dataGPI.m_Action);
						spGPB.SetTableMoney(dataGPI.m_TableMoney);
						
						if( dataGPI.m_ChipMoney > 0 )
						{
							MotionAddChip(msgSPI.m_SitID,ClientSit,dataGPI.m_ChipMoney);
							m_sdChip.play();
						}
					}
					else
					{
						DebugLog("OnLogicStartGameInfo SitID="+msgSPI.m_SitID);
					}
				}				
			}
			m_dataGameTable.m_MaxChipOnTable = nTempMaxChip;
			
			if( IsRightSitID(m_MyData.m_SitID) )
			{
				var MySit:int = m_MyData.m_SitID - 1;
				var MyData:Data_GamePlayer = m_dataArrayGamePlayerInfo[MySit];
				if( MyData.IsPlaying() )
				{
					HideOperateArea();
					ShowPreChipBoard();
				}
			}			
		}
		private function OnLogicResultGame(msgdata:MsgData):void
		{
			DebugLog("OnLogicResultGame 游戏结束");
			
			m_msgResult.Init();
			m_msgResult.Read(msgdata);
			
			var ServerSit:int;
			var ClientSit:int;
			
			m_spTurnLight.visible = false;
			
			if( m_msgResult.m_MoneyPoolCount != m_dataGameTable.m_MoneyPoolCount )
			{
				DebugError("OnLogicResultGame PoolCount", m_msgResult.m_MoneyPoolCount,m_dataGameTable.m_MoneyPoolCount );
			}
			
			for(var TempSit:int=0;TempSit<MaxPlayerOnTable;++TempSit)
			{
				m_spArrayGamePlayerBoard[TempSit].m_EndTurnTime = 0;
				m_spArrayGamePlayerBoard[TempSit].m_spDaoJiShi.visible = false;
			}
			
			m_DivideTime = getTimer();
			
			var bShowWinMotion:Boolean = false;
			for(var Idx:int=0;Idx<m_msgResult.m_PlayerCount;++Idx)
			{
				var msgRP:Logic_msgResultPai = 	m_msgResult.m_arrayPlayerHandPai[Idx];
				if( IsRightSitID(msgRP.m_SitID) )
				{
					ServerSit = msgRP.m_SitID - 1;
					var dataGPI:Data_GamePlayer = m_dataArrayGamePlayerInfo[ServerSit];
					if( msgRP.m_SitID == dataGPI.m_SitID )
					{
						dataGPI.m_arrayHandPai[0] = msgRP.m_arrayHandPai[0];
						dataGPI.m_arrayHandPai[1] = msgRP.m_arrayHandPai[1];
						
						dataGPI.m_PaiType         = msgRP.m_PaiType;
						dataGPI.m_bWin            = msgRP.m_bWin;
						
						if( dataGPI.m_SitID==m_MyData.m_SitID && dataGPI.m_bWin==1 && bShowWinMotion==false )
						{
							bShowWinMotion = true;
							
							m_spWinMotion.visible = true;
							m_spWinMotion.scaleX = 0.1;
							m_spWinMotion.scaleY = 0.1;
							m_spWinMotion.SetScaleCenter(new Point(500,180));
							m_spWinMotion.ScaleByTime(1,1,0.4,true);
							m_spWinMotion.ShowTime(m_msgResult.m_MoneyPoolCount*2000);
						}
						
						for(var i:int=0;i<5;++i)
						{
							dataGPI.m_WinPaiType[i] = msgRP.m_arrayPai[i];
						}						
						ClientSit = ServerSitIDToClientSit(msgRP.m_SitID);
						if(IsRightSit(ClientSit))
						{
							var spBHP:BigHandPai = m_spArrayBigHandPai[ClientSit];
							spBHP.SetHandPai(dataGPI.m_arrayHandPai[0],dataGPI.m_arrayHandPai[1]);
							spBHP.visible = true;
						}
					}
					else
					{
						DebugError("OnLogicResultGame msgRP.m_SitID="+msgRP.m_SitID+" dataGPI.m_SitID"+dataGPI.m_SitID);
					}
				}
				else
				{
					DebugError("OnLogicResultGame SitID="+msgRP.m_SitID);
				}		
			}			
		}
		
		private function OnLogicMoneyPool(msgdata:MsgData):void
		{
			var msgMP:Logic_MoneyPool = new Logic_MoneyPool();
			msgMP.Read(msgdata);
			
			DebugLog("OnLogicMoneyPool PoolCount="+msgMP.m_MoneyPoolCount);
			
			var i:int=0;
			for(i=0;i<MaxPlayerOnTable;++i)
			{
				if( i < msgMP.m_MoneyPoolCount )
					m_dataGameTable.m_MoneyPool[i] = msgMP.m_arrayMoneyPool[i];
				else
					m_dataGameTable.m_MoneyPool[i] = 0;
			}
			m_dataGameTable.m_MoneyPoolCount = msgMP.m_MoneyPoolCount;
			
			UpdateMoneyPool();
		}
		
		private function OnLogicPromoteTime(msgdata:MsgData):void
		{
			var msgPT:Logic_PromoteTime = new Logic_PromoteTime();
			msgPT.Read(msgdata);
			
			DebugLog("OnLogicPromoteTime",msgPT.m_Step,msgPT.m_LeftTime,msgPT.m_AwardMoney);
		}
		
		private function OnLogicPlayerGameMoney(msgdata:MsgData):void	
		{
			var msgPGM:Logic_PlayerGameMoney = new Logic_PlayerGameMoney();
			msgPGM.Read(msgdata);
			
			DebugLog("OnLogicPlayerGameMoney",msgPGM.m_SitID,msgPGM.m_nGameMoney);
			
			var ServerSit:int = msgPGM.m_SitID - 1;
			var PID:int = m_dataArrayGamePlayerInfo[ServerSit].m_PID;
			var data_PI:Data_PlayerInfo = GetPlayerInfoByPID(PID);
			if( data_PI )
			{
				data_PI.m_nGameMoney = msgPGM.m_nGameMoney;
			}
		}		
		private function OnLogicTableMoney(msgdata:MsgData):void
		{
			var msgTM:Logic_TableMoney = new Logic_TableMoney();
			msgTM.Read(msgdata);
			
			DebugLog("OnLogicTableMoney",msgTM.m_SitID,msgTM.m_nTableMoney);
			
			if( IsRightSitID(msgTM.m_SitID) )
			{
				UpdatePlayerTableMoney(msgTM.m_SitID,msgTM.m_nTableMoney,true);
			}
			else
			{
				DebugError("OnLogicTableMoney m_SitID="+msgTM.m_SitID,msgTM.m_nTableMoney);
			}
		}
		private function OnLogicBankInfo(msgdata:MsgData):void
		{
			var msgBI:Logic_BankInfo = new Logic_BankInfo();
			msgBI.Read(msgdata);
			
			DebugLog("OnLogicBankInfo",msgBI.m_BankerSitID,msgBI.m_BigBlindSitID,msgBI.m_SmallBlindSitID);
			
			m_dataGameTable.m_BankerSitID     = msgBI.m_BankerSitID;
			m_dataGameTable.m_BigBlindSitID   = msgBI.m_BigBlindSitID;
			m_dataGameTable.m_SmallBlindSitID = msgBI.m_SmallBlindSitID;
			
			if( m_bRelinkEnd )
			{
				UpdateBankerInfo();
			}
		}
		
		private function OnLogicRespSendGift(msgdata:MsgData):void
		{
			var msgSG:Logic_RespSendGift = new Logic_RespSendGift();
			msgSG.Read(msgdata);
			
			DebugLog("OnLogicRespSendGift ",msgSG.m_GiftID,msgSG.m_SendPID,msgSG.m_vecToPID.toString());
			
		}
		
		private function OnLogicGameState(msgdata:MsgData):void
		{
			var msgGS:Logic_GameState = new Logic_GameState();
			msgGS.Read(msgdata);
			
			m_dataGameTable.m_GameState = msgGS.m_GameST;
			
			switch( msgGS.m_GameST )
			{
				case DeZhouDef.GAME_ST_NONE:
					 DebugLog("OnLogicGameState None");
					break;
				case DeZhouDef.GAME_ST_WAIT:
					DebugLog("OnLogicGameState Wait");
					break;
				case DeZhouDef.GAME_ST_HAND:
					DebugLog("OnLogicGameState HandPai");
					break;
				case DeZhouDef.GAME_ST_FLOP:					
					OnLogicFlop();
					break;
				case DeZhouDef.GAME_ST_TURN:					
					OnLogicTurn();
					break;
				case DeZhouDef.GAME_ST_RIVER:					
					OnLogicRiver();
					break;
				case DeZhouDef.GAME_ST_DIVIDEMONEY:					
					OnLogicDivide();
					break;
				case DeZhouDef.GAME_ST_END:					
					OnLogicGameEnd();
					break;
				default:
					DebugError("OnLogicGameState GameState="+msgGS.m_GameST);
			}
		}		
		private function OnLogicFlop():void
		{
			DebugLog("OnLogicGameState Flop");
			MoveChipMoneyToPool();
			InitGameTurn();
		}
		private function OnLogicTurn():void
		{
			DebugLog("OnLogicGameState Turn");
			MoveChipMoneyToPool();
			InitGameTurn();
		}
		private function OnLogicRiver():void
		{
			DebugLog("OnLogicGameState River");
			MoveChipMoneyToPool();
			InitGameTurn();
		}
		private function OnLogicDivide():void
		{
			DebugLog("OnLogicGameState DivideMoney");
			MoveChipMoneyToPool();
		}
		private function OnLogicGameEnd():void
		{
			DebugLog("OnLogicGameState End");	
			InitGameData();
			
			var ServerSit:int;
			var ClientSit:int;
			
			var dataCM:Data_ChatMsg = new Data_ChatMsg();
			dataCM.m_Flag   = DeZhouDef.ChatFlag_HeGuan;
			dataCM.m_Name   = "";
			dataCM.m_Msg    = "游戏结束\n--------------------------";
			dataCM.m_PID    = 2;
			m_spHeGuanDialog.AddChatLog(dataCM);
			
			for(ServerSit=0;ServerSit<MaxPlayerOnTable;++ServerSit)
			{
				var dataPI:Data_GamePlayer = m_dataArrayGamePlayerInfo[ServerSit];
				if( dataPI.IsSitPlayer() )
				{
					ClientSit = ServerSitIDToClientSit(ServerSit+1);
					if( IsRightSit(ClientSit) )
					{
						dataPI.m_PlayerGameState = DeZhouDef.GAME_PLAYER_ST_WAITING;
						dataPI.m_Action          = DeZhouDef.ACTION_NONE;
						m_spArrayGamePlayerBoard[ClientSit].SetAction(dataPI.m_Action);
					}
				}
			}
		}
		
		private function InitGameTurn():void
		{
			var ServerSit:int;
			var ClientSit:int;
			if( m_dataGameTable.IsGamePlaying() )
			{
				for(ServerSit=0;ServerSit<MaxPlayerOnTable;++ServerSit)
				{
					var dataPI:Data_GamePlayer = m_dataArrayGamePlayerInfo[ServerSit];
					if( dataPI.IsSitPlayer() )
					{						
						if( dataPI.IsPlaying() )
						{
							ClientSit = ServerSitIDToClientSit(ServerSit+1);
							if( IsRightSit(ClientSit) )
							{
								dataPI.m_Action = DeZhouDef.ACTION_WaitChip;
								m_spArrayGamePlayerBoard[ClientSit].SetAction(dataPI.m_Action);
							}
						}
					}
				}
			}
			
			m_dataGameTable.m_MaxChipOnTable = 0;
			m_dataGameTable.m_MinAddChip = m_dataGameTable.m_nBigBlind;
		}
		private function MoveChipMoneyToPool():void
		{
			if( m_dataGameTable.m_GameState>=DeZhouDef.GAME_ST_FLOP && m_dataGameTable.m_GameState<=DeZhouDef.GAME_ST_DIVIDEMONEY )
			{
				var ServerSit:int;
				var ClientSit:int;
				var bHaveFlag:Boolean = false; //是否定义结束的堆
				var PoolIdx:int = 0;
				
				for(ClientSit=0;ClientSit<MaxPlayerOnTable;++ClientSit)
				{
					if(m_dataGameTable.m_MoneyPool[ClientSit]>0)
					{
						PoolIdx = ClientSit;
					}
				}				
				for(ClientSit=0;ClientSit<MaxPlayerOnTable;++ClientSit)
				{
					m_spArrayAddMoney[ClientSit].EndMoving();
					m_spArrayAddMoney[ClientSit].visible = false;
				}
				for(ServerSit=0;ServerSit<MaxPlayerOnTable;++ServerSit)
				{
					if( m_dataArrayGamePlayerInfo[ServerSit].m_ChipMoney>0 )
					{
						ClientSit = ServerSitIDToClientSit(ServerSit+1);
						if( IsRightSit(ClientSit) )
						{
							var spChipMoney:CMoneyMotion = m_spArrayChipMoney[ClientSit];
							spChipMoney.Money = m_dataArrayGamePlayerInfo[ServerSit].m_ChipMoney;
							spChipMoney.m_MoneyFlag = CMoneyMotion.Flag_ChipToPool;
							spChipMoney.m_ServerStartSitID = ServerSit+1;
							if( !bHaveFlag )
							{
								bHaveFlag = true;
								spChipMoney.m_ServerEndSitID = MaxPlayerOnTable;
							}
							else
							{
								spChipMoney.m_ServerEndSitID = 0;
							}
							spChipMoney.MoveToPointByTime(m_ptMoneyPool[PoolIdx],0.5);
							
							m_dataArrayGamePlayerInfo[ServerSit].m_ChipMoney = 0;
						}
						else
						{
							DebugError("MoveChipMoneyToPool ServerSit="+ServerSit,ClientSit);
						}
					}
				}
			}
			else
			{
				DebugError("MoveChipMoneyToPool GameState="+m_dataGameTable.m_GameState);
			}
		}
		
		private function OnLogicGamePlayerInfo(msgdata:MsgData):void
		{
			var msgGPI:Logic_GamePlayerInfo = new Logic_GamePlayerInfo();
			msgGPI.Read(msgdata);
			
			DebugLog("OnLogicGamePlayerInfo",msgGPI.m_nPlayerCount);
			
			for(var i:int=0;i<msgGPI.m_arrayPlayerInfo.length;++i)
			{
				var TempGPI:Logic_msgGamePlayerInfo = msgGPI.m_arrayPlayerInfo[i];				
				if( IsRightSitID(TempGPI.m_SitID) )
				{
					var Sit:int = TempGPI.m_SitID - 1;
					if( !m_dataArrayGamePlayerInfo[Sit].IsEmpty() )
					{
						m_dataArrayGamePlayerInfo[Sit].SetGamePlayerInfo(TempGPI);
					}
					else
					{
						DebugError("OnLogicGamePlayerInfo No Sit Player SitID="+TempGPI.m_SitID);
					}
				}
				else
				{
					DebugError("OnLogicGamePlayerInfo SitID="+TempGPI.m_SitID);
				}				
			}
		}
		
		private function OnLogicSitPlayerInfo(msgdata:MsgData):void
		{
			var msgSPI:Logic_SitPlayerInfo = new Logic_SitPlayerInfo();
			msgSPI.Read(msgdata);
			
			DebugLog("OnLogicSitPlayerInfo",msgSPI.m_SitID,msgSPI.m_PID);
			
			GlobleData.SetSitPlayerInfo(msgSPI);
			var TempPI:Data_PlayerInfo = GetPlayerInfoByPID(msgSPI.m_PID);
			if( TempPI != null )
			{
				if( IsRightSitID(msgSPI.m_SitID) )
				{
					var Sit:int = msgSPI.m_SitID - 1;
					if( m_dataArrayGamePlayerInfo[Sit].IsEmpty() )
					{
						m_dataArrayGamePlayerInfo[Sit].SetBaseInfo(TempPI);
						m_dataArrayGamePlayerInfo[Sit].SetSitPlayerInfo(msgSPI);
						
						m_dataArrayGamePlayerInfo[Sit].m_PlayerGameState = DeZhouDef.GAME_PLAYER_ST_WAITING;
						
						if( msgSPI.m_PID == m_MyData.m_PID )
						{
							m_WatchSitID = msgSPI.m_SitID;
							if( m_bRelinkEnd )
							{
								UpdateClient();
							}
						}
						else
						{
							if( m_bRelinkEnd )
							{
								UpdateSitIDPlayerBoard(msgSPI.m_SitID);
							}
						}
					}
					else
					{
						DebugError("OnLogicSitPlayerInfo HavePlayer PID="+msgSPI.m_PID+" SitID="+msgSPI.m_SitID);
					}
				}
				else
				{
					DebugError("OnLogicSitPlayerInfo SitID="+msgSPI.m_SitID);
				}
			}
			else
			{
				DebugError("OnLogicSitPlayerInfo Can't Find PlayerInfo PID="+msgSPI.m_PID);
			}
		}
		
		private function OnLogicStart(msgdata:MsgData):void
		{
			var msgStart:Logic_Start = new Logic_Start();
			msgStart.Read(msgdata);
			
			DebugLog("OnLogicStart");
		}
		private function OnLogicReLink(msgdata:MsgData):void
		{
			var msgRK:Logic_Relink = new Logic_Relink();
			msgRK.Read(msgdata);
			
			if( msgRK.m_Flag == Logic_Relink.Start )
			{
				DebugLog("进入游戏桌开始。。。。。。。。。");
				
				for(var TempSit:int=0;TempSit<MaxPlayerOnTable;++TempSit)
				{
					m_spArrayGamePlayerBoard[TempSit].m_EndTurnTime = 0;
					m_spArrayGamePlayerBoard[TempSit].m_spDaoJiShi.visible = false;
				}
			}
			else if( msgRK.m_Flag == Logic_Relink.End )
			{
				//测试
				{
//					for(var i:int=0;i<9;++i)
//					{						
//						m_dataArrayGamePlayerInfo[i].m_AID = 1;
//						m_dataArrayGamePlayerInfo[i].m_PID = 1;
//						
//						m_dataArrayGamePlayerInfo[i].m_HeadPicURL = "http://tp3.sinaimg.cn/1652809182/180/5596779795/1";
//						m_dataArrayGamePlayerInfo[i].m_TableMoney = 1234567890;
//						
//						m_dataArrayGamePlayerInfo[i].m_SitID = i+1;
//						m_dataArrayGamePlayerInfo[i].m_arrayHandPai[0] = 55;
//						m_dataArrayGamePlayerInfo[i].m_arrayHandPai[1] = 55;
//						
//						m_dataArrayGamePlayerInfo[i].m_ChipMoney = Math.floor(Math.random()*100000);
//						
//						m_dataArrayGamePlayerInfo[i].m_arrayHandPai[0] = 10;
//						m_dataArrayGamePlayerInfo[i].m_arrayHandPai[1] = 11;
//					}
//					
//					m_dataGameTable.m_TablePai[0] = 8;
//					m_dataGameTable.m_TablePai[1] = 9;
//					m_dataGameTable.m_TablePai[2] = 10;
//					m_dataGameTable.m_TablePai[3] = 11;
//					m_dataGameTable.m_TablePai[4] = 12;
//					
//					m_dataGameTable.m_MoneyPool[0] = Math.floor(Math.random()*10000000);
//					m_dataGameTable.m_MoneyPool[1] = Math.floor(Math.random()*10000000);
//					m_dataGameTable.m_MoneyPool[2] = Math.floor(Math.random()*10000000);
				}
				
				UpdateClient();
				
				m_bRelinkEnd = true;
				this.visible = true;
				
				var TempMsgFlag:LC_Flag = new LC_Flag();
				TempMsgFlag.m_Flag = LC_Flag.ClientShow;
				SendMsgToLobby(TempMsgFlag);
				
				if( m_MyData.m_AutoRoomID != m_MyData.m_RoomID || m_MyData.m_AutoTableID != m_MyData.m_TableID || m_MyData.m_SitID != 0 )
				{
					m_MyData.m_AutoRoomID = 0;
					m_MyData.m_AutoTableID = 0;
				}
				else
				{
					var QuickTakeMoney:Number   = Math.min(Math.ceil(m_dataGameTable.m_nMaxTakeIn/2),Math.ceil(m_dataGameTable.m_nMinTakeIn));
					QuickTakeMoney				= Math.max(QuickTakeMoney,m_dataGameTable.m_nBigBlind*100);
					QuickTakeMoney				= Math.min(QuickTakeMoney,m_MyData.m_nGameMoney);
					OnQuickStart(QuickTakeMoney);
				}
				
				DebugLog("进入游戏桌结束。。。。。。。。。");
			}
		}
	}
}