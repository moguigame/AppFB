package Game
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_RespSendGift extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.GameLobbyXYID_RespSendGift;
		
		public var m_SendPID:int;
		public var m_Flag:int;
		
		public function Game_RespSendGift()
		{
			super();
			
			m_SendPID = 0;
			m_Flag    = 0;
		}		
		override public function Read(msgdata:MsgData):void
		{
			m_SendPID = msgdata.ReadInt();
			m_Flag    = msgdata.ReadUnsignedByte();
		}
	}
}