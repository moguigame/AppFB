package Game
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_TablePlayerCountList extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.MoGui_TABLEPLAYERCOUNTLIST;
		
		public var m_RoomID:int;
		public var m_nCount:int;
		public var m_listTablePC:Vector.<msgTablePlayerCount>;
		
		public function Game_TablePlayerCountList()
		{
			super();
			
			m_RoomID = 0;
			m_nCount = 0;
			m_listTablePC = new Vector.<msgTablePlayerCount>();
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_RoomID = msgdata.ReadUnsignedShort();
			m_nCount = msgdata.ReadUnsignedShort();
			for(var i:int=0;i<m_nCount;++i)
			{
				var TempTPC:msgTablePlayerCount = new msgTablePlayerCount();
				TempTPC.Read(msgdata);
				m_listTablePC.push(TempTPC);
			}
		}
	}
}