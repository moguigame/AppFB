package Logic
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Logic_MoneyPool extends Public_XYBase
	{
		public static const ID:int     = Logic_XieYiID.GameXYID_MoneyPool;
		
		public var m_MoneyPoolCount:int;
		public var m_arrayMoneyPool:Vector.<Number>;
		
		public function Logic_MoneyPool()
		{
			super();
			
			m_MoneyPoolCount = 0;
			m_arrayMoneyPool = new Vector.<Number>();
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_MoneyPoolCount = msgdata.ReadUnsignedByte();
			for(var i:int=0;i<m_MoneyPoolCount;++i)
			{
				m_arrayMoneyPool.push(msgdata.ReadBigNumber());
			}
		}
	}
}