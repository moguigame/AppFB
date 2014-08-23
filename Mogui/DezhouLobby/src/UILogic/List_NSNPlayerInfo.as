package UILogic
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import Data.Data_SNSPlayerInfo;
	import UILogic.MoguiVScrollBar;
	
	import morn.core.components.Component;
	import morn.core.components.List;
	import morn.core.handlers.Handler;
	
	public class List_NSNPlayerInfo extends List
	{
		public function List_NSNPlayerInfo(nNum:int)
		{
			super();
			
			renderHandler =  new Handler(listRender);
			
			_items = new Vector.<Component>();
			for (var i:int = 0; i < nNum; i++) {
				var item:Item_SNSPlayerInfo = new Item_SNSPlayerInfo();
				this.addChild(item);
				item.x = 0;
				item.y = 58*i;
				
				item.doubleClickEnabled = true
				item.addEventListener(MouseEvent.MOUSE_DOWN, onItemMouse);
				item.addEventListener(MouseEvent.ROLL_OVER, onItemMouse);
				item.addEventListener(MouseEvent.ROLL_OUT, onItemMouse);
				item.addEventListener(MouseEvent.DOUBLE_CLICK,onItemMouse);
				item.addEventListener(MouseEvent.CLICK,onItemMouse);
				
				_items.push(item);
			}
			_itemCount = _items.length;
			
			_scrollBar = new MoguiVScrollBar("png.comp.vscroll_00");
			this.addChild(_scrollBar);
			_scrollBar.scrollSize = 1;
			//_scrollBar.sizeGrid = "7,10,7,10" ;
			(_scrollBar as MoguiVScrollBar).getScroll().bar.sizeGrid = "7,10,7,10" ;	
			_scrollBar.addEventListener(Event.CHANGE, onScrollBarChange);
			addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			_scrollBar.x = 210;
			_scrollBar.y = -5;
			_scrollBar.height = 410;
		}
		
		override protected function onItemMouse(e:MouseEvent):void
		{
			var item:Component = e.currentTarget as Component;
			var index:int = _startIndex + _items.indexOf(item);
			
			var TempItem:Item_SNSPlayerInfo = e.target as Item_SNSPlayerInfo;
			var TempData:Data_SNSPlayerInfo = TempItem.dataSource as Data_SNSPlayerInfo;
			if (e.type == MouseEvent.MOUSE_DOWN)
			{
				selectedIndex = index;
			}			
			else if (_selectedIndex != index)
			{
				changeItemState(item, e.type == MouseEvent.ROLL_OVER, 0);
			}
		}
		
		override protected function changeItemState(item:Component, visable:Boolean, frame:int):void 
		{
			var TempItem:Item_SNSPlayerInfo = item as Item_SNSPlayerInfo;
			if( TempItem )
			{
				
			}
		}
		
		private function listRender(item:Component, index:int):void
		{
			if (index < length)
			{
				var TempTi:Data_SNSPlayerInfo  = item.dataSource as Data_SNSPlayerInfo;	
				var TempItem:Item_SNSPlayerInfo = item as Item_SNSPlayerInfo;
				TempItem.UpdateItemInfo(TempTi);
			}
		}
	}
}