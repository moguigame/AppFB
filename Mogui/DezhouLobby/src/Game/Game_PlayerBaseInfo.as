package Game
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_PlayerBaseInfo extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.MoGui_PLAYERBASEINFO;
		
		public static const TablePlayer:int     = 0;
		public static const Friend:int          = 1;
		public static const SameCity:int        = 2;
		public static const SameRoom:int        = 3;
		public static const SameTable:int       = 4;
		public static const CanFollow:int       = 5;
	
		public var m_Flag:int;
		public var m_AID:int;
		public var m_PID:int;
		public var m_nGameMoney:Number;
		public var m_PlayerState:int;
		public var m_GameLevel:int;
		
		public var m_NickName:String;
		public var m_HeadPicURL:String;
		
		public function Game_PlayerBaseInfo()
		{
			super();
			
			m_Flag = 0;
			m_AID = 0;
			m_PID = 0;
			m_nGameMoney = 0;
			m_PlayerState = 0;
			m_GameLevel = 0;
			
			m_NickName = "";
			m_HeadPicURL = "";
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_Flag = msgdata.ReadUnsignedByte();
			m_AID = msgdata.ReadShort();
			m_PID = msgdata.ReadInt();
			m_nGameMoney = msgdata.ReadBigNumber();
			m_PlayerState = msgdata.ReadUnsignedByte();
			m_GameLevel = msgdata.ReadUnsignedByte();
			
			m_NickName = msgdata.ReadString();
			m_HeadPicURL = msgdata.ReadString();			
		}
	}
}