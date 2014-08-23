package Game
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_ReqPlayerAct extends Public_XYBase
	{
		public static const ID:int            = LobbyGameXYID.MoGui_REQPLAYERACT;
		public static const SITDOWN:int       = 1;
		public static const STANDUP:int       = 2;
		public static const CHANGESIT:int     = 3;
		
		public var m_Action:int;
		public var m_SitID:int;
		public var m_TableID:int;
		public var m_nTakeMoney:Number;
		
		public function Game_ReqPlayerAct()
		{
			super();
			
			m_Action = 0;
			m_SitID = 0;
			m_TableID = 0;
			m_nTakeMoney = 0;
		}
		
		override public function Write(msgdata:MsgData):void
		{
			msgdata.m_msgID = ID;
			
			msgdata.WriteByte(m_Action);
			msgdata.WriteByte(m_SitID);
			msgdata.WriteShort(m_TableID);
			msgdata.WriteBigNumber(m_nTakeMoney);
		}
	}
}