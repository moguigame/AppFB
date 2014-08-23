package Game
{
	import MoGui.net.MsgData;	
	import PublicXY.Public_XYBase;
	
	public class Game_RespLeaveRoom extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.MoGui_RESPLEAVEROOM;		
		
		public static const SUCCESS:int              = 0;
		public static const NOROOM:int               = 1;//本房间人数已满
		public static const NOTINROOM:int            = 2;//找不到要加入房间的ID
		public static const PLAYERINPLAYING:int      = 3;//正在其它房间的游戏桌上游戏中，不能换房间		

		public var m_Flag:int;
		public var m_RoomID:int;		
		
		public function Game_RespLeaveRoom()
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