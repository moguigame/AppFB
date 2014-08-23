package Game
{
	import MoGui.net.MsgData;
	import PublicXY.Public_XYBase;
	
	public class Game_PlayerAct extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.MoGui_PLAYERACT;
		
		public static const ACT_SITDOWN:int             = 1;
		public static const ACT_STANDUP:int             = 2;
		
		public var m_TableID:int;
		public var m_SitID:int;
		public var m_Action:int;
		public var m_PID:int;
		
		public function Game_PlayerAct()
		{
			super();
			
			m_TableID = 0;
			m_SitID = 0;
			m_Action = 0;
			m_PID = 0;			
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_TableID = msgdata.ReadUnsignedShort();
			m_SitID = msgdata.ReadUnsignedByte();
			m_Action = msgdata.ReadUnsignedByte();
			m_PID = msgdata.ReadInt();
		}
	}
}