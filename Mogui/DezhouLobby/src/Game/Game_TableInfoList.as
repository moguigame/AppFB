package Game
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_TableInfoList extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.MoGui_TABLEINFOLIST;
		
		public var m_RoomID:int;
		public var m_TableList:Vector.<Game_TableInfo>;
		
		public function Game_TableInfoList()
		{
			super();
			
			m_RoomID = 0;
			m_TableList = new Vector.<Game_TableInfo>();
		}
		
		override public function Read(msgdata:MsgData):void
		{
			var TempCount:int = 0;
			var TempTI:Game_TableInfo;
			
			m_RoomID = msgdata.ReadUnsignedShort();
			TempCount = msgdata.ReadUnsignedByte();
			for(var i:int=0;i<TempCount;i++)
			{
				TempTI = new Game_TableInfo();
				TempTI.Read(msgdata);
				m_TableList.push(TempTI);
			}
		}
	}
}