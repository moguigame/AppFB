package PublicXY
{
	import MoGui.net.MsgData;
	
	public class BatchProtocol extends Public_XYBase
	{
		public static const ID:int     = PublicXYID.MOGUI_BATCHPROTOCOL;
		
		public static const NONE:int   = 0;
		public static const START:int  = 1;
		public static const END:int    = 2;
		
		public var m_Flag:int;
		public var m_XYID:int;
		public var m_nCount:int;
		
		public function BatchProtocol()
		{
			super();
			
			m_Flag = 0;
			m_XYID = 0;
			m_nCount = 0;
		}
		
		override public function Write(msgdata:MsgData):void
		{
			
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_Flag = msgdata.ReadUnsignedByte();
			m_XYID = msgdata.ReadUnsignedShort();
			m_nCount = msgdata.ReadUnsignedShort();
		}
	}
}