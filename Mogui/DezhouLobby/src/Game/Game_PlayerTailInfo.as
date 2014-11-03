package Game
{
	import Data.Data_MaxPai;
	
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_PlayerTailInfo extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.GameLobbyXYID_PlayerTailInfo;
		
		public var m_PID:int;
		public var m_JoinTime:int;
		public var m_LandTime:int;
		public var m_MaxMoneyTime:int;
		public var m_MaxOwnMoney:Number;
		public var m_MaxWinTime:int;
		public var m_MaxWinMoney:Number;
		
		public var m_FriendCount:int;
		public var m_nWinTimes:int;
		public var m_nLossTimes:int;
		public var m_MaxPaiTime:int;
		public var m_dataMaxPai:Data_MaxPai;
		
		public var m_HonorCount:int;
		
		public function Game_PlayerTailInfo()
		{
			super();
			
			m_PID         = 0;
			m_JoinTime    = 0;
			m_LandTime    = 0;
			
			m_MaxOwnMoney = 0;
			m_MaxWinMoney = 0;
			
			m_FriendCount = 0;
			m_nWinTimes = 0;
			m_nLossTimes = 0;
			
			m_dataMaxPai = new Data_MaxPai();
			
			m_HonorCount = 0;
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_PID = msgdata.ReadInt();
			m_JoinTime = msgdata.ReadInt();
			m_LandTime = msgdata.ReadInt();
			
			m_MaxMoneyTime = msgdata.ReadInt();
			m_MaxOwnMoney = msgdata.ReadBigNumber();
			m_MaxWinTime = msgdata.ReadInt();
			m_MaxWinMoney = msgdata.ReadBigNumber();
			
			m_FriendCount = msgdata.ReadShort();
			m_nWinTimes = msgdata.ReadInt();
			m_nLossTimes = msgdata.ReadInt();
			
			m_MaxPaiTime = msgdata.ReadInt();
			m_dataMaxPai.Read(msgdata);
			
			m_HonorCount = msgdata.ReadByte();
		}
	}
}