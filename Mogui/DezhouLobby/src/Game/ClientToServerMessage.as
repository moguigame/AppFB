package Game
{
	import flash.utils.ByteArray;
	
	import MoGui.net.MsgData;	
	
	import PublicXY.Public_XYBase;
	
	public class ClientToServerMessage extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.MoGui_GAME_CLIENTTOSERVER;
		
		public var m_MsgID:int;
		public var m_MsgLen:int;
		public var m_msgData:ByteArray;
		
		public function ClientToServerMessage()
		{
			super();
			
			m_MsgID = 0;
			m_MsgLen = 0;
			m_msgData = new ByteArray();
		}
		
		override public function Write(msgdata:MsgData):void
		{
			msgdata.m_msgID = ID;
			msgdata.WriteShort(m_MsgID);
			msgdata.WriteShort(m_MsgLen);
			msgdata.WriteBytes(m_msgData,m_MsgLen);
		}
	}
}