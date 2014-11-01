package UILogic
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import Data.Data_GiftConfig;
	
	import L2C.S2L_Flag;
	
	import ui.ShopUI;
	
	public class Box_Shop extends ShopUI
	{
		public static const E_Close:int                   = 1;  //关闭
		public static const E_BuySelf:int                 = 2;
		public static const E_BuyFriend:int               = 3;
		public static const E_BuyPlayer:int               = 4;
		public static const E_BuyAllPlayer:int            = 5;
		
		public static const GiftType_All:int              = 0;
		public static const GiftType_Food:int             = 1;
		public static const GiftType_ZhuangShi:int        = 2;
		public static const GiftType_ZiChan:int           = 3;
		
		public static const ShopType_None:int             = 0;
		public static const ShopType_MySelf:int           = 1;
		public static const ShopType_Player:int           = 2;
		public static const ShopType_Friend:int           = 3;
		
		public var m_bLoadInfo:Boolean;
		public var m_basePrice:int;
		
		public var m_TabGiftType:int;
		public var m_vectorGiftConfig:Vector.<Data_GiftConfig>;
		
		public var m_arrayShowGC:Array;
		public var m_listGift:List_GiftShop;
		
		public var m_nSelectID:int;
		public var m_mcGift:MovieClip;		
		
		public var m_SendType:int;
		public var m_PIDSendFriend:int;
		public var m_PIDSendPlayer:int;		
		public var m_arrayPIDSendPlayer:Vector.<int>;
		
		public var m_TiShi:TimeShowTishi;
		public var m_TimeMask:TimeMask;
		
		public function Box_Shop()
		{
			super();
			
			m_bLoadInfo = false;
			m_btnClose.addEventListener(MouseEvent.CLICK,OnClose);
			
			m_tabGift.addEventListener(Event.SELECT,OnTabGiftSelect);
			m_tabGift.selectedIndex = 0;
			
			m_TabGiftType = GiftType_All;
			m_vectorGiftConfig = new Vector.<Data_GiftConfig>;
			
			m_TiShi = new TimeShowTishi();
			addChild(m_TiShi);
			m_TiShi.m_tTishi.SetText("");
			m_TiShi.m_tTishi.SetFont("黑体");
			m_TiShi.m_tTishi.SetTextSize(14);
			m_TiShi.m_tTishi.SetBold(true);
			m_TiShi.m_tTishi.SetTextColor(0xff0000);
			m_TiShi.m_tTishi.SetCenterPoint(new Point(0,0));
			m_TiShi.x = 600;
			m_TiShi.y = 250;
			
			m_TimeMask = new TimeMask(703,467);
			addChild(m_TimeMask);
			m_TimeMask.m_mask.alpha = 0.2;
			m_TimeMask.visible = false;
			
			m_arrayShowGC = new Array();
			
			m_listGift = new List_GiftShop(4,3);
			addChild(m_listGift);
			m_listGift.x = 5;
			m_listGift.y = 60;
			m_listGift.addEventListener(Event.SELECT,OnSelectGift);
			
			m_nSelectID = 0;
			m_mcGift = null;
			
			m_SendType = ShopType_None;
			m_PIDSendFriend = 0;
			m_PIDSendPlayer = 0;
			m_arrayPIDSendPlayer = new Vector.<int>;
			
			m_btnSendFriend.x = m_btnBuySelf.x;
			m_btnSendPlayer.x = m_btnBuySelf.x;
			m_btnSendFriend.y = m_btnBuySelf.y;
			m_btnSendPlayer.y = m_btnBuySelf.y;
			
			m_btnBuySelf.addEventListener(MouseEvent.CLICK,OnBtnBuySelf);
			m_btnSendFriend.addEventListener(MouseEvent.CLICK,OnBtnSendFriend);
			m_btnSendPlayer.addEventListener(MouseEvent.CLICK,OnBtnSendPlayer);
			m_btnSendAllPlayer.addEventListener(MouseEvent.CLICK,OnBtnSendAllPlayer);
			
			var TempInfoLoad:URLLoader = new URLLoader();
			TempInfoLoad.load(new URLRequest("xml/dezhou_info_gift.xml?"+Math.random()));
			TempInfoLoad.addEventListener(Event.COMPLETE, OnLoadXMLComplete);
		}
		
		private function OnSelectGift(evt:Event):void
		{
			var nSelectIndex:int = m_listGift.selectedIndex;
			if( nSelectIndex>=0 && nSelectIndex<m_arrayShowGC.length ){
				var gcSelect:Data_GiftConfig = m_arrayShowGC[nSelectIndex];
				m_nSelectID = gcSelect.m_GiftID;
				
				m_tName.text = gcSelect.m_GiftName;
				m_tName.visible = true;
				
				m_tBack.text = "是";
				m_tBack.visible = true;
				
				var nDay:int  = gcSelect.m_CurLastTime/(24*3600);
				var nHour:int = gcSelect.m_CurLastTime/3600;
				m_tCurTime.text = ((nDay>0) ? String(nDay)+"天" : String(nHour)+"小时");
				m_tCurTime.visible = true;
				
				nDay  = gcSelect.m_TotalLastTime/(24*3600);
				nHour = gcSelect.m_TotalLastTime/3600;
				m_tLastTime.text = ((nDay>0) ? String(nDay)+"天" : String(nHour)+"小时");
				m_tLastTime.visible = true;
				
				var TempClass:Class;
				TempClass = GlobleData.S_pResLobby.GetResource("Gift_"+String(m_nSelectID));
				if( m_mcGift && m_mcGift.parent ){
					this.removeChild(m_mcGift);
				}
				m_mcGift = new TempClass();
				addChild(m_mcGift);
				//m_mcGift.scaleX = 1.4;
				//m_mcGift.scaleY = 1.4;
				m_mcGift.x = 600 - m_mcGift.width/2;
				m_mcGift.y = 120 - m_mcGift.height;
			}
			else
			{
				m_nSelectID = 0;
				if( m_mcGift ){
					m_mcGift.visible = false;
				}
				m_tCurTime.visible  = false;
				m_tLastTime.visible = false;
				m_tName.visible = false;
				m_tBack.visible = false;
			}
		}
		
		private function OnBtnBuySelf(evt:MouseEvent):void
		{
			if( m_SendType == ShopType_MySelf ){
				if( m_nSelectID > 0 ){
					addChild(m_TimeMask);
					m_TimeMask.ShowTime(500);
					
					m_TiShi.m_tTishi.SetText("");
					
					var msgFlag:S2L_Flag = new S2L_Flag();
					msgFlag.m_Flag     = S2L_Flag.Shop;
					msgFlag.m_Value    = E_BuySelf;
					msgFlag.m_msgString = String(GlobleData.s_MyPID);
					GlobleFunc.SendStageToLobby(stage,msgFlag);
				}
				else{
					m_TiShi.m_tTishi.SetText("请选择你要购买的礼物");
					m_TiShi.ShowTime(2000);
				}
			}
		}		
		private function OnBtnSendFriend(evt:MouseEvent):void
		{
			if( m_SendType == ShopType_Friend && m_PIDSendFriend>0 ){
				if( m_nSelectID > 0 ){
					addChild(m_TimeMask);
					m_TimeMask.ShowTime(500);
					
					m_TiShi.m_tTishi.SetText("");
					
					var msgFlag:S2L_Flag = new S2L_Flag();
					msgFlag.m_Flag     = S2L_Flag.Shop;
					msgFlag.m_Value    = E_BuyFriend;
					msgFlag.m_msgString = String(m_PIDSendFriend);
					GlobleFunc.SendStageToLobby(stage,msgFlag);
				}
				else{
					m_TiShi.m_tTishi.SetText("请选择你要购买的礼物");
					m_TiShi.ShowTime(2000);
				}
			}
		}
		private function OnBtnSendPlayer(evt:MouseEvent):void
		{
			if( m_SendType == ShopType_Player && m_PIDSendPlayer>0 ){
				if( m_nSelectID > 0 ){
					addChild(m_TimeMask);
					m_TimeMask.ShowTime(500);
					
					m_TiShi.m_tTishi.SetText("");
					
					var msgFlag:S2L_Flag = new S2L_Flag();
					msgFlag.m_Flag      = S2L_Flag.Shop;
					msgFlag.m_Value     = E_BuyPlayer;
					msgFlag.m_msgString = String(m_PIDSendPlayer);
					GlobleFunc.SendStageToLobby(stage,msgFlag);
				}
				else{
					m_TiShi.m_tTishi.SetText("请选择你要购买的礼物");
					m_TiShi.ShowTime(2000);
				}
			}
		}
		private function OnBtnSendAllPlayer(evt:MouseEvent):void
		{
		}
		
		private function OnLoadXMLComplete(evt:Event):void
		{
			trace("ConfigData OnLoadXMLComplete");
			
			var loader:URLLoader = evt.target as URLLoader;
			if (loader != null)
			{
				var tempXML:XML = new XML(loader.data);
				for each ( var item:Object in tempXML.record )
				{
					var dataGC:Data_GiftConfig = new Data_GiftConfig();
					dataGC.m_GiftID         = item.@GiftID;
					dataGC.m_Type           = item.@Type;
					dataGC.m_PriceFlag      = item.@PriceFlag;
					dataGC.m_Price          = item.@Price;
					dataGC.m_MaxPrice       = item.@MaxPrice;
					dataGC.m_MinPrice       = item.@MinPrice;
					dataGC.m_CurLastTime    = item.@CurLastTime;
					dataGC.m_TotalLastTime  = item.@TotalLastTime;
					dataGC.m_GiftName       = item.@Name;
					
					m_vectorGiftConfig.push(dataGC);			
				}
				GlobleData.StaticInitGiftConfig(m_vectorGiftConfig);
				m_bLoadInfo = true;
			}
		}
		
		private function OnTabGiftSelect(evt:Event):void
		{
			var nSelectIndex:int = m_tabGift.selectedIndex;
			
			if( nSelectIndex == 0 ){
				m_TabGiftType = GiftType_All;
			}
			else if( nSelectIndex == 1 ){
				m_TabGiftType = GiftType_Food;
			}
			else if( nSelectIndex == 2 ){
				m_TabGiftType = GiftType_ZhuangShi;
			}
			else if( nSelectIndex == 3 ){
				m_TabGiftType = GiftType_ZiChan;
			}
			
			m_listGift.selectedIndex = 0;
			m_listGift.scrollBar.value = 0;
			OnSelectGift(null);
			
			UpdateGift();
		}
		
		public function GetGiftConfig(GiftID:int):Data_GiftConfig
		{
			var retGC:Data_GiftConfig = null;
			for(var i:int=0;i<m_vectorGiftConfig.length;++i){
				if( m_vectorGiftConfig[i].m_GiftID == GiftID ){
					retGC = m_vectorGiftConfig[i];
					break;
				}
			}
			return retGC;
		}
		
		public function Show(baseprice:int,nType:int):void
		{
			if( m_bLoadInfo ){
				this.visible = true;
				m_tabGift.selectedIndex = 0;
				UpdateGift();
				
				m_SendType = nType;
				if( nType == ShopType_MySelf ){
					m_btnBuySelf.visible = true;
					m_btnSendFriend.visible = false;
					m_btnSendPlayer.visible = false;
					m_btnSendAllPlayer.visible = false;
					
					m_PIDSendFriend = 0;
					m_arrayPIDSendPlayer.splice(0,m_arrayPIDSendPlayer.length);
				}
				else if( nType == ShopType_Player ){
					m_btnBuySelf.visible = false;
					m_btnSendFriend.visible = false;
					m_btnSendPlayer.visible = true;
					m_btnSendAllPlayer.visible = true;
					
					m_PIDSendFriend = 0;
				}
				else if( nType == ShopType_Friend ){
					m_btnBuySelf.visible = false;
					m_btnSendFriend.visible = true;
					m_btnSendPlayer.visible = false;
					m_btnSendAllPlayer.visible = false;
					
					m_arrayPIDSendPlayer.splice(0,m_arrayPIDSendPlayer.length);
				}
			}
			else{
				this.visible = false;
			}
		}
		
		public function UpdateGift():void
		{
			m_arrayShowGC.splice(0,m_arrayShowGC.length);
			for( var i:int=0;i<m_vectorGiftConfig.length;++i ){
				if( m_TabGiftType == GiftType_All ){
					m_arrayShowGC.push(m_vectorGiftConfig[i]);
				}
				else
				{
					if( m_vectorGiftConfig[i].m_GiftID > (m_TabGiftType-1)*100 
						&& m_vectorGiftConfig[i].m_GiftID < m_TabGiftType*100 )
					{
						m_arrayShowGC.push(m_vectorGiftConfig[i]);
					}
				}
			}
			if( m_TabGiftType == GiftType_All ){				
				//m_arrayShowGC.sortOn(["m_GiftID"],[Array.NUMERIC|Array.DESCENDING]);
			}
			m_listGift.dataSource = m_arrayShowGC;
		}
		
		private function OnClose(evt:MouseEvent):void
		{
			var msgFlag:S2L_Flag = new S2L_Flag();
			msgFlag.m_Flag     = S2L_Flag.Shop;
			msgFlag.m_Value    = E_Close;
			GlobleFunc.SendStageToLobby(stage,msgFlag);
		}
		
		public function OnTime(nTime:int):void
		{
			m_TiShi.OnTime(nTime);
			m_TimeMask.OnTime(nTime);
		}
	}
}