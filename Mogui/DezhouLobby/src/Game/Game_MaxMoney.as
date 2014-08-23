package Game
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_MaxMoney extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.GameLobbyXYID_MaxMoney;
		
		public var m_MaxMoney:Number;
		public var m_MaxMoneyTime:uint;
		
		public function Game_MaxMoney()
		{
			super();
			
			m_MaxMoney = 0;
			m_MaxMoneyTime = 0;
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_MaxMoney = msgdata.ReadBigNumber();
			m_MaxMoneyTime = msgdata.ReadUnsignedInt();
		}
	}
}