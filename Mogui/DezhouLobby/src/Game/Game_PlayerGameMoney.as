package Game
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_PlayerGameMoney extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.GameLobbyXYID_PlayerGameMoney;
		
		public var m_AID:int;
		public var m_PID:int;
		public var m_nGameMoney:Number;
		
		public function Game_PlayerGameMoney()
		{
			super();
			
			m_AID = 0;
			m_PID = 0;
			m_nGameMoney = 0;
		}
		
		override public function Write(msgdata:MsgData):void
		{
			
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_AID = msgdata.ReadShort();
			m_PID = msgdata.ReadUnsignedInt();
			m_nGameMoney = msgdata.ReadBigNumber();
		}
	}
}