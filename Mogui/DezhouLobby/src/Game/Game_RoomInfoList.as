package Game
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_RoomInfoList extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.MoGui_ROOMINIFOLIST;
		
		public var m_nCount:int;
		public var m_ArrayRoomInfo:Vector.<Game_RoomInfo>;
		public function Game_RoomInfoList()
		{
			super();
			m_nCount = 0;
			m_ArrayRoomInfo = new Vector.<Game_RoomInfo>();
		}
		
		override public function Write(msgdata:MsgData):void
		{
			
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_nCount = msgdata.ReadUnsignedByte();
			for(var i:int=0;i<m_nCount;i++)
			{
				var TempRoomInfo:Game_RoomInfo = new Game_RoomInfo();
				TempRoomInfo.Read(msgdata);
				m_ArrayRoomInfo.push(TempRoomInfo);		
			}			
		}
	}
}