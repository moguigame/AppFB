package MoGui.net
{
	import flash.events.Event;
	
	public class MsgDataEvent extends Event
	{
		public static const EVENT_ID:String          = "MsgDataEvent";
		
		public var m_msgData:MsgData = new MsgData();
		
		public function MsgDataEvent(type:String=EVENT_ID, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}