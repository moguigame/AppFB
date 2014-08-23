package UILogic
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import Data.Data_TableInfo;
	import Data.Data_TablePlayerCount;
	
	import MoGui.display.CText;
	
	import morn.core.components.Button;
	import morn.core.components.Clip;
	
	public class View_RoomTableInfo extends Sprite
	{
		public static var Order_ID:int               = 1;
		public static var Order_BLIND:int            = 2;
		public static var Order_NUM:int              = 3;
		
		public var m_RoomID:int;
		public var m_Place:int;
		public var m_Idx:int;                         //指当前VIEW的序号从0开始算起
		
		public var m_HaveTableInfo:int;
		
		public var m_spTitleBack:Sprite;
		public var m_btnID:Button;
		public var m_btnName:Button;
		public var m_btnBlind:Button;
		public var m_btnGameNum:Button;
		public var m_btnSeeNum:Button;
		public var m_btnMinMaxTake:Button;
		public var m_btnMark:Button;
		
		public var m_spIDUp:Sprite;
		public var m_spBlindDown:Sprite;
		public var m_spPlayerNumDown:Sprite;
		
		public var m_spHideEmpty:Clip;
		public var m_spHideFull:Clip;
		public var m_HideFull:int;
		public var m_HideEmpty:int;
		
		public var m_OrderByFlag:int;
		
		public var m_arrayTableInfo:Array;
		public var m_arrayShowTI:Array;
		public var m_listRoomTableInfo:List_RoomTableInfo;
		
		public var m_ArrayWidth:Array = 
			[
				50,
				100,
				135,
				155,
				50,
				120,
				100
			];
		
		public function View_RoomTableInfo()
		{
			super();
			
			m_RoomID = 0;
			m_Idx = 0;
			
			m_HideFull = 0;
			m_HideEmpty = 0;
			m_OrderByFlag = Order_ID;
			
			m_HaveTableInfo = 0;
			
			var TempClass:Class;
			
			TempClass = GlobleData.S_pResLobby.GetResource("RoomTitleBG");
			m_spTitleBack = new TempClass();
			addChild(m_spTitleBack);
			m_spTitleBack.x = -2;
			m_spTitleBack.width = 728;
			m_spTitleBack.height = 24;
			
			m_btnID = new Button("png.comp.button_01","ID");
			this.addChild(m_btnID);
			m_btnID.x = 0;
			m_btnID.width = m_ArrayWidth[0];
			m_btnID.addEventListener(MouseEvent.CLICK,OnBtnIDClick);
			
			m_btnName = new Button("png.comp.button_01","房间名");
			this.addChild(m_btnName);			
			m_btnName.x = m_btnID.x + m_btnID.width;
			m_btnName.width = m_ArrayWidth[1];
			
			m_btnBlind = new Button("png.comp.button_01","小盲/大盲");
			this.addChild(m_btnBlind);			
			m_btnBlind.x = m_btnName.x + m_btnName.width;
			m_btnBlind.width = m_ArrayWidth[2];
			m_btnBlind.addEventListener(MouseEvent.CLICK,OnBtnBlindClick);
			
			m_btnGameNum = new Button("png.comp.button_01","游戏玩家");
			this.addChild(m_btnGameNum);			
			m_btnGameNum.x = m_btnBlind.x + m_btnBlind.width;
			m_btnGameNum.width = m_ArrayWidth[3];
			m_btnGameNum.addEventListener(MouseEvent.CLICK,OnBtnGameNumClick);
			
			m_btnSeeNum = new Button("png.comp.button_01","旁观");
			this.addChild(m_btnSeeNum);			
			m_btnSeeNum.x = m_btnGameNum.x + m_btnGameNum.width;
			m_btnSeeNum.width = m_ArrayWidth[4];
			
			m_btnMinMaxTake = new Button("png.comp.button_01","最小--最大带入");
			this.addChild(m_btnMinMaxTake);			
			m_btnMinMaxTake.x = m_btnSeeNum.x + m_btnSeeNum.width;
			m_btnMinMaxTake.width = m_ArrayWidth[5];			
			
			m_btnMark = new Button("png.comp.button_01","备注");
			this.addChild(m_btnMark);			
			m_btnMark.x = m_btnMinMaxTake.x + m_btnMinMaxTake.width;
			m_btnMark.width = m_ArrayWidth[6];
			
			var TempDP:DisplayObject;
			for(var i:uint;i<this.numChildren;i++)
			{
				TempDP = this.getChildAt(i);
				if( TempDP is Button )
				{
					(TempDP as Button).labelBold = true;
					(TempDP as Button).labelColors = "0xffffff,0xffffff,0xffffff,0xffffff";
					(TempDP as Button).btnLabel.alpha = 0.5;
				}
			}
			
			TempClass = GlobleData.S_pResLobby.GetResource("RoomTitleSeparator");
			var SeparatorArray:Array = new Array(6);
			for( i=0; i<6; i++ )
			{
				SeparatorArray[i] = new TempClass();
				addChild(SeparatorArray[i]);
				SeparatorArray[i].y = 1;
			}
			SeparatorArray[0].x = m_btnName.x;
			SeparatorArray[1].x = m_btnBlind.x;
			SeparatorArray[2].x = m_btnGameNum.x;
			SeparatorArray[3].x = m_btnSeeNum.x;
			SeparatorArray[4].x = m_btnMinMaxTake.x;
			SeparatorArray[5].x = m_btnMark.x;
			
			TempClass = GlobleData.S_pResLobby.GetResource("Order_Up");
			m_spIDUp = new TempClass();
			addChild(m_spIDUp);
			m_spIDUp.x = m_btnID.x + m_btnID.width - 15;
			m_spIDUp.y = m_btnID.y + m_btnID.height - 15;
			
			TempClass = GlobleData.S_pResLobby.GetResource("Order_Down");
			m_spBlindDown = new TempClass();
			addChild(m_spBlindDown);
			m_spBlindDown.x = m_btnBlind.x + m_btnBlind.width - 15;
			m_spBlindDown.y = m_btnBlind.y + m_btnBlind.height - 15;
			m_spBlindDown.visible = false;
			
			m_spPlayerNumDown = new TempClass();
			addChild(m_spPlayerNumDown);
			m_spPlayerNumDown.x = m_btnGameNum.x + m_btnGameNum.width  - 15;
			m_spPlayerNumDown.y = m_btnGameNum.y + m_btnGameNum.height - 15;
			m_spPlayerNumDown.visible = false;
			
			m_spHideEmpty = new Clip("png.comp.clip_checkbox",1,3);
			addChild(m_spHideEmpty);			
			m_spHideEmpty.x = 10;
			m_spHideEmpty.y = 345;
			m_spHideEmpty.addEventListener(MouseEvent.CLICK,OnHideEmptyClick);
			
			var TempEmptyText:CText = new CText("黑体",true,0xffffff,14);
			TempEmptyText.text = "隐藏空桌";
			TempEmptyText.alpha = 0.6;
			addChild(TempEmptyText);
			TempEmptyText.x = 32;
			TempEmptyText.y = 345;
			
			m_spHideFull = new Clip("png.comp.clip_checkbox",1,3);
			addChild(m_spHideFull);
			m_spHideFull.x = 125;
			m_spHideFull.y = 345;
			m_spHideFull.addEventListener(MouseEvent.CLICK,OnHideFullClick);
			
			var TempFullText:CText = new CText("黑体",true,0xffffff,14);
			TempFullText.text = "隐藏满桌";
			TempFullText.alpha = 0.6;
			addChild(TempFullText);
			TempFullText.x = 147;
			TempFullText.y = 345;
			
			m_arrayTableInfo = new Array();
			m_arrayShowTI = new Array();
			
			m_listRoomTableInfo = new List_RoomTableInfo(9);
			addChild(m_listRoomTableInfo);
			m_listRoomTableInfo.y = m_spTitleBack.height;	
		}
		
		private function OnBtnIDClick(evt:MouseEvent):void
		{
			if( m_OrderByFlag != Order_ID )
			{
				m_OrderByFlag = Order_ID;
				
				m_spIDUp.visible = true;
				m_spBlindDown.visible = false;
				m_spPlayerNumDown.visible = false;
				
				UpdateAllTable();
			}
		}
		private function OnBtnBlindClick(evt:MouseEvent):void
		{
			if( m_OrderByFlag != Order_BLIND )
			{
				m_OrderByFlag = Order_BLIND;
				
				m_spIDUp.visible = false;
				m_spBlindDown.visible = true;
				m_spPlayerNumDown.visible = false;
				
				UpdateAllTable();
			}
		}
		private function OnBtnGameNumClick(evt:MouseEvent):void
		{
			if( m_OrderByFlag != Order_NUM )
			{
				m_OrderByFlag = Order_NUM;
				
				m_spIDUp.visible = false;
				m_spBlindDown.visible = false;
				m_spPlayerNumDown.visible = true;
				
				UpdateAllTable();
			}
		}
		
		private function OnHideEmptyClick(evt:MouseEvent):void
		{
			m_HideEmpty = m_HideEmpty>0 ? 0:1;
			m_spHideEmpty.frame = m_HideEmpty+1;
			UpdateAllTable();
		}
		private function OnHideFullClick(evt:MouseEvent):void
		{
			m_HideFull = m_HideFull>0 ? 0:1;
			m_spHideFull.frame = m_HideFull+1;
			UpdateAllTable();
		}
		
		public function GetAutoTable(nMoney:Number):Data_TableInfo
		{
			var bFind:Boolean = false;
			var TempTI:Data_TableInfo;
			var i:int = 0;
			for(i=0;i<m_arrayTableInfo.length;++i)
			{
				TempTI = m_arrayTableInfo[i] as Data_TableInfo;
				if( nMoney >= TempTI.m_BigBlind*300 && nMoney <= TempTI.m_BigBlind*1000 
					&& TempTI.m_CurSitPlayerNumber >= 3 && TempTI.m_CurSitPlayerNumber < TempTI.m_MaxSitPlayerNumber )
				{
					bFind = true;
					return m_arrayTableInfo[i];
				}
			}
			if( !bFind )
			{
				for(i=0;i<m_arrayTableInfo.length;++i)
				{
					TempTI = m_arrayTableInfo[i] as Data_TableInfo;
					if( nMoney >= TempTI.m_BigBlind*200 && nMoney <= TempTI.m_BigBlind*2000
						&& TempTI.m_CurSitPlayerNumber >= 1 && TempTI.m_CurSitPlayerNumber < TempTI.m_MaxSitPlayerNumber )
					{
						bFind = true;
						return m_arrayTableInfo[i];
					}
				}
			}			
			if( !bFind )
			{
				for(i=0;i<m_arrayTableInfo.length;++i)
				{
					TempTI = m_arrayTableInfo[i] as Data_TableInfo;
					if( nMoney >= TempTI.m_BigBlind*100 && nMoney <= TempTI.m_BigBlind*5000
						&& TempTI.m_CurSitPlayerNumber < TempTI.m_MaxSitPlayerNumber )
					{
						bFind = true;
						return m_arrayTableInfo[i];
					}
				}
			}
			
			return null;
		}
		
		public function GetTableInfo(tableid:int):Data_TableInfo
		{
			for(var i:int=0;i<m_arrayTableInfo.length;++i)
			{
				if( (m_arrayTableInfo[i] as Data_TableInfo).m_TableID == tableid )
				{
					return m_arrayTableInfo[i];
				}
			}
			return null;
		}
		
		public function AddTableInfo(dataTI:Data_TableInfo):void
		{
			var findTI:Data_TableInfo = GetTableInfo(dataTI.m_TableID);
			if( findTI != null )
			{
				findTI = dataTI;
			}
			else
			{
				m_arrayTableInfo.push(dataTI);
			}
		}
		public function SetShowFlag(tableid:int,showflag:int):void
		{
			var findTI:Data_TableInfo = GetTableInfo(tableid);
			if( findTI != null )
			{
				findTI.m_ShowFlag = showflag;
			}
			else
			{
				GlobleFunc.LogError("ShowTable",tableid,showflag);
			}
		}
		
		public function SetMyTable():void
		{
			
		}
		public function UpdateAllTable():void
		{
			m_arrayShowTI.length = 0;
			var TempTI:Data_TableInfo;
			var i:int;
			var j:int;
			for(i;i<m_arrayTableInfo.length;++i)
			{
				TempTI = m_arrayTableInfo[i] as Data_TableInfo;
				if( TempTI.m_ShowFlag == 0 )
				{
					continue;
				}
				if( TempTI.m_CurSitPlayerNumber==0 && m_HideEmpty )
				{
					continue;
				}
				if( TempTI.m_CurSitPlayerNumber==TempTI.m_MaxSitPlayerNumber && m_HideFull )
				{
					continue;
				}
				TempTI.UpdateRank();
				m_arrayShowTI.push(TempTI);
			}
			
			var TempLeft:Data_TableInfo;
			var TempRight:Data_TableInfo;
			if( m_OrderByFlag == Order_ID )
			{
				m_arrayShowTI.sortOn(["m_RankValue","m_TableID"],[Array.NUMERIC|Array.DESCENDING,Array.DESCENDING]);
			}
			else if( m_OrderByFlag == Order_BLIND )
			{
				m_arrayShowTI.sortOn(["m_RankValue","m_BigBlind"],[Array.NUMERIC|Array.DESCENDING,Array.NUMERIC|Array.DESCENDING]);
			}
			else if( m_OrderByFlag == Order_NUM )
			{
				m_arrayShowTI.sortOn(["m_RankValue","m_CurSitPlayerNumber"],[Array.NUMERIC|Array.DESCENDING,Array.NUMERIC|Array.DESCENDING]);
			}	
			
			m_listRoomTableInfo.dataSource = m_arrayShowTI;
		}
		
		public function UpdatePlayerCount(msgdata:Data_TablePlayerCount):void
		{
			var i:int;
			var TempTI:Data_TableInfo;
			var bFind:Boolean = false;
			for( i=0;i<m_arrayTableInfo.length;++i)
			{
				TempTI = m_arrayTableInfo[i] as Data_TableInfo;
				if( TempTI.m_RoomID==msgdata.m_RoomID && TempTI.m_TableID==msgdata.m_TableID )
				{
					bFind = true;
					TempTI.m_CurSitPlayerNumber = msgdata.m_SitPlayer;
					TempTI.m_CurStandPlayerNumber = msgdata.m_SeePlayer;
					break;
				}
			}
			if( !bFind ) GlobleFunc.LogError("UpdatePlayerCount m_arrayTableInfo",msgdata.m_RoomID,msgdata.m_TableID);
			
			bFind = false;
			for( i=0;i<m_arrayShowTI.length;++i)
			{
				TempTI = m_arrayShowTI[i] as Data_TableInfo;
				if( TempTI.m_RoomID==msgdata.m_RoomID && TempTI.m_TableID==msgdata.m_TableID )
				{
					bFind = true;
					TempTI.m_CurSitPlayerNumber = msgdata.m_SitPlayer;
					TempTI.m_CurStandPlayerNumber = msgdata.m_SeePlayer;
					break;
				}
			}
			
			if( bFind )
			{
				m_listRoomTableInfo.dataSource = m_arrayShowTI;
			}		
		}		
	}
}