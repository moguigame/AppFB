package Game
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_RespCreateTable extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.GameLobbyXYID_RespCreateTable;
		
		public static const SUCCESS:int               = 0;
		public static const UNSUCCESS:int             = 1;
		public static const NOMONEY:int               = 2;
		
		public var m_Flag:int;
		public var m_FoundPID:int;
		public var m_PayMoney:Number;
		public var m_GameMoney:Number;
		
		public function Game_RespCreateTable()
		{
			super();
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_Flag = msgdata.ReadUnsignedByte();
			if( m_Flag == SUCCESS )
			{
				m_FoundPID     = msgdata.ReadInt();
				m_PayMoney     = msgdata.ReadBigNumber();
				m_GameMoney    = msgdata.ReadBigNumber();
			}
		}
	}
}