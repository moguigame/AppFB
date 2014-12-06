package UILogic
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	
	import Data.Data_GamePlayer;
	
	import L2C.S2C_Flag;
	
	import MoGui.display.CLoadImage;
	import MoGui.display.CText;
	import MoGui.events.MoguiEvent;
	
	import UILogic.CMoneyNumber;
	
	import morn.core.utils.ObjectUtils;
	
	public class GamePlayerBoard extends Sprite
	{
		public static const s_TotalFrame:int = 120;
		
		public var m_PID:int;
		public var m_Sit:int;
		public var m_Level:int;
		public var m_NickName:String;
		public var m_nMoney:Number;
		public var m_Action:int;
		public var m_nLeftTime:int;
		public var m_GameState:int;
		public var m_EndTurnTime:int;  //记录TURN的结束时间
		public var m_MatchRank:int;    //比赛被淘汰的名次
		public var m_nChipTime:int;
		public var m_GiftID:int;
		
		private var m_spBack:Sprite;
		private var m_textLevel:CText;
		private var m_textName:CText;
		private var m_HeadPic:CLoadImage;
		private var m_textMoney:CMoneyNumber;
		private var m_textAction:CText;
		private var m_textTime:CText;
		private var m_spWashOut:Sprite;
		public  var m_spDaoJiShi:MovieClip;
		public var  m_mcGift:MovieClip;
		
		private var m_MouseOverTime:int;
		
		public function GamePlayerBoard(nSit:int)
		{
			super();
			
			m_Sit = nSit;
			m_PID = 0;
			m_Level = 0;
			m_NickName = "";
			m_nMoney = 0;
			m_Action = 0;
			m_nLeftTime = 0;
			m_GameState = 0;
			m_EndTurnTime = 0;
			m_MatchRank = 0;
			m_nChipTime = 0;
			
			m_MouseOverTime = 0;
			
			var TempClass:Class;
			TempClass = GlobleData.S_pResGame.GetResource("DaoJiShi");
			m_spDaoJiShi = new TempClass();
			addChild(m_spDaoJiShi);
			m_spDaoJiShi.gotoAndStop(0);
			m_spDaoJiShi.x = -23;
			m_spDaoJiShi.y = -6;
			
			m_spBack = GlobleData.S_pResGame.GetResSprite("UserInfoMC");
			addChild(m_spBack);
			
			m_textLevel = new CText("黑体",true,0xFFCC00,14);
			addChild(m_textLevel);			
			
			m_textName = new CText("黑体",false,0xFFFFFF,14);
			addChild(m_textName);			
			
			m_HeadPic = new CLoadImage(50,50);
			addChild(m_HeadPic);
			m_HeadPic.x = 16;
			m_HeadPic.y = 20;
			
			m_mcGift = new MovieClip();
			addChild(m_mcGift);
			
			m_HeadPic.addEventListener(MouseEvent.ROLL_OVER,OnMouseOverHeadPic);
			m_HeadPic.addEventListener(MouseEvent.ROLL_OUT,OnMouseOutHeadPic);
			m_HeadPic.addEventListener(MouseEvent.CLICK,OnMouseClick);
			m_HeadPic.addEventListener(MoguiEvent.IMAGE_LOADED,OnHeadLoadComplete);
			
			var tf:TextFormat;
			m_textMoney = new CMoneyNumber();
			addChild(m_textMoney);
			m_textMoney.SetCenterPoint(new Point(40,83));
			tf = m_textMoney.GetTextFormat();
			tf.font = "_sans";
			tf.bold = false;
			tf.color = 0xFFCC00;
			tf.size = 14;
			m_textMoney.SetTextFormat(tf);
			
			m_textAction = new CText("黑体",false,0x00CCFF,14);
			addChild(m_textAction);
			m_textAction.SetCenterPoint(new Point(40,103));	
			
			m_textTime = new CText("黑体",false,0x00CCFF,14);
			addChild(m_textTime);
			m_textTime.SetCenterPoint(new Point(40,103));
			
			m_spWashOut = GlobleData.S_pResGame.GetResSprite("OutMark");
			addChild(m_spWashOut);
			m_spWashOut.x = 50;
			m_spWashOut.y = 25;
		}
		
		public function Init():void
		{
			m_textLevel.text        = "";
			m_textName.text         = "";
			m_textMoney.text        = "";
			m_textAction.text       = "";
		}
		
		private function OnMouseClick(evt:MouseEvent):void
		{
			var msgFlag:S2C_Flag = new S2C_Flag();
			msgFlag.m_Flag       = S2C_Flag.ClickPlayerHead;
			msgFlag.m_Value      = m_Sit;
			GlobleFunc.SendStageToClient(stage,msgFlag);
		}
		
		private function OnMouseOverHeadPic(evt:MouseEvent):void
		{
			if( m_MouseOverTime == 0 ){
				m_MouseOverTime = getTimer();
			}
		}
		private function OnMouseOutHeadPic(evt:MouseEvent):void
		{
			m_MouseOverTime = 0;
			var msgFlag:S2C_Flag = new S2C_Flag();
			msgFlag.m_Flag       = S2C_Flag.MouseOutHeadPic;
			msgFlag.m_Value      = m_PID;
			GlobleFunc.SendStageToClient(stage,msgFlag);
		}
		private function OnHeadLoadComplete(evt:MoguiEvent):void
		{
			m_spWashOut.visible = false;
			if( m_GameState == DeZhouDef.GAME_PLAYER_ST_WASHOUT ){
				ObjectUtils.gray(m_HeadPic,true);
				m_spWashOut.visible = true;
			}
		}
		
		public function OnTime(nTime:int):void
		{
			if( m_MouseOverTime>0 && (nTime-m_MouseOverTime)>GlobleData.s_PlayerTailTime )
			{
				m_MouseOverTime = 0;
				var msgFlag:S2C_Flag = new S2C_Flag();
				msgFlag.m_Flag       = S2C_Flag.MouseOverHeadPic;
				msgFlag.m_Value      = m_PID;
				GlobleFunc.SendStageToClient(stage,msgFlag);
			}
			
			if( m_EndTurnTime > 0 )
			{
				var LeftTime:int = Math.max(0,Math.ceil((m_EndTurnTime-nTime)/1000));
				SetLeftTime(LeftTime);
				
				var ChipTime:int = m_nChipTime;
				if( ChipTime == 0 ) ChipTime = 20;				
				var nCurFrame:int = (ChipTime * 1000 + nTime - m_EndTurnTime)*s_TotalFrame/(ChipTime * 1000);
				nCurFrame = Math.max(0,nCurFrame-1);
				m_spDaoJiShi.gotoAndStop(nCurFrame);
			}
		}
		
		public function SetGift(GID:int):void{
			if( GID == 0 ){
				if( m_mcGift ){
					m_mcGift.visible = false;
				}
			}
			else if( GID != m_GiftID ){	
				removeChild(m_mcGift);
				m_GiftID = GID;
				
				var TempClass:Class;
				TempClass = GlobleData.S_pResLobby.GetResource("Gift_"+String(GID));				
				m_mcGift = new TempClass();
				addChild(m_mcGift);
				m_mcGift.visible = true;
				m_mcGift.x = -45;
				m_mcGift.y = 10;
			}
		}
		
		public function SetTableMoney(nMoney:Number):void
		{
			if( nMoney >= 0 ){
				m_nMoney = Math.floor(nMoney);
				m_textMoney.SetMoney(m_nMoney);
			}
		}
		public function AddTableMoney(nMoney:Number):void
		{
			if( m_nMoney + nMoney >= 0 ){
				m_nMoney += nMoney;
				m_textMoney.ChangeMoneyTo(m_nMoney,0.6);
			}
		}
		public function SetLeftTime(nLeftTime:int):void
		{
			if( nLeftTime>=0 && nLeftTime <= 20){
				m_nLeftTime = nLeftTime;
				m_textAction.visible = false;
				m_textTime.visible = true;
				m_textTime.text = String(m_nLeftTime);
			}
		}
		public function SetNickName(nickName:String):void
		{
			if( nickName.length>0 ){
				m_NickName = nickName;
				m_textName.text = m_NickName;
				
				m_textLevel.x = (75-(m_textLevel.GetWidth()+m_textName.GetWidth()))/2;
				m_textName.x = m_textLevel.x + m_textLevel.GetWidth() + 5;
			}
		}
		public function SetGameLevel(nLevel:int):void
		{
			m_Level     = nLevel;
			m_textLevel.text = "Lv"+String(m_Level);
			
			m_textLevel.x = (75-(m_textLevel.GetWidth()+m_textName.GetWidth()))/2;
			m_textName.x = m_textLevel.x + m_textLevel.GetWidth() + 5;
		}
		public function SetAction(nAction:int):void
		{
			m_textAction.visible = true;
			m_textTime.visible = false;
			
			var bChangAction:Boolean = true;
			switch(nAction)
			{
				case DeZhouDef.ACTION_NONE:
				{
					m_textAction.text = "等待下一局";
				}
				break;
				case DeZhouDef.ACTION_Chip:
				{
					m_textAction.text = "下注";
				}
				break;
				case DeZhouDef.ACTION_Follow:
				{
					m_textAction.text = "跟注";
				}
				break;
				case DeZhouDef.ACTION_AddChip:
				{
					m_textAction.text = "加注";
				}
				break;
				case DeZhouDef.ACTION_KanPai:
				{
					m_textAction.text = "看牌";
				}
				break;
				case DeZhouDef.ACTION_GiveUp:
				{
					m_textAction.text = "弃牌";
				}
				break;
				case DeZhouDef.ACTION_AllIn:
				{
					m_textAction.text = "全下";
				}
				break;
				case DeZhouDef.ACTION_POT:
				{
					m_textAction.text = "下底";
				}
				break;
				case DeZhouDef.ACTION_SMALLBLIND:
				{
					m_textAction.text = "小盲注";
				}
				break;
				case DeZhouDef.ACTION_BIGBLIND:
				{
					m_textAction.text = "大盲注";
				}
				break;
				case DeZhouDef.ACTION_NewBlind:
				{
					m_textAction.text = "新手盲注";
				}
				break;
				case DeZhouDef.ACTION_WaitChip:
				{
					m_textAction.text = "等待下注";
				}
				break;
				default:
				{
					bChangAction = false;
					GlobleFunc.LogError("SetAction Action="+nAction);
				}
			}
			
			if ( bChangAction ){
				m_Action = nAction;		
				m_textAction.text = m_textAction.GetText();
			}
			
			if( m_GameState==DeZhouDef.GAME_PLAYER_ST_WASHOUT && m_MatchRank>0 ){
				m_textAction.text = "第 "+m_MatchRank+" 名";
			}	
		}
		
		public function UpdatePlayerInfo(dataGamePlayer:Data_GamePlayer):void
		{
			if( dataGamePlayer.IsSitPlayer() ){
				this.visible            = true;
				m_PID                   = dataGamePlayer.m_PID;
				m_HeadPic.url           = dataGamePlayer.m_HeadPicURL;
				m_GameState             = dataGamePlayer.m_PlayerGameState;
				m_MatchRank             = dataGamePlayer.m_MatchRank;
				
				m_spWashOut.visible = (m_GameState == DeZhouDef.GAME_PLAYER_ST_WASHOUT);
				
				SetNickName(dataGamePlayer.m_NickName);
				SetTableMoney(dataGamePlayer.m_TableMoney);
				SetAction(dataGamePlayer.m_Action);
				SetGameLevel(dataGamePlayer.m_GameLevel);				
				SetGift(dataGamePlayer.m_GiftID);
			}
			else{
				this.visible = false;
				Init();
			}			
		}
	}
}