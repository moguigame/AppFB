package Game
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_PlayerGiftInfoList extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.GameLobbyXYID_PlayerGiftInfoList;
		
		public static const CUR:int    = 1;
		public static const LAST:int   = 2;
		
		public var m_PID:int;
		public var m_Flag:int;
		public var m_nCount:int;
		public var m_arrayGiftInfo:Vector.<msgPlayerGiftInfo>;

		public function Game_PlayerGiftInfoList()
		{
			super();
			
			m_PID = 0;
			m_Flag = 0;
			m_nCount = 0;
			m_arrayGiftInfo = new Vector.<msgPlayerGiftInfo>();
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_PID     = msgdata.ReadInt();
			m_Flag    = msgdata.ReadByte();
			m_nCount  = msgdata.ReadShort();
			
			var TempGI:msgPlayerGiftInfo;
			for(var i:int=0;i<m_nCount;++i){
				TempGI = new msgPlayerGiftInfo();
				TempGI.Read(msgdata);
				m_arrayGiftInfo.push(TempGI);
			}			
		}
	}
}