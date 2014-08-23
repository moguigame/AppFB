package Game
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_PlayerHonorInfoList extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.GameLobbyXYID_PlayerHonorInfoList;
		
		public var m_PID:int;
		public var m_ArrayHonorID:Vector.<int>;
		
		public function Game_PlayerHonorInfoList()
		{
			super();
			
			m_PID = 0;
			m_ArrayHonorID = new Vector.<int>();
		}
		override public function Write(msgdata:MsgData):void
		{
			
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_PID = msgdata.ReadUnsignedInt();
			var TempCount:int = msgdata.ReadUnsignedByte();
			for(var i:int;i<TempCount;i++)
			{
				m_ArrayHonorID.push(msgdata.ReadUnsignedByte());
			}
		}
	}
}