package Game
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_RespRoomTableInfo extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.MoGui_RESPROOMTABLEINFO;
		
		public static const SUCCESS:int          = 0;
		public static const NOROOM:int           = 1;
		public static const NORIGHT:int          = 2;
		public static const REQAGAIN:int         = 3;         //重复请求
		
		public var m_Flag:int;
		public var m_RoomID:int;
		
		public function Game_RespRoomTableInfo()
		{
			super();
			
			m_Flag = 0;
			m_RoomID = 0;
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_Flag = msgdata.ReadUnsignedByte();
			m_RoomID = msgdata.ReadUnsignedShort();
		}
	}
}