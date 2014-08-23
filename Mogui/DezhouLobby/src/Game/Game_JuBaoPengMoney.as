package Game
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_JuBaoPengMoney extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.GameLobbyXYID_JuBaoPengMoney;
		
		public var m_JuBaoPengMoney:Number;
		public function Game_JuBaoPengMoney()
		{
			super();
			m_JuBaoPengMoney = 0;
		}
		
		override public function Write(msgdata:MsgData):void
		{
			
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_JuBaoPengMoney = msgdata.ReadInt64();
		}
	}
}