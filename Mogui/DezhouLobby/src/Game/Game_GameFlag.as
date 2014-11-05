package Game
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_GameFlag extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.MoGui_GAME_FLAG;
		
		public static const SUCCESS:int              = 0;
		public static const LAND_OTHER_PLACE:int     = 1;
		public static const CheckClientExist:int     = 2;
		public static const LobbyReady:int           = 3;
		
		public var m_Flag:int;
		public var m_nValue:int;
		
		public function Game_GameFlag()
		{
			super();
			m_Flag = 0;
			m_nValue = 0;
		}
		
		override public function Write(msgdata:MsgData):void
		{
			
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_Flag = msgdata.ReadInt();
			m_nValue = msgdata.ReadInt();
		}
	}
}