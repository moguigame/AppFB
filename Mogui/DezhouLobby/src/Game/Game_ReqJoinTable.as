package Game
{
	import MoGui.net.MsgData;
	import PublicXY.Public_XYBase;
	
	public class Game_ReqJoinTable extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.MoGui_REQJOINTABLE;
		
		public var m_RoomID:int;
		public var m_TableID:int;
		public var m_Password:String;
		
		public function Game_ReqJoinTable()
		{
			super();
			
			m_RoomID = 0;
			m_TableID = 0;
			m_Password = "";
		}
		
		override public function Write(msgdata:MsgData):void
		{
			msgdata.m_msgID = ID;
			msgdata.WriteShort(m_RoomID);
			msgdata.WriteShort(m_TableID);
			msgdata.WriteString(m_Password);
		}
	}
}