package Logic
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Logic_S2CAddMoney extends Public_XYBase
	{
		public static const ID:int     = Logic_XieYiID.GameXYID_ReqAddMoney;
		
		public var m_SitID:int;
		public var m_MinAdd:Number;
		public var m_MaxAdd:Number;

		public function Logic_S2CAddMoney()
		{
			super();
			
			m_SitID = 0;
			m_MinAdd = 0;
			m_MaxAdd = 0;
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_SitID = msgdata.ReadUnsignedByte();
			m_MinAdd = msgdata.ReadBigNumber();
			m_MaxAdd = msgdata.ReadBigNumber();
		}
	}
}