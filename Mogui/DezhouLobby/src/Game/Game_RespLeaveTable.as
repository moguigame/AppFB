package Game
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_RespLeaveTable extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.MoGui_RESPLEAVETABLE;
		
		public var m_Flag:int;
		public var m_RoomID:int;
		public var m_TableID:int;
		
		public function Game_RespLeaveTable()
		{
			super();
			
			m_Flag = 0;
			m_RoomID = 0;
			m_TableID = 0;
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_Flag = msgdata.ReadUnsignedByte();
			m_RoomID = msgdata.ReadUnsignedShort();
			m_TableID = msgdata.ReadUnsignedShort();
		}
	}
}