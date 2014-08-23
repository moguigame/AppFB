package Game
{
	import PublicXY.Public_XYBase;
	import MoGui.net.MsgData;
	
	public class Game_ReqChangeGift extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.GameLobbyXYID_ReqChangGift;
		
		public var m_PID:int;
		public var m_GiftIdx:int;
		
		public function Game_ReqChangeGift()
		{
			super();
			
			m_PID = 0;
			m_GiftIdx = 0;
		}
		
		override public function Write(msgdata:MsgData):void
		{
			msgdata.m_msgID = ID;
			
			msgdata.WriteInt(m_PID);
			msgdata.WriteInt(m_GiftIdx);
		}
	}
}