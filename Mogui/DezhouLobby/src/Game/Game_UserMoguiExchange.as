package Game
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_UserMoguiExchange extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.GameLobbyXYID_UserMoguiExchange;
		
		public var m_PID:int;
		public var m_nAddMoguiMoney:Number;
		public var m_nMoguiMoney:Number;
		
		public function Game_UserMoguiExchange()
		{
			super();
			
			m_PID = 0;
			m_nAddMoguiMoney = 0;
			m_nMoguiMoney = 0;
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_PID = msgdata.ReadInt();
			m_nAddMoguiMoney = msgdata.ReadBigNumber();
			m_nMoguiMoney = msgdata.ReadBigNumber();
		}
	}
}