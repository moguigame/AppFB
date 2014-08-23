package UILogic
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import Game.msgPlayerGiftInfo;
	
	import morn.core.components.Component;
	import morn.core.components.List;
	import morn.core.handlers.Handler;
	
	public class List_PlayerGift extends List
	{
		public var m_nWCount:int;
		public var m_nHCount:int;
		
		public function List_PlayerGift(wCount:int,hCount:int)
		{
			super();
			
			m_nWCount = wCount;
			m_nHCount = hCount;
			
			renderHandler =  new Handler(listRender);
			
			_items = new Vector.<Component>();
			for(var j:int=0;j<hCount;++j){
				for (var i:int=0;i<wCount;i++){				
					var item:Item_PlayerGift = new Item_PlayerGift();
					this.addChild(item);
					item.x = (132+1)*i;
					item.y = (176+1)*j;
					
					//item.doubleClickEnabled = true
					item.addEventListener(MouseEvent.MOUSE_DOWN, onItemMouse);
					item.addEventListener(MouseEvent.ROLL_OVER, onItemMouse);
					item.addEventListener(MouseEvent.ROLL_OUT, onItemMouse);
					item.addEventListener(MouseEvent.DOUBLE_CLICK,onItemMouse);
					item.addEventListener(MouseEvent.CLICK,onItemMouse);
					
					_items.push(item);
				}
				
			}
			_itemCount = _items.length;			
			
			_scrollBar = new MoguiVScrollBar("png.comp.vscroll_00");
			this.addChild(_scrollBar);
			_scrollBar.scrollSize = 1;		
			(_scrollBar as MoguiVScrollBar).getScroll().bar.sizeGrid = "7,10,7,10" ;	
			_scrollBar.addEventListener(Event.CHANGE, onScrollBarChange);
			addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			_scrollBar.x = 525;
			_scrollBar.y = 5;
			_scrollBar.height = 340;
		}
		
		override public function set startIndex(value:int):void {
			value -= (value % m_nWCount);
			if( _startIndex==0 || value != _startIndex ){
				_startIndex = value > 0 ? value : 0;
				for (var i:int = 0; i < _itemCount; i++) {
					renderItem(_items[i], _startIndex + i);
				}
			}
		}
		
		override protected function changeItemState(item:Component, visable:Boolean, frame:int):void 
		{
			var TempItem:Item_PlayerGift = item as Item_PlayerGift;
			if( TempItem )
			{
				if( visable == false ){
					TempItem.m_spBack.frame = 0;
				}
				else if( frame == 0 ){
					TempItem.m_spBack.frame = 1;
				}
				else if( frame == 1 ){	
					TempItem.m_spBack.frame = 2;
				}
			}
		}
		
		private function listRender(item:Component, index:int):void {
			if (index < length)
			{
				var TempGI:msgPlayerGiftInfo = item.dataSource as msgPlayerGiftInfo;
				var TempItem:Item_PlayerGift = item as Item_PlayerGift;
				TempItem.Update(TempGI);
			}
		}
	}
}