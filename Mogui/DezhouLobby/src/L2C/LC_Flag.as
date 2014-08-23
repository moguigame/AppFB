package L2C
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class LC_Flag extends Public_XYBase
	{
		public static const ID:int     = LC_XieYiID.XYID_LC_Flag;
		
		public static const InitClient:int           = 1;
		public static const StartGame:int            = 2;
		public static const GetMsg:int               = 3;
		public static const CloseClient:int          = 4;
		public static const ClientShow:int           = 5;
		public static const ClientHide:int           = 6;
		
		public var m_Flag:int;
		public function LC_Flag()
		{
			super();
			
			m_Flag = 0;
		}
		
		override public function Write(msgdata:MsgData):void
		{
			msgdata.m_msgID = ID;
			msgdata.WriteByte(m_Flag);
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_Flag = msgdata.ReadUnsignedByte();
		}
	}
}