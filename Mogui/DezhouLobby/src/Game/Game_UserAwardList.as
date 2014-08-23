package Game
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_UserAwardList extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.GameLobbyXYID_UserAwardList;
		
		public var m_PID:int;
		public var m_nMoney:Number;
		public var m_nCount:int;
		public var m_listAwardInfo:Vector.<msgUserAward>;
		
		public function Game_UserAwardList()
		{
			super();
			
			m_PID = 0;
			m_nMoney = 0;
			m_nCount = 0;
			m_listAwardInfo = new Vector.<msgUserAward>();
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_PID = msgdata.ReadInt();
			m_nMoney = msgdata.ReadBigNumber();
			m_nCount = msgdata.ReadShort();
			for(var i:int=0;i<m_nCount;i++)
			{
				var TempUserAward:msgUserAward = new msgUserAward();
				TempUserAward.Read(msgdata);
				m_listAwardInfo.push(TempUserAward);
			}			
		}
	}
}