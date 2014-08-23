package Game
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_RespChangeGift extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.GameLobbyXYID_RespChangGift;
		
		public var m_nFlag:int;
		public var m_PID:int;
		public var m_GiftID:int;
		
		public function Game_RespChangeGift()
		{
			super();
			
			m_nFlag = 0;
			m_PID = 0;
			m_GiftID = 0;
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_nFlag = msgdata.ReadUnsignedByte();
			if( m_nFlag == 0 ){
				m_PID = msgdata.ReadInt();
				m_GiftID = msgdata.ReadShort();
			}			
		}
	}
}