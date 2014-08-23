package Logic
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Logic_PlayerPower extends Public_XYBase
	{
		public static const ID:int     = Logic_XieYiID.GameXYID_PlayerPower;
		
		public var m_ActionFlag:int;
		public var m_nMaxChip:Number;
		public var m_nMinAddChip:Number;
		public var m_nTopChip:Number;

		public function Logic_PlayerPower()
		{
			super();
			
			m_ActionFlag = 0;
			m_nMaxChip = 0;
			m_nMinAddChip = 0;
			m_nTopChip = 0;
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_ActionFlag = msgdata.ReadUnsignedByte();
			m_nMaxChip = msgdata.ReadBigNumber();
			m_nMinAddChip = msgdata.ReadBigNumber();
			m_nTopChip = msgdata.ReadBigNumber();
		}
	}
}