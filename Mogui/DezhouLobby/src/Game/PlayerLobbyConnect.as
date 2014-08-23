package Game
{
	import flash.utils.ByteArray;
	import MoGui.net.MsgData;
	import PublicXY.*;

	public class PlayerLobbyConnect extends Public_XYBase
	{
		public static const ID:int = LobbyGameXYID.LobbyXY_LobbyPlayerConnect;
		
		public var m_PlayerType:int;
		public var m_ClientType:int;
		public var m_LoginType:int;
		
		public var m_AID:int;
		public var m_PID:uint;
		
		public var m_Session:ByteArray;
		
		public function PlayerLobbyConnect()
		{
			super();
			
			m_PlayerType = PublicDef.PLAYER_TYPE_PLAYER;
			m_ClientType = PublicDef.CLIENT_TYPE_WEB;
			m_LoginType  = PublicDef.Login_Type_Session;
			
			m_Session = new ByteArray();
			m_Session.length = 32;
		}
		
		override public function Write(msgdata:MsgData):void
		{
			msgdata.m_msgID = ID;
			
			msgdata.WriteByte(m_PlayerType);
			msgdata.WriteByte(m_ClientType);
			msgdata.WriteByte(m_LoginType);
			
			msgdata.WriteShort(m_AID);
			msgdata.WriteUnsignedInt(m_PID);
			
			msgdata.WriteBytes(m_Session,32);
		}
		
		override public function Read(msgdata:MsgData):void
		{
			
		}
	}
}