package UILogic
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	import Data.Data_GiftConfig;
	
	import MoGui.display.CText;
	
	import morn.core.components.Clip;
	import morn.core.components.Component;
	
	public class Item_GiftShop extends Component
	{
		public var m_GiftID:int;
		
		public var m_spBack:Clip;
		public var m_mcGift:MovieClip;

		public var m_tName:CText;
		public var m_tPrice:CText;
		public function Item_GiftShop()
		{
			super();
			
			m_GiftID = 0;
			
			m_spBack = new Clip("png.comp.clip_giftback",1,3);
			addChild(m_spBack);
			m_spBack.width = 120;
			m_spBack.height = 133;
			m_spBack.x = 5;
			
			m_mcGift = null;
			
			m_tName = new CText("黑体",false,0xffffff,14);
			addChild(m_tName);
			m_tPrice = new CText("黑体",false,0xffcc50,14);
			addChild(m_tPrice);
			
			m_tPrice.SetCenterPoint(new Point(60,93));
			m_tName.SetCenterPoint(new Point(60,110));
		}
		
		public function Update(srcData:Data_GiftConfig,baseprice:int):void
		{
			if( m_GiftID != srcData.m_GiftID && srcData.m_GiftID > 0 ){
				var TempClass:Class;
				TempClass = GlobleData.S_pResLobby.GetResource("Gift_"+String(srcData.m_GiftID));
				if( m_mcGift && m_mcGift.parent ){
					this.removeChild(m_mcGift);
				}
				m_mcGift = new TempClass();
				addChild(m_mcGift);
				m_mcGift.x = 15;
				m_mcGift.y = 10;
			}
			m_GiftID = srcData.m_GiftID;			
			
			var GC:Data_GiftConfig = GlobleData.GetGiftConfig(m_GiftID);
			if( GC ){
				m_tName.SetText(GC.m_GiftName);
				
				var nRealPrice:int = 0;
				if( GC.m_PriceFlag == DeZhouDef.PriceFlag_Chang ){
					nRealPrice = Number(GC.m_Price) * baseprice / 100;
				}
				else if( GC.m_PriceFlag == DeZhouDef.PriceFlag_Fixed ){
					nRealPrice = GC.m_Price;
				}
				if( nRealPrice < GC.m_MinPrice ) nRealPrice = GC.m_MinPrice;
				if( nRealPrice > GC.m_MaxPrice ) nRealPrice = GC.m_MaxPrice;
				
				m_tPrice.SetText(String(nRealPrice));
			}
		}
	}
}