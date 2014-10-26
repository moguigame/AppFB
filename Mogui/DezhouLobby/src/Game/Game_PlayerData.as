package Game
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_PlayerData extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.MoGuiXYID_PlayerData;
		
		public var m_AID:int;
		public var m_PID:int;
		
		public var m_Sex:int;
		public var m_PlayerType:int;
		public var m_ChangeName:int;		
		
		public var m_nBankMoney:Number;
		public var m_OpenBank:int;
		public var m_nGameMoney:Number;
		public var m_nMoGuiMoney:int;
		public var m_nMatchJF:int;
		
		public var m_nJF:Number;
		public var m_nEP:Number;
		public var m_nWinTimes:int;
		public var m_nLossTimes:int;
		public var m_nGameTime:int;
		
		public var m_NickName:String;
		public var m_HeadPicURL:String;
		public var m_HomePageURL:String;
		public var m_City:String;
		
		public var m_JoinTime:int;
		public var m_LandTime:int;
		
		public var m_RoomID:int;
		public var m_TableID:int;
		public var m_SitID:int;
		public var m_PlayerState:int;
		
		public var m_GameLevel:int;
		
		public function Game_PlayerData()
		{
			super();
			
			m_AID = 0;
			m_PID = 0;
			
			m_Sex = 0;
			m_PlayerType = 0;
			m_ChangeName = 0;
			
			m_nBankMoney = 0;
			m_OpenBank = 0;
			m_nGameMoney = 0;
			m_nMoGuiMoney = 0;
			m_nMatchJF = 0;
			
			m_nJF = 0;
			m_nEP = 0;
			m_nWinTimes = 0;
			m_nLossTimes = 0;
			m_nGameTime = 0;
			
			m_NickName = "";
			m_HeadPicURL = "";
			m_HomePageURL = "";
			m_City = "";
			
			m_JoinTime = 0;
			m_LandTime = 0;			
			
			m_RoomID = 0;
			m_TableID = 0;
			m_SitID = 0;
			m_PlayerState = 0;
			
			m_GameLevel = 0;
		}
		
		override public function Write(msgdata:MsgData):void
		{
			
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_AID = msgdata.ReadShort();
			m_PID = msgdata.ReadUnsignedInt();
			
			m_Sex = msgdata.ReadUnsignedByte();
			m_PlayerType = msgdata.ReadUnsignedByte();
			m_ChangeName = msgdata.ReadInt();
			
			m_nBankMoney = msgdata.ReadBigNumber();
			m_OpenBank = msgdata.ReadUnsignedByte();
			m_nGameMoney = msgdata.ReadBigNumber();
			m_nMoGuiMoney = msgdata.ReadBigNumber();
			m_nMatchJF = msgdata.ReadBigNumber();
			
			m_nJF = msgdata.ReadBigNumber();
			m_nEP = msgdata.ReadBigNumber();
			m_nWinTimes = msgdata.ReadBigNumber();
			m_nLossTimes = msgdata.ReadBigNumber();
			m_nGameTime = msgdata.ReadBigNumber();
			
			m_NickName = msgdata.ReadString();
			m_HeadPicURL = msgdata.ReadString();
			m_HomePageURL = msgdata.ReadString();
			m_City = msgdata.ReadString();
			
			m_JoinTime = msgdata.ReadUnsignedInt();
			m_LandTime = msgdata.ReadUnsignedInt();			
			
			m_RoomID = msgdata.ReadUnsignedShort();
			m_TableID = msgdata.ReadUnsignedShort();
			m_SitID = msgdata.ReadUnsignedByte();
			m_PlayerState = msgdata.ReadUnsignedByte();
			
			m_GameLevel = msgdata.ReadUnsignedByte();
			
			//trace(m_nGameMoney,m_nMoGuiMoney);
		}
	}
}