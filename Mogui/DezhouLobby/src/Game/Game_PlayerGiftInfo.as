package Game
{
	import MoGui.net.MsgData;
	import PublicXY.Public_XYBase;
	
	public class Game_PlayerGiftInfo extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.GameLobbyXYID_PlayerGiftInfo;
		
		public var m_PID:int;
		public var m_msgGift:msgPlayerGiftInfo;
		
		public function Game_PlayerGiftInfo()
		{
			super();
			
			m_PID = 0;
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_PID = msgdata.ReadInt();
			m_msgGift.Read(msgdata);
		}
	}
}