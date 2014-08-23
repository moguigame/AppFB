package Game
{
	import MoGui.net.MsgData;
	import PublicXY.Public_XYBase;
	
	public class Game_ReqJoinRoom extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.MoGui_REQJOINROOM;
		
		public var m_RoomID:int;
		public var m_Password:String;
		
		public function Game_ReqJoinRoom()
		{
			super();
			
			m_RoomID = 0;
			m_Password = "";
		}
		
		override public function Write(msgdata:MsgData):void
		{
			msgdata.m_msgID = ID;
			
			msgdata.WriteShort(m_RoomID);
			msgdata.WriteString(m_Password);
		}
	}
}