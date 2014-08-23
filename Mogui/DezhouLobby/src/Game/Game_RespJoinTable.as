package Game
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_RespJoinTable extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.MoGui_RESPJOINTABLE;		
		
		public static const SUCCESS:int         = 0;      //加入桌子成功
		public static const PLAYERFULL:int      = 1;      //本桌人数已满，包括旁观的也满了
		public static const NOTABLE:int         = 2;      //找不到要加入的桌子ID号
		public static const INOTHERTABLE:int    = 3;      //玩家正在其它桌游戏，不能加入本桌
		public static const NOTINROOM:int       = 4;      //不在要加入的房间内
		public static const AREADYINTABLE:int   = 5;      //已经在桌子里面了
		public static const PLAYERINPLAYING:int = 6;      //正在游戏中
		public static const PASSWORDERROR:int   = 7;      //密码错误
		public static const NOROOM:int          = 8;
		public static const TABLEEND:int        = 9;	
		
		public static const JOIN:int            = 0;
		public static const CHANGE:int          = 1;
		public static const ATTACH:int          = 2;
		
		public var m_Flag:int;
		public var m_Type:int;
		public var m_RoomID:int;
		public var m_TableID:int;
		public var m_ShowFlag:int;
		public var m_strMsg:String;
		
		public function Game_RespJoinTable()
		{
			super();
			
			m_Flag = 0;
			m_Type = 0;
			m_RoomID = 0;
			m_TableID = 0;
			m_ShowFlag = 0;
			m_strMsg = "";
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_Flag = msgdata.ReadUnsignedByte();
			m_Type = msgdata.ReadUnsignedByte();
			m_RoomID = msgdata.ReadUnsignedShort();
			m_TableID = msgdata.ReadUnsignedShort();
			m_ShowFlag = msgdata.ReadUnsignedByte();
			m_strMsg = msgdata.ReadString();
		}
	}
}