package Game
{
	import PublicXY.Public_XYBase;
	import MoGui.net.MsgData;
	
	public class Game_PlayerMoguiMoney extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.GameLobbyXYID_PlayerMoGuiMoney;
		
		public var m_AID:int;
		public var m_PID:int;
		public var m_nMoguiMoney:Number;
		
		public function Game_PlayerMoguiMoney()
		{
			super();
			m_AID = 0;
			m_PID = 0;
			m_nMoguiMoney = 0;
		}
		
		override public function Write(msgdata:MsgData):void
		{
			
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_AID = msgdata.ReadShort();
			m_PID = msgdata.ReadUnsignedInt();
			m_nMoguiMoney = msgdata.ReadBigNumber();
		}
	}
}