package Game
{
	import MoGui.net.MsgData;
	public class msgTablePlayerCount
	{
		public var m_TableID:int;
		public var m_nPlayingPlayerCount:int;
		public var m_nSeeingPlayerCount:int;
		
		public function msgTablePlayerCount()
		{
			m_TableID = 0;
			m_nPlayingPlayerCount = 0;
			m_nSeeingPlayerCount = 0;
		}
		
		public function Read(msgdata:MsgData):void
		{
			m_TableID = msgdata.ReadUnsignedShort();
			m_nPlayingPlayerCount = msgdata.ReadUnsignedByte();
			m_nSeeingPlayerCount = msgdata.ReadUnsignedShort();
		}
	}
}