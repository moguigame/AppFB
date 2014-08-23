package Logic
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Logic_JoinJuBaoPeng extends Public_XYBase
	{
		public static const ID:int     = Logic_XieYiID.GameXYID_JoinJuBaoPengInfo;
		
		public static const JoinJuBaoPeng:int           = 1;
		public static const ExitJuBaoPeng:int           = 2;
		
		public var m_SitID:int;
		public var m_Flag:int;

		public function Logic_JoinJuBaoPeng()
		{
			super();
			
			m_SitID = 0;
			m_Flag = 0;
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_SitID = msgdata.ReadUnsignedByte();
			m_Flag = msgdata.ReadUnsignedByte();
		}
	}
}