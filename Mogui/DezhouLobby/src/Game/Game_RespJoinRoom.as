package Game
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_RespJoinRoom extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.MoGui_RESPJOINROOM;
		
		public static const SUCCESS:int                  = 0;
		public static const PLAYERFULL:int               = 1;
		public static const NOROOM:int                   = 2;
		public static const AREADYINROOM:int             = 3;		
		public static const PLAYERINPLAYING:int          = 4;
		public static const PASSWORDERROR:int            = 5;
		
		public static const JOIN:int                     = 0;
		public static const CHANGE:int                   = 1;
		public static const ATTACH:int                   = 2;		
		
		public var m_Flag:int;
		public var m_Type:int;
		public var m_RoomID:int;
		public var m_ShowFlag:int;
		public var m_strMsg:String;		
		
		public function Game_RespJoinRoom()
		{
			super();
			
			m_Flag = 0;
			m_Type = 0;
			m_RoomID = 0;
			m_ShowFlag = 0;
			m_strMsg = "";
		}
		
		override public function Read(msgdata:MsgData):void
		{			
			m_Flag = msgdata.ReadUnsignedByte();
			m_Type = msgdata.ReadUnsignedByte();
			m_RoomID = msgdata.ReadUnsignedShort();
			m_ShowFlag = msgdata.ReadUnsignedByte();
			m_strMsg = msgdata.ReadString();
		}
	}
}