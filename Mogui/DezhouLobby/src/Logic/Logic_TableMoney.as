package Logic
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Logic_TableMoney extends Public_XYBase
	{
		public static const ID:int     = Logic_XieYiID.GameXYID_TableMoney;
		
		public var m_SitID:int;
		public var m_nTableMoney:Number;
		
		public function Logic_TableMoney()
		{
			super();
			
			m_SitID = 0;
			m_nTableMoney = 0;
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_SitID = msgdata.ReadUnsignedByte();
			m_nTableMoney = msgdata.ReadBigNumber();
		}
	}
}