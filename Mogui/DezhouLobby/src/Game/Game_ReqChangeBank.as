package Game
{
	import MoGui.net.MsgData;
	import PublicXY.Public_XYBase;
	
	public class Game_ReqChangeBank extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.GameLobbyXYID_ReqChangeBank;
		
		public static const BankToGame:int             = 0;
		public static const GameToBank:int             = 1;
		
		public var m_PID:int;
		public var m_Flag:int;
		public var m_nChangMoney:Number;
		
		public function Game_ReqChangeBank()
		{
			super();
			
			m_PID = 0;
			m_Flag = 0;
			m_nChangMoney = 0;
		}
		
		override public function Write(msgdata:MsgData):void
		{
			msgdata.m_msgID = ID;
			
			msgdata.WriteInt(m_PID);
			msgdata.WriteByte(m_Flag);
			msgdata.WriteBigNumber(m_nChangMoney);
		}
	}
}