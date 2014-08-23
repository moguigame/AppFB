package Game
{
	import flash.utils.ByteArray;
	
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class ServerToClientMessage extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.MoGui_GAME_SERVERTOCLIENT;
		
		public var m_MsgID:int;
		public var m_MsgLen:int;
		public var m_msgData:ByteArray;
		
		public function ServerToClientMessage()
		{
			super();
			
			m_MsgID = 0;
			m_MsgLen = 0;
			m_msgData = new ByteArray();
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_MsgID = msgdata.ReadUnsignedShort();
			m_MsgLen = msgdata.ReadUnsignedShort();
			msgdata.ReadBytes(m_msgData,m_MsgLen);
		}
	}
}