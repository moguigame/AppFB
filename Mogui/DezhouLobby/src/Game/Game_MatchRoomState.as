package Game
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_MatchRoomState extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.GameLobbyXYID_MatchRoomState;
		
		public var m_RoomID:int;
		public var m_RoomState:int;		
		public function Game_MatchRoomState()
		{
			super();
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_RoomID = msgdata.ReadUnsignedShort();
			m_RoomState = msgdata.ReadUnsignedByte();
		}
	}
}