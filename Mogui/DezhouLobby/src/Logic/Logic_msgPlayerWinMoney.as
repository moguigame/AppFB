package Logic
{
	import MoGui.net.MsgData;
	public class Logic_msgPlayerWinMoney
	{
		public var m_SitID:int;
		public var m_nWinMoney:Number;
		
		public function Logic_msgPlayerWinMoney()
		{
			m_SitID = 0;
			m_nWinMoney = 0;
		}
		public function Read(msgdata:MsgData):void
		{
			m_SitID = msgdata.ReadUnsignedByte();
			m_nWinMoney = msgdata.ReadBigNumber();
		}
	}
}