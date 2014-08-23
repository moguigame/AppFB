package Logic
{
	import MoGui.net.MsgData;
	import PublicXY.Public_XYBase;
	
	public class Logic_BankInfo extends Public_XYBase
	{
		public static const ID:int     = Logic_XieYiID.GameXYID_BankerInfo;
		
		public var m_BankerSitID:int;
		public var m_BigBlindSitID:int;
		public var m_SmallBlindSitID:int;
		public function Logic_BankInfo()
		{
			super();
			
			m_BankerSitID = 0;
			m_BigBlindSitID = 0;
			m_SmallBlindSitID = 0;
		}
			
		override public function Read(msgdata:MsgData):void
		{
			m_BankerSitID = msgdata.ReadUnsignedByte();
			m_BigBlindSitID = msgdata.ReadUnsignedByte();
			m_SmallBlindSitID = msgdata.ReadUnsignedByte();
		}
	}
}