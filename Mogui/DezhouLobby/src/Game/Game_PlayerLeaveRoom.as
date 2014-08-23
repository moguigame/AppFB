package Game
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_PlayerLeaveRoom extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.MoGui_LEAVEROOM;
		
		public var m_RoomID:int;
		public var m_PID:int;
		
		public function Game_PlayerLeaveRoom()
		{
			super();
			
			m_RoomID = 0;
			m_PID = 0;
		}
		
		override public function Read(msgdata:MsgData):void
		{			
			m_RoomID = msgdata.ReadUnsignedShort();
			m_PID = msgdata.ReadUnsignedInt();
		}
	}
}