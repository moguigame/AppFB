package Game
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_RecvGift extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.GameLobbyXYID_RecvGift;
		
		public var m_RecvPID:int;
		public var m_GiftInfo:msgPlayerGiftInfo;
		
		public function Game_RecvGift()
		{
			super();
			m_GiftInfo = new msgPlayerGiftInfo();
		}
		override public function Read(msgdata:MsgData):void
		{
			m_RecvPID = msgdata.ReadInt();
			m_GiftInfo.Read(msgdata);
		}
	}
}