package Game
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_ReqRoomTableInfo extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.MoGui_REQROOMTABLEINFO;
		
		public var m_RoomID:int;
		public function Game_ReqRoomTableInfo()
		{
			super();
			m_RoomID = 0;
		}
		
		override public function Write(msgdata:MsgData):void
		{
			msgdata.m_msgID = ID;			
			msgdata.WriteShort(m_RoomID);			
		}
	}
}