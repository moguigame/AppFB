package Data
{
	public class Data_GiftConfig
	{
		public var m_GiftID:int;
		public var m_Type:int;
		public var m_PriceFlag:int;
		public var m_Price:int;
		public var m_MaxPrice:int;
		public var m_MinPrice:int;
		public var m_CurLastTime:int;
		public var m_TotalLastTime:int;
		public var m_GiftName:String;
		
		//<record GiftID="1" Type="1" PriceFlag="1" Price="50" MaxPrice="10000"
		//MinPrice="5" CurLastTime="86400" TotalLastTime="864000" Name="西瓜" />
			
		public function Data_GiftConfig()
		{
			m_GiftID    = 0;
			m_Type      = 1;
			m_PriceFlag = 1;
			m_Price     = 100;
			m_MaxPrice  = 100000;
			m_MinPrice  = 100;
			m_CurLastTime   = 1000;
			m_TotalLastTime = 1000;
			m_GiftName      = "礼物";
		}
	}
}