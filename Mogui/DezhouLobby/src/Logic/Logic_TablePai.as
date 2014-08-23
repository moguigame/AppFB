package Logic
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Logic_TablePai extends Public_XYBase
	{
		public static const ID:int     = Logic_XieYiID.GameXYID_TablePai;
		
		public var m_PaiCount:int;
		public var m_arrayTablePai:Vector.<int>;
		
		public function Logic_TablePai()
		{
			super();
			
			m_PaiCount = 0;
			m_arrayTablePai = new Vector.<int>(5);
			for(var i:int=0;i<5;++i)
			{
				m_arrayTablePai[i] = 0;
			}
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_PaiCount = msgdata.ReadUnsignedByte();
			for(var i:int=0;i<m_PaiCount;++i)
			{
				m_arrayTablePai[i] = msgdata.ReadUnsignedByte();
			}
			if(m_PaiCount<3 || m_PaiCount>5)
			{
				GlobleFunc.LogError("Logic_TablePai Read PaiCount="+m_PaiCount);
			}
		}
	}
}