package Logic
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Logic_AddChipInfo extends Public_XYBase
	{
		public static const ID:int     = Logic_XieYiID.GameXYID_AddChipInfo;
		
		public var m_CurPlayerSitID:int;
		public var m_ChipAction:int;
		public var m_nCurChipMoney:Number;
		public var m_nTableMoney:Number;
		
		public function Logic_AddChipInfo()
		{
			super();
			
			m_CurPlayerSitID = 0;
			m_ChipAction = 0;
			m_nCurChipMoney = 0;
			m_nTableMoney = 0;
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_CurPlayerSitID = msgdata.ReadUnsignedByte();
			m_ChipAction = msgdata.ReadUnsignedShort();
			m_nCurChipMoney = msgdata.ReadBigNumber();
			m_nTableMoney = msgdata.ReadBigNumber();
		}
	}
}