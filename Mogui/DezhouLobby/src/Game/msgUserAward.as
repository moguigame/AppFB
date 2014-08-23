package Game
{
	import MoGui.net.MsgData;
	
	public class msgUserAward
	{		
		public var m_MoneyFlag:int;
		public var m_nMoney:Number;
		
		public function msgUserAward()
		{
			m_MoneyFlag = 0;
			m_nMoney = 0;
		}
		
		public function Read(msgdata:MsgData):void
		{
			m_MoneyFlag = msgdata.ReadShort();
			m_nMoney    = msgdata.ReadBigNumber();
		}
	}
}