package UILogic
{
	import flash.display.DisplayObject;	
	import morn.core.components.ViewStack;
	
	public class MoguiViewStack extends ViewStack
	{
		public function MoguiViewStack()
		{
			super();
			
			_items = new Vector.<DisplayObject>();
		}
	}
}