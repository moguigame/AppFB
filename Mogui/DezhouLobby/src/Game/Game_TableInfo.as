package Game
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_TableInfo extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.MoGui_TABLEINFO;
		
		public var m_RoomID:int;
		public var m_TableID:int;
		public var m_TableType:int;
		
		public var m_TableName:String;
		public var m_TableRule:String;
		
		public var m_MaxSitPlayerNumber:int;        //最大能一起玩的玩家
		public var m_CurSitPlayerNumber:int;        //当前坐下的玩家
		public var m_CurStandPlayerNumber:int;      //当前旁观的玩家
		
		public function Game_TableInfo()
		{
			super();
			
			m_RoomID = 0;
			m_TableID = 0;
			m_TableType = 0;
			
			m_TableName = "";
			m_TableRule = "";
			
			m_MaxSitPlayerNumber = 0;
			m_CurSitPlayerNumber = 0;
			m_CurStandPlayerNumber = 0;
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_RoomID = msgdata.ReadUnsignedShort();
			m_TableID = msgdata.ReadUnsignedShort();
			m_TableType = msgdata.ReadUnsignedByte();
			
			m_TableName = msgdata.ReadString();
			m_TableRule = msgdata.ReadString();
			
			m_MaxSitPlayerNumber = msgdata.ReadUnsignedByte();
			m_CurSitPlayerNumber = msgdata.ReadUnsignedByte();
			m_CurStandPlayerNumber = msgdata.ReadUnsignedShort();
		}
	}
}