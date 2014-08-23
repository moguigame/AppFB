package Game
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_PlayerJoinTable extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.MoGui_JOINTABLE;
		
		public var m_RoomID:int;
		public var m_TableID:int;
		public var m_PID:int;
		
		public function Game_PlayerJoinTable()
		{
			super();
			
			m_RoomID = 0;
			m_TableID = 0;
			m_PID = 0;
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_RoomID = msgdata.ReadUnsignedShort();
			m_TableID = msgdata.ReadUnsignedShort();
			m_PID = msgdata.ReadUnsignedInt();
		}
	}
}