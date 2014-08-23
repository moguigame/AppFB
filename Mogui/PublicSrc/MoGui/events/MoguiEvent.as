package MoGui.events
{
	import flash.events.Event;
	
	import morn.core.events.UIEvent;
	
	public class MoguiEvent extends Event
	{
		//-----------------Component-----------------
		//-----------------Image-----------------
		/**图片加载完毕*/
		public static const IMAGE_LOADED:String = "ImageLoaded";
		
		private var _data:*;
		
		public function MoguiEvent(type:String, data:*, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_data = data;
		}
		
		/**事件数据*/
		public function get data():* {
			return _data;
		}
		
		public function set data(value:*):void {
			_data = value;
		}
		
		override public function clone():Event {
			return new UIEvent(type, _data, bubbles, cancelable);
		}
	}
}