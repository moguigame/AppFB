package Game
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_ReqTailInfo extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.GameLobbyXYID_ReqTailInfo;
		
		public static const TailInfo:int     = 1;
		public static const GiftInfo:int     = 2;
		public static const HonorInfo:int    = 4;
		
		public var m_Flag:int;
		public var m_nValue:int;

		public function Game_ReqTailInfo()
		{
			super();
			
			m_Flag = 0;
			m_nValue = 0;
		}
		
		override public function Write(msgdata:MsgData):void
		{
			msgdata.m_msgID = ID;
			msgdata.WriteByte(m_Flag);
			msgdata.WriteInt(m_nValue);
		}
	}
}