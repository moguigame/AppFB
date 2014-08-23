package UILogic
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import Data.Data_QuickChat;
	
	import morn.core.components.Component;
	import morn.core.components.List;
	import morn.core.components.ScrollBar;
	import morn.core.handlers.Handler;
	
	public class List_ChatWord extends List
	{
		public var m_nSelectIdx:int;
		public function List_ChatWord(nNum:int)
		{
			super();
			
			renderHandler =  new Handler(listRender);
			
			_items = new Vector.<Component>();
			for (var i:int = 0; i < nNum; i++) {
				var item:ChatWordItem = new ChatWordItem();
				this.addChild(item);
				item.x = 0;
				item.y = item.height*i;
				
				item.addEventListener(MouseEvent.MOUSE_DOWN, onItemMouse);
				item.addEventListener(MouseEvent.ROLL_OVER, onItemMouse);
				item.addEventListener(MouseEvent.ROLL_OUT, onItemMouse);
				item.addEventListener(MouseEvent.CLICK,onItemMouse);
				
				_items.push(item);
			}
			_itemCount = _items.length;
			
			_scrollBar = new MoguiVScrollBar("png.comp.vscroll_00");
			this.addChild(_scrollBar);
			_scrollBar.scrollSize = 1;		
			(_scrollBar as MoguiVScrollBar).getScroll().bar.sizeGrid = "7,10,7,10" ;		
			_scrollBar.addEventListener(Event.CHANGE, onScrollBarChange);
			addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			_scrollBar.x = 215;
			_scrollBar.height = 180;
		}
		
		override protected function onItemMouse(e:MouseEvent):void
		{
			var item:Component = e.currentTarget as Component;
			var index:int = _startIndex + _items.indexOf(item);
			
			var TempItem:ChatWordItem = e.target as ChatWordItem;
			var DataSrc:Data_QuickChat = TempItem.dataSource as Data_QuickChat;
			
			if (e.type == MouseEvent.MOUSE_DOWN){				
			}
			else if( e.type == MouseEvent.CLICK ){
				m_nSelectIdx = DataSrc.m_Idx;				
				selectedIndex = index;
			}
			else if (_selectedIndex != index){
				changeItemState(item, e.type == MouseEvent.ROLL_OVER, 0);
			}
		}		
		override protected function changeItemState(item:Component, visable:Boolean, frame:int):void 
		{
			var TempItem:ChatWordItem = item as ChatWordItem;
			if( TempItem ){
				if( visable && frame==0 ){
					TempItem.m_spOver.visible = true;
				}
				else{
					TempItem.m_spOver.visible = false;
				}
			}
		}
		private function listRender(item:Component, index:int):void
		{
			if (index < length){
				var TempTi:Data_QuickChat = item.dataSource as Data_QuickChat;
				var TempChatWordItem:ChatWordItem = item as ChatWordItem;
				TempChatWordItem.SetChatWord(TempTi);
			}
		}
	}
}