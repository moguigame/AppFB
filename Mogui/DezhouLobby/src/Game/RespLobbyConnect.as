package Game
{
	import flash.utils.ByteArray;
	
	import MoGui.net.MsgData;
	import PublicXY.Public_XYBase;
	
	public class RespLobbyConnect extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.MoGuiXYID_RespPlayerConnect;
		
		public static const SUCCESS:int        = 0;
		public static const Failed:int         = 0;
		public static const LOGINSOCKET:int    = 0;
		public static const LOGINERROR:int     = 0;
		public static const NOPLAYER:int       = 0;
		public static const SessionError:int   = 0;
		
		public var m_Flag:int;
		public var m_AID:int;
		public var m_PID:int;
		public var m_Session:ByteArray;
		
		public function RespLobbyConnect()
		{
			super();
			
			m_Flag = 0;
			m_AID = 0;
			m_PID = 0;
			m_Session = new ByteArray();
		}
		
		override public function Write(msgdata:MsgData):void
		{
			
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_Flag = msgdata.ReadUnsignedByte();
			m_AID = msgdata.ReadShort();
			m_PID = msgdata.ReadUnsignedInt();
			if( m_Flag == SUCCESS )
			{
				msgdata.ReadBytes(m_Session,32);
			}
		}
	}
}