package Game
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_CreateTablePID extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.GameLobbyXYID_CreateTablePID;
		
		public var m_RoomID:int;
		public var m_TableID:int;
		public var m_PID:int;
		
		public function Game_CreateTablePID()
		{
			super();
			
			m_RoomID = 0;
			m_TableID = 0;
			m_PID = 0;
		}
		
		override public function Write(msgdata:MsgData):void
		{
			msgdata.m_msgID = ID;
			msgdata.WriteShort(m_RoomID);
			msgdata.WriteShort(m_TableID);
			msgdata.WriteInt(m_PID);
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_RoomID = msgdata.ReadUnsignedShort();
			m_TableID = msgdata.ReadUnsignedShort();
			m_PID = msgdata.ReadUnsignedInt();
		}
	}
}