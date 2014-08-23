package Game
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_PlayerStateInfo extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.MoGui_PLAYERSTATEINFO;
		
		public static const TablePlayer:int      = 0;
		public static const Friend:int           = 1;
		public static const SameCity:int         = 2;
		public static const SameRoom:int         = 3;
		public static const SameTable:int        = 4;
		
		public var m_Flag:int;
		public var m_PID:int;
		
		public var m_RoomID:int;
		public var m_TableID:int;
		public var m_SitID:int;
		public var m_State:int;
		public var m_strState:String;		
		
		public function Game_PlayerStateInfo()
		{
			super();
			
			m_Flag = 0;
			m_PID = 0;
			
			m_RoomID = 0;
			m_TableID = 0;
			m_SitID = 0;
			m_State = 0;
			m_strState = "";
		}
		
		override public function Write(msgdata:MsgData):void
		{
			
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_Flag = msgdata.ReadUnsignedByte();
			m_PID = msgdata.ReadUnsignedInt();
			
			m_RoomID = msgdata.ReadUnsignedShort();
			m_TableID = msgdata.ReadUnsignedShort();
			m_SitID = msgdata.ReadUnsignedByte();
			m_State = msgdata.ReadUnsignedByte();
			m_strState = msgdata.ReadString();		
		}
	}
}