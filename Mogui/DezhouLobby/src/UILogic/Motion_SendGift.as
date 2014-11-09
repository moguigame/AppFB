package UILogic
{
	import flash.display.MovieClip;
	
	import MoGui.display.CMotionSprite;
	
	import events.GameStageMsg;
	
	public class Motion_SendGift extends CMotionSprite
	{		
		public var m_PID:int;
		public var m_CurGiftID:int;
		public var m_mcGift:MovieClip;
		public function Motion_SendGift()
		{
			super();
			
			m_PID = 0;
			m_CurGiftID = 0;
			m_mcGift = new MovieClip();
			addChild(m_mcGift);
			
			m_funEndShow = OnMotionGiftEnd;
		}
		
		public function SetGift(GiftID:int):void{
			if( GiftID != m_CurGiftID ){
				m_CurGiftID = GiftID;
				
				removeChild(m_mcGift);
				
				var TempClass:Class;
				TempClass = GlobleData.S_pResLobby.GetResource("Gift_"+String(GiftID));				
				m_mcGift = new TempClass();
				addChild(m_mcGift);
			}
		}
		
		public function OnMotionGiftEnd():void{
			if( m_PID>0 && m_CurGiftID>0 ){
				GlobleFunc.SendGameStageMsg(GameStageMsg.MotionSendGift,m_PID,String(m_CurGiftID));
				
				m_PID = 0;
				m_CurGiftID = 0;
			}
		}
	}
}