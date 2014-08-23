package Game
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_ReqCreateTable extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.GameLobbyXYID_ReqCreateTable;
		
		public var m_FoundPID:int;
		public var m_PayFlag:int;
		
		public var m_MaxPlayer:int;
		public var m_nBigBlind:int;
		public var m_nMinTake:int;
		public var m_nMaxTake:int;
		public var m_Pot:int;
		public var m_Limite:int;
		
		public var m_ChipTime:int;
		public var m_Password:String;
		
		public var m_nLastTime:int;

		public function Game_ReqCreateTable()
		{
			super();
			
			m_FoundPID = 0;
			m_PayFlag = 0;
			
			m_MaxPlayer = 9;
			m_nBigBlind = 10;
			m_nMinTake = 0;
			m_nMaxTake = 0;
			m_Pot = 0;
			m_Limite = 1;
			
			m_ChipTime = 10;
			m_Password = "";
			m_nLastTime = 4;
		}
		
		override public function Write(msgdata:MsgData):void
		{
			msgdata.m_msgID = ID;
			
			msgdata.WriteInt(m_FoundPID);
			msgdata.WriteByte(m_PayFlag);
			
			msgdata.WriteByte(m_MaxPlayer);
			msgdata.WriteInt(m_nBigBlind);
			msgdata.WriteShort(m_nMinTake);
			msgdata.WriteShort(m_nMaxTake);
			msgdata.WriteShort(m_Pot);
			msgdata.WriteByte(m_Limite);
			
			msgdata.WriteByte(m_ChipTime);
			msgdata.WriteString(m_Password);
			msgdata.WriteInt(m_nLastTime);
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_FoundPID       = msgdata.ReadInt();
			m_PayFlag        = msgdata.ReadByte();
			m_MaxPlayer      = msgdata.ReadByte();
			m_nBigBlind      = msgdata.ReadInt();
			m_nMinTake       = msgdata.ReadShort();
			m_nMaxTake       = msgdata.ReadShort();
			m_Pot            = msgdata.ReadShort();
			m_Limite         = msgdata.ReadByte();
			m_ChipTime       = msgdata.ReadByte();
			m_Password       = msgdata.ReadString();
			m_nLastTime      = msgdata.ReadInt();
		}
	}
}