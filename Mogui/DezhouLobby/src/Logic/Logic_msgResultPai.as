package Logic
{
	import MoGui.net.MsgData;
	public class Logic_msgResultPai
	{
		public var m_SitID:int;
		public var m_arrayHandPai:Vector.<int>;
		public var m_PaiType:int;
		public var m_arrayPai:Vector.<int>;
		public var m_bWin:int;
		
		public function Logic_msgResultPai()
		{
			m_SitID = 0;
			m_arrayHandPai = new Vector.<int>(2);
			m_PaiType = 0;
			m_arrayPai = new Vector.<int>(5);
			m_bWin = 0;
		}
		public function Read(msgdata:MsgData):void
		{
			m_SitID = msgdata.ReadUnsignedByte();
			m_arrayHandPai[0] = msgdata.ReadUnsignedByte();
			m_arrayHandPai[1] = msgdata.ReadUnsignedByte();
			m_PaiType = msgdata.ReadUnsignedByte();			
			for(var i:int=0;i<5;++i)
			{
				m_arrayPai[i] = msgdata.ReadUnsignedByte();				
			}
			m_bWin = msgdata.ReadUnsignedByte();
		}
	}
}