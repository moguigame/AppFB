package L2C
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class S2L_DoubleClickTable extends Public_XYBase
	{
		public static const ID:int     = LC_XieYiID.XYID_S2L_DoubleClickTable;
		
		public var m_Place:int;
		public var m_RoomID:int;
		public var m_TableID:int;
		public function S2L_DoubleClickTable()
		{
			super();
			
			m_Place = 0;
			m_RoomID = 0;
			m_TableID = 0;
		}
		
		override public function Write(msgdata:MsgData):void
		{
			msgdata.m_msgID = ID;
			msgdata.WriteInt(m_Place);
			msgdata.WriteInt(m_RoomID);
			msgdata.WriteInt(m_TableID);
		}		
		override public function Read(msgdata:MsgData):void
		{
			m_Place = msgdata.ReadInt();
			m_RoomID = msgdata.ReadInt();
			m_TableID = msgdata.ReadInt();
		}
	}
}