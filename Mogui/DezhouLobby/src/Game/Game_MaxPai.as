package Game
{
	import MoGui.net.MsgData;
	import Data.Data_MaxPai;
	
	import PublicXY.Public_XYBase;
	
	public class Game_MaxPai extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.GameLobbyXYID_MaxPai;
		
		public var m_MaxPai:Data_MaxPai;
		public var m_MaxPaiTime:uint;

		public function Game_MaxPai()
		{
			super();
			
			m_MaxPai = new Data_MaxPai();
			m_MaxPaiTime = 0;
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_MaxPai.Read(msgdata);
			m_MaxPaiTime = msgdata.ReadUnsignedInt();
		}
	}
}