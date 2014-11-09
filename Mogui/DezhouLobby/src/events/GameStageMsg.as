package events
{
	import flash.events.Event;
	
	public class GameStageMsg extends Event
	{
		public static const EVENT_ID:String          = "GameStageMsg";
		
		
		public static const PlayerTail:int           = 10;  //玩家详细信息
		public static const PlayerGift:int           = 11;
		public static const PlayerGiftList:int       = 12;
		public static const PlayerHonorList:int      = 13;
		
		public static const RespGameSengGift:int     = 21;
		public static const RecvGift:int             = 22;
		public static const SoldGift:int             = 23;
		public static const ChangeGift:int           = 24;
		
		public static const MotionSendGift:int       = 31;
		
		public var m_Flag:int;
		public var m_Value:Number;
		public var m_msgString:String;
		
		public function GameStageMsg(type:String=EVENT_ID, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			m_Flag = 0;
			m_Value = 0;
			m_msgString = "";
		}
	}
}