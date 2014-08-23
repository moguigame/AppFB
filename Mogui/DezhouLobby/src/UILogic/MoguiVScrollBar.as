package UILogic
{
	import morn.core.components.Slider;
	import morn.core.components.VScrollBar;
	
	public class MoguiVScrollBar extends VScrollBar
	{
		public function MoguiVScrollBar(skin:String=null)
		{
			super(skin);
		}
		
		public function getScroll():Slider
		{
			return this._slider;
		}
	}
}