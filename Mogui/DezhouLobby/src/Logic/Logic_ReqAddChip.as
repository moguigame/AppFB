package Logic
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Logic_ReqAddChip extends Public_XYBase
	{
		public static const ID:int     = Logic_XieYiID.GameXYID_ReqAddChip;
		
		public var m_CurPlayerSitID:int;
		public var m_ChipAction:int;
		public var m_nCurChipMoney:int;
		
		public function Logic_ReqAddChip()
		{
			super();
			
			m_CurPlayerSitID = 0;
			m_ChipAction = 0;
			m_nCurChipMoney = 0;
		}
		
		override public function Write(msgdata:MsgData):void
		{
			msgdata.m_msgID = ID;
			msgdata.WriteByte(m_CurPlayerSitID);
			msgdata.WriteByte(m_ChipAction);
			msgdata.WriteBigNumber(m_nCurChipMoney);
		}
		
	}
}