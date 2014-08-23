package Game
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_ShowTableList extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.MoGuiXYID_ShowTableList;
		
		public var m_RoomID:int;
		public var m_ShowFlag:int;
		public var m_arrayTableID:Vector.<int>;
		
		public function Game_ShowTableList()
		{
			super();
			
			m_RoomID = 0;
			m_ShowFlag = 0;
			m_arrayTableID = new Vector.<int>();
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_RoomID = msgdata.ReadUnsignedShort();
			m_ShowFlag = msgdata.ReadUnsignedByte();
			
			var TableCount:int = msgdata.ReadUnsignedByte();
			for(var i:int=0;i<TableCount;i++)
			{
				m_arrayTableID.push(msgdata.ReadUnsignedShort());
			}
		}
	}
}