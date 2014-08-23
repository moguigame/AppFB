package Data
{
	import MoGui.net.MsgData;
	
	public class Data_MaxPai
	{
		public var m_PaiType:int;
		public var m_arrayPai:Vector.<int>;
		
		public function Data_MaxPai()
		{
			m_PaiType = 0;
			m_arrayPai = new Vector.<int>(5);
		}
		
		public function Copy(srcData:Data_MaxPai):void
		{
			m_PaiType = srcData.m_PaiType;
			for(var i:int=0;i<5;++i)
			{
				m_arrayPai[i] = srcData.m_arrayPai[i];
			}
		}
		
		public function Read(msgdata:MsgData):void
		{
			for(var i:int=4;i>=0;--i)
			{
				m_arrayPai[i] = msgdata.ReadUnsignedByte();
			}
			m_PaiType = msgdata.ReadUnsignedByte();
			msgdata.ReadUnsignedByte();
			msgdata.ReadUnsignedByte();
		}
	}
}