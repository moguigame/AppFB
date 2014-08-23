package Game
{	
	import MoGui.net.MsgData;
	
	import PublicXY.PublicDef;
	import PublicXY.Public_XYBase;
	
	public class TestPlayerConnect extends Public_XYBase
	{
		public static const ID:int = LobbyGameXYID.LobbyXY_LobbyPlayerConnect;
		
		public var m_AID:int;
		public var m_PID:int;
		
		public var m_PlayerType:int;
		public var m_ClientType:int;
		public var m_LoginType:int;
		
		public var m_UserName:String;
		public var m_Password:String;
		public var m_HardCode:String;
		public var m_strSession:String;
		
		public function TestPlayerConnect()
		{
			super();
			
			m_AID = 0;
			m_PID = 0;
			
			m_PlayerType = PublicDef.PLAYER_TYPE_PLAYER;
			m_ClientType = PublicDef.CLIENT_TYPE_WEB;
			m_LoginType  = PublicDef.Login_Type_CeShi;
			
			m_UserName = "";
			m_Password = "";
			m_HardCode = "";
			m_strSession = "";
		}
		
		override public function Write(msgdata:MsgData):void
		{
			msgdata.m_msgID = ID;
			
			msgdata.WriteInt(m_AID);
			msgdata.WriteInt(m_PID);
			
			msgdata.WriteByte(m_PlayerType);
			msgdata.WriteByte(m_ClientType);
			msgdata.WriteByte(m_LoginType);			
			
			msgdata.WriteString(m_UserName);
			msgdata.WriteString(m_Password);
			msgdata.WriteString(m_HardCode);
			msgdata.WriteString(m_strSession);
		}
		
		override public function Read(msgdata:MsgData):void
		{
			
		}
	}
}