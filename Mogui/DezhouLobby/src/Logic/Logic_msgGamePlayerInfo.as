package Logic
{
	import MoGui.net.MsgData;
	
	public class Logic_msgGamePlayerInfo
	{
		public var m_SitID:int;
		public var m_GameState:int;
		public var m_Action:int;
		public var m_arrayHandPai:Vector.<int>;
		public var m_nTableMoney:Number;
		public var m_nChip:Number;
		
		public function Logic_msgGamePlayerInfo()
		{
			m_SitID = 0;
			m_GameState = 0;
			m_Action = 0;
			m_arrayHandPai = new Vector.<int>(2);
			m_nTableMoney = 0;
			m_nChip = 0;
		}
		
		public function Read(msgdata:MsgData):void
		{
			m_SitID = msgdata.ReadUnsignedByte();
			m_GameState = msgdata.ReadUnsignedByte();
			m_Action = msgdata.ReadUnsignedShort();
			m_arrayHandPai[0] = msgdata.ReadUnsignedByte();
			m_arrayHandPai[1] = msgdata.ReadUnsignedByte();
			m_nTableMoney = msgdata.ReadBigNumber();
			m_nChip = msgdata.ReadBigNumber();
		}
	}
}