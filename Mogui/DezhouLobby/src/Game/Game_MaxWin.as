package Game
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_MaxWin extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.GameLobbyXYID_MaxWin;
		
		public var m_MaxWin:Number;
		public var m_MaxWinTime:uint;		
		
		public function Game_MaxWin()
		{
			super();
			
			m_MaxWin = 0;
			m_MaxWinTime = 0;
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_MaxWin = msgdata.ReadBigNumber();
			m_MaxWinTime = msgdata.ReadUnsignedInt();
		}
	}
}