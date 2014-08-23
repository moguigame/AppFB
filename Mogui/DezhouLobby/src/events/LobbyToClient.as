package events
{
	import flash.events.Event;
	
	import MoGui.net.MsgData;
	
	public class LobbyToClient extends Event
	{
		public static const EVENT_ID:String          = "LobbyToClient";
		
		public var m_msgData:MsgData;
		
		public function LobbyToClient(type:String=EVENT_ID, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			m_msgData = new MsgData();
		}
	}
}