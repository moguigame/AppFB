package events
{
	import flash.events.Event;
	
	import MoGui.net.MsgData;
	
	public class ChildToParent extends Event
	{
		public static const EVENT_ID:String          = "ChildToParent";
		
		public var m_msgData:MsgData;
		
		public function ChildToParent(type:String=EVENT_ID, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			m_msgData = new MsgData();
		}
	}
}