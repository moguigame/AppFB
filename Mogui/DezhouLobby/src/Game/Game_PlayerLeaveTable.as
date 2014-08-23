package Game
{
	import PublicXY.Public_XYBase;
	import MoGui.net.MsgData;
	
	public class Game_PlayerLeaveTable extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.MoGui_LEAVETABLE;
		
		public var m_RoomID:int;
		public var m_TableID:int;
		public var m_PID:int;
		
		public function Game_PlayerLeaveTable()
		{
			super();
			
			m_RoomID = 0;
			m_TableID = 0;
			m_PID = 0;
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_RoomID  = msgdata.ReadUnsignedShort();
			m_TableID = msgdata.ReadUnsignedShort();
			m_PID     = msgdata.ReadUnsignedInt();
		}
	}
}