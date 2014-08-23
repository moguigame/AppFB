package Logic
{
	import Data.Data_MaxPai;
	
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Logic_SitPlayerInfo extends Public_XYBase
	{
		public static const ID:int     = Logic_XieYiID.GameXYID_SitPlayerInfo;
		
		public var m_SitID:int;
		public var m_GiftID:int;
		public var m_PID:int;
		
		public var m_nJF:Number;
		public var m_nExperience:Number;
		public var m_nWinTimes:Number;
		public var m_nLossTimes:Number;
		public var m_dataMaxPai:Data_MaxPai;
		
		public var m_GameLevel:int;
		public var m_VipLevel:int;
		public var m_Sex:int;
		
		public var m_HomePageURL:String;
		
		public function Logic_SitPlayerInfo()
		{
			super();
			
			m_SitID = 0;
			m_GiftID = 0;
			m_PID = 0;
			
			m_nJF = 0;
			m_nExperience = 0;
			m_nWinTimes = 0;
			m_nLossTimes = 0;
			m_dataMaxPai = new Data_MaxPai();
			
			m_GameLevel = 0;
			m_VipLevel = 0;
			m_Sex = 0;
			
			m_HomePageURL = "";
			
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_SitID = msgdata.ReadUnsignedByte();
			m_GiftID = msgdata.ReadShort();
			m_PID = msgdata.ReadUnsignedInt();
			
			m_nJF = msgdata.ReadBigNumber();
			m_nExperience = msgdata.ReadBigNumber();
			m_nWinTimes = msgdata.ReadBigNumber();
			m_nLossTimes = msgdata.ReadBigNumber();
			m_dataMaxPai.Read(msgdata);
			
			m_GameLevel = msgdata.ReadUnsignedByte();
			m_VipLevel = msgdata.ReadUnsignedByte();
			m_Sex = msgdata.ReadUnsignedByte();
			
			m_HomePageURL = msgdata.ReadString();			
		}
	}
}