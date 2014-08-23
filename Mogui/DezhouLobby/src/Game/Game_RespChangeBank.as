package Game
{	
	import MoGui.net.MsgData;
	import PublicXY.Public_XYBase;
	
	public class Game_RespChangeBank extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.GameLobbyXYID_RespChangeBank;
		
		public static const SUCCESS:int               = 0;
		public static const UNSUCCESS:int             = 1;
		public static const OutOfMoney:int            = 2;
		public static const NotOpenBank:int           = 3;
		public static const CantOperater:int          = 4;
		
		public var m_Flag:int;
		public var m_nChangeMoney:Number;
		public var m_nBankMoney:Number;
		public var m_nGameMoney:Number;
		
		public function Game_RespChangeBank()
		{
			super();
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_Flag = msgdata.ReadUnsignedByte();
			if( m_Flag == SUCCESS )
			{
				m_nChangeMoney = msgdata.ReadBigNumber();
				m_nBankMoney   = msgdata.ReadBigNumber();
				m_nGameMoney   = msgdata.ReadBigNumber();
			}
		}
	}
}