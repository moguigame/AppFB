package Game
{
	import MoGui.net.MsgData;	
	import PublicXY.Public_XYBase;
	
	public class Game_RoomInfo extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.MoGui_ROOMINFO;
		
		public var m_RoomID:int;
		public var m_RoomName:String;
		public var m_RoomRule:String;
		
		public var m_MaxPlayerInRoom:int;
		public var m_CurPlayerInRoom:int;
		 
		public var m_Place:int;                   //指房间摆放的位置
		public var m_RoomType:int;                //排队模式还是自已坐的模式
		public var m_NeedPassword:int;            //是否需要密码访问
		
		public function Game_RoomInfo()
		{
			super();
			
			m_RoomID = 0;
			m_RoomName = "";
			m_RoomRule = "";
			
			m_MaxPlayerInRoom = 0;
			m_CurPlayerInRoom = 0;
			
			m_Place = 0;
			m_RoomType = 0;
			m_NeedPassword = 0;
		}
		
		override public function Write(msgdata:MsgData):void
		{
			
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_RoomID = msgdata.ReadUnsignedShort();
			m_RoomName = msgdata.ReadString();
			m_RoomRule = msgdata.ReadString();
			
			m_MaxPlayerInRoom = msgdata.ReadUnsignedShort();
			m_CurPlayerInRoom = msgdata.ReadUnsignedShort();
			
			m_Place = msgdata.ReadUnsignedByte();
			m_RoomType = msgdata.ReadUnsignedByte();
			m_NeedPassword = msgdata.ReadUnsignedByte();
		}
	}
}