package L2C
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class S2C_FanPai extends Public_XYBase
	{
		public static const ID:int     = LC_XieYiID.XYID_S2C_FanPai;
		
		public var m_SitID:int;
		public var m_Idx:int;
		
		public function S2C_FanPai()
		{
			super();
			
			m_SitID = 0;
			m_Idx = 0;
		}		
		override public function Write(msgdata:MsgData):void
		{
			msgdata.m_msgID = ID;
			msgdata.WriteInt(m_SitID);
			msgdata.WriteInt(m_Idx);
		}
		override public function Read(msgdata:MsgData):void
		{
			m_SitID = msgdata.ReadInt();
			m_Idx = msgdata.ReadInt();
		}
	}
}