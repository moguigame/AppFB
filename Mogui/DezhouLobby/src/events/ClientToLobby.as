package events
{
	import flash.events.Event;
	
	import MoGui.net.MsgData;
	
	public class ClientToLobby extends Event
	{
		public static const EVENT_ID:String          = "ClientToLobby";
		
		public var m_msgData:MsgData;
		
		public function ClientToLobby(type:String=EVENT_ID, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			m_msgData = new MsgData();
		}
	}
}