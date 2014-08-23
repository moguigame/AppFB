package Game
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_ReqPlayerGiftInfo extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.GameLobbyXYID_ReqPlayerGiftInfo;
		
		public var m_PID:int;
		public function Game_ReqPlayerGiftInfo()
		{
			super();
			
			m_PID = 0;
		}
		
		override public function Write(msgdata:MsgData):void
		{
			msgdata.m_msgID = ID;
			msgdata.WriteInt(m_PID);
		}
	}
}