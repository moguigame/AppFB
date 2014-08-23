package Logic
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Logic_DezhouResult extends Public_XYBase
	{
		public static const ID:int     = Logic_XieYiID.GameXYID_Result;
		
		public var m_PlayerCount:int;
		public var m_arrayPlayerHandPai:Vector.<Logic_msgResultPai>;
		
		public var m_MoneyPoolCount:int;
		public var m_arrayMoneyPool:Vector.<Logic_msgMoneyPool>;
		
		public function Logic_DezhouResult()
		{
			super();
			
			Init();
		}
		public function Init():void
		{
			m_PlayerCount = 0;
			m_arrayPlayerHandPai = new Vector.<Logic_msgResultPai>();
			
			m_MoneyPoolCount = 0;
			m_arrayMoneyPool = new Vector.<Logic_msgMoneyPool>();
		}
		override public function Read(msgdata:MsgData):void
		{
			m_PlayerCount = msgdata.ReadUnsignedByte();
			for(var i:int=0;i<m_PlayerCount;++i)
			{
				var TempResultPai:Logic_msgResultPai = new Logic_msgResultPai();
				TempResultPai.Read(msgdata);
				m_arrayPlayerHandPai.push(TempResultPai);
			}
			
			m_MoneyPoolCount = msgdata.ReadUnsignedByte();
			for(i=0;i<m_MoneyPoolCount;++i)
			{
				var TempMoneyPool:Logic_msgMoneyPool = new Logic_msgMoneyPool();
				TempMoneyPool.Read(msgdata);
				m_arrayMoneyPool.push(TempMoneyPool);
			}
		}
	}
}