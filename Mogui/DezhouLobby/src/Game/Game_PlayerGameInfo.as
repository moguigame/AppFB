package Game
{
	import MoGui.net.MsgData;
	import PublicXY.Public_XYBase;
	
	public class Game_PlayerGameInfo extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.MoGui_PLAYERGAMEINFO;
		
		public var m_PID:int;
		
		public var m_nGameMoney:Number;
		public var m_nJF:Number;
		public var m_nExperience:Number;
		
		public var m_nWinTimes:int;
		public var m_nLossTimes:int;
		
		public function Game_PlayerGameInfo()
		{
			super();
			
			m_PID = 0;
			
			m_nGameMoney = 0;
			m_nJF = 0;
			m_nExperience = 0;
			
			m_nWinTimes = 0;
			m_nLossTimes = 0;
		}
		
		override public function Write(msgdata:MsgData):void
		{
			
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_PID = msgdata.ReadUnsignedInt();
			
			m_nGameMoney = msgdata.ReadBigNumber();
			m_nJF = msgdata.ReadBigNumber();
			m_nExperience = msgdata.ReadBigNumber();
			
			m_nWinTimes = msgdata.ReadBigNumber();
			m_nLossTimes = msgdata.ReadBigNumber();
		}
	}
}