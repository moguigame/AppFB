package UILogic
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import Data.Data_TableInfo;
	
	import L2C.S2L_ClickTable;
	import L2C.S2L_DoubleClickTable;
	
	import morn.core.components.Component;
	import morn.core.components.List;
	import morn.core.handlers.Handler;
	
	public class List_MatchTableInfo extends List
	{
		public function List_MatchTableInfo(nNum:int)
		{
			super();
			
			renderHandler =  new Handler(listRender);
			
			_items = new Vector.<Component>();
			for (var i:int = 0; i < nNum; i++) {
				var item:Item_MatchTableInfo = new Item_MatchTableInfo();
				this.addChild(item);
				item.x = 0;
				item.y = (item.height+1)*i;
				
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
			(_scrollBar as MoguiVScrollBar).getScroll().bar.sizeGrid = "7,10,7,10" ;	
			_scrollBar.addEventListener(Event.CHANGE, onScrollBarChange);
			addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			_scrollBar.x = 706;
			_scrollBar.y = -4;
			_scrollBar.height = 315;
		}
		
		override protected function onItemMouse(e:MouseEvent):void
		{
			var item:Component = e.currentTarget as Component;
			var index:int = _startIndex + _items.indexOf(item);
			
			var TempRTII:Item_MatchTableInfo = e.target as Item_MatchTableInfo;
			var DataTI:Data_TableInfo = TempRTII.dataSource as Data_TableInfo;
			if (e.type == MouseEvent.MOUSE_DOWN)
			{
				selectedIndex = index;
			}
			else if ( e.type == MouseEvent.DOUBLE_CLICK )
			{
				var msgDoubleClick:S2L_DoubleClickTable = new S2L_DoubleClickTable();
				msgDoubleClick.m_Place = (this.parent as View_TaoJinMatch).m_Place;	
				msgDoubleClick.m_RoomID = DataTI.m_RoomID;
				msgDoubleClick.m_TableID = DataTI.m_TableID;
				GlobleFunc.SendStageToLobby(stage,msgDoubleClick);
			}
			else if( e.type == MouseEvent.CLICK )
			{
				var msgClick:S2L_ClickTable = new S2L_ClickTable();
				msgClick.m_Place = (this.parent as View_TaoJinMatch).m_Place;
				msgClick.m_RoomID = DataTI.m_RoomID;
				msgClick.m_TableID = DataTI.m_TableID;
				GlobleFunc.SendStageToLobby(stage,msgClick);
			}
			else if (_selectedIndex != index)
			{
				changeItemState(item, e.type == MouseEvent.ROLL_OVER, 0);
			}
		}
		
		override protected function changeItemState(item:Component, visable:Boolean, frame:int):void 
		{
			var TempItem:Item_MatchTableInfo = item as Item_MatchTableInfo;
			if( TempItem )
			{
				if( visable == false )
				{
					TempItem.m_spBack.frame = 0;
				}
				else if( frame == 0 )
				{
					TempItem.m_spBack.frame = 1;
				}
				else if( frame == 1 )
				{
					TempItem.m_spBack.frame = 2;
				}
			}
		}
		
		private function listRender(item:Component, index:int):void {
			if (index < length)
			{
				var TempTi:Data_TableInfo = item.dataSource as Data_TableInfo;	
				var TempItem:Item_MatchTableInfo = item as Item_MatchTableInfo;
				TempItem.UpdateTableInfo(TempTi);
			}
		}
	}
}