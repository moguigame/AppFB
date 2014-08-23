package Logic
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Logic_PlayerTurn extends Public_XYBase
	{
		public static const ID:int     = Logic_XieYiID.GameXYID_PlayerTurn;
		
		public var m_SitID:int;
		public var m_LeftTime:int;
		public function Logic_PlayerTurn()
		{
			super();
			
			m_SitID = 0;
			m_LeftTime = 0;
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_SitID = msgdata.ReadUnsignedByte();
			m_LeftTime = msgdata.ReadUnsignedByte();
		}
	}
}