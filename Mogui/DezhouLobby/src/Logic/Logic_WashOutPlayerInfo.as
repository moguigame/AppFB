package Logic
{	
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Logic_WashOutPlayerInfo extends Public_XYBase
	{
		public static const ID:int     = Logic_XieYiID.GameXYID_WashOutPlayerInfo;
		
		public var m_SitID:int;
		public var m_PID:int;
		public var m_Position:int;
		public var m_NickName:String;
		public var m_HeadPicURL:String;
		
		public function Logic_WashOutPlayerInfo()
		{
			super();
			
			m_SitID = 0;
			m_PID = 0;
			m_Position = 0;
			
			m_NickName = "";
			m_HeadPicURL = "";
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_SitID = msgdata.ReadUnsignedByte();
			m_PID = msgdata.ReadUnsignedInt();
			m_Position = msgdata.ReadUnsignedShort();
			
			m_NickName = msgdata.ReadString();
			m_HeadPicURL = msgdata.ReadString();
		}
	}
}