package Game
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_ShowTable extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.MoGuiXYID_ShowTable;
		
		public static const TABLE_HIDE:int                  = 0;
		public static const TABLE_SHOW:int                  = 1;
		
		public var m_RoomID:int;
		public var m_TableID:int;
		public var m_ShowFlag:int;
		
		public function Game_ShowTable()
		{
			super();
			
			m_RoomID = 0;
			m_TableID = 0;
			m_ShowFlag = 0;
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_RoomID = msgdata.ReadUnsignedShort();
			m_TableID = msgdata.ReadUnsignedShort();
			m_ShowFlag = msgdata.ReadUnsignedByte();
		}
	}
}