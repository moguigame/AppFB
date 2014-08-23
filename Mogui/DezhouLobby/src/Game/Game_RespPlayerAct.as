package Game
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_RespPlayerAct extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.MoGui_RESPPLAYERACT;
		
		public var m_Flag:int;
		public var m_ShowFlag:int;
		public var m_strMsg:String;
		
		public function Game_RespPlayerAct()
		{
			super();
			
			m_Flag = 0;
			m_ShowFlag = 0;
			m_strMsg = "";
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_Flag = msgdata.ReadUnsignedByte();
			m_ShowFlag = msgdata.ReadUnsignedByte();
			m_strMsg = msgdata.ReadString();
		}
	}
}