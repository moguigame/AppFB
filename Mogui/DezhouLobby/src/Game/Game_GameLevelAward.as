package Game
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_GameLevelAward extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.GameLobbyXYID_GameLevelAward;
		
		public var m_curLevel:int;
		public var m_curAward:int;
		public var m_GameMoney:Number;
		public var m_nextAdd:int;
		public var m_nextAward:int;
		
		public function Game_GameLevelAward()
		{
			super();
			
			m_curLevel = 0;
			m_curAward = 0;
			m_GameMoney = 0;
			m_nextAdd   = 0;
			m_nextAward = 0;
		}

		override public function Read(msgdata:MsgData):void
		{
			m_curLevel = msgdata.ReadByte();
			m_curAward = msgdata.ReadInt();
			m_GameMoney = msgdata.ReadBigNumber();
			m_nextAdd = msgdata.ReadInt();
			m_nextAward = msgdata.ReadInt();
		}
	}
}