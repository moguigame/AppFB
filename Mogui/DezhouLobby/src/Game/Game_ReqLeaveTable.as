package Game
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_ReqLeaveTable extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.MoGui_REQLEAVETABLE;
		
		public var m_RoomID:int;
		public var m_TableID:int;
		
		public function Game_ReqLeaveTable()
		{
			super();
			
			m_RoomID = 0;
			m_TableID = 0;
		}
		
		override public function Write(msgdata:MsgData):void
		{
			msgdata.m_msgID = ID;
			msgdata.WriteShort(m_RoomID);
			msgdata.WriteShort(m_TableID);
		}
	}
}