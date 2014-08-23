package UILogic
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	
	import Data.Data_GamePlayer;
	
	import L2C.S2L_Flag;
	
	import ui.PlayerActionUI;
	
	public class CPlayerActon extends PlayerActionUI
	{
		public static const E_TailInfo:int                 = 1;  //关闭
		public static const E_SendGift:int                 = 2;
		public static const E_AddFriend:int                = 3;
		
		public var m_CurPID:int;
		public var m_Sit:int;
		
		public var m_nEndTime:int;
		public function CPlayerActon()
		{
			super();
			
			m_nEndTime = 0;
			
			m_tLevel.color = "0x999999";
			m_tNickName.color = "0x0090da";
			m_tGameMoney.color = "0xe1b146";
			
			this.addEventListener(Event.ENTER_FRAME,OnEnterFrame);
			
			m_btnTailInfo.addEventListener(MouseEvent.CLICK,OnTailInfo);
			m_btnGift.addEventListener(MouseEvent.CLICK,OnSendGift);
			m_btnAddFriend.addEventListener(MouseEvent.CLICK,OnAddFriend);
		}
		
		public function OnTailInfo(evt:MouseEvent):void{
			visible = false;
			m_nEndTime = 0;
			
			var msgFlag:S2L_Flag = new S2L_Flag();
			msgFlag.m_Flag     = S2L_Flag.PlayerAction;
			msgFlag.m_Value    = E_TailInfo;
			GlobleFunc.SendStageToLobby(stage,msgFlag);
		}
		public function OnSendGift(evt:MouseEvent):void{
			visible = false;
			m_nEndTime = 0;
			
			var msgFlag:S2L_Flag = new S2L_Flag();
			msgFlag.m_Flag     = S2L_Flag.PlayerAction;
			msgFlag.m_Value    = E_SendGift;
			GlobleFunc.SendStageToLobby(stage,msgFlag);
		}
		public function OnAddFriend(evt:MouseEvent):void{
			visible = false;
			m_nEndTime = 0;
			
			var msgFlag:S2L_Flag = new S2L_Flag();
			msgFlag.m_Flag     = S2L_Flag.PlayerAction;
			msgFlag.m_Value    = E_AddFriend;
			GlobleFunc.SendStageToLobby(stage,msgFlag);
		}
		
		public function Show(GP:Data_GamePlayer,nLastTime:int):void{
			this.visible = true;
			m_nEndTime = getTimer() + nLastTime;
			
			m_head.url = GP.m_HeadPicURL;
			m_tNickName.text = GP.m_NickName;
			m_tGameMoney.text = String(GP.m_TableMoney);
		}
		
		public function OnEnterFrame(evt:Event):void{
			if( this.visible && m_nEndTime>0 ){
				if( getTimer() > m_nEndTime ){
					visible = false;
					m_nEndTime = 0;
				}
			}
		}
	}
}