package events
{
	import flash.events.Event;
	import MoGui.net.MsgData;
	
	public class GameStageMsg extends Event
	{
		public static const EVENT_ID:String          = "GameStageMsg";
		
		public var m_msgData:MsgData;
		
		public function GameStageMsg(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			m_msgData = new MsgData();
		}
	}
}