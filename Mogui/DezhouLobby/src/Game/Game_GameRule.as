package Game
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_GameRule extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.MoGuiXYID_GameRule;
		
		public var m_strGameRule:String;
		public function Game_GameRule()
		{
			super();
			m_strGameRule = "";
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_strGameRule = msgdata.ReadString();
		}
	}
}