package Logic
{
	import MoGui.net.MsgData;
	public class Logic_msgMoneyPool
	{
		public var m_nMoney:Number;
		public var m_nPlayerCount:int;
		public var m_arrayPlayerInPool:Vector.<Logic_msgPlayerWinMoney>;

		public function Logic_msgMoneyPool()
		{
			m_nMoney = 0;
			m_nPlayerCount = 0;
			m_arrayPlayerInPool = new Vector.<Logic_msgPlayerWinMoney>();
		}
		public function Read(msgdata:MsgData):void
		{
			m_nMoney = msgdata.ReadBigNumber();
			m_nPlayerCount = msgdata.ReadUnsignedByte();
			for(var i:int=0;i<m_nPlayerCount;++i)
			{
				var TempmsgPWM:Logic_msgPlayerWinMoney = new Logic_msgPlayerWinMoney();
				TempmsgPWM.Read(msgdata);
				m_arrayPlayerInPool.push(TempmsgPWM);
			}
		}
	}
}