package Game
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_PlayerStateInfoList extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.GameLobbyXYID_PlayerStateInfoList;
		
		public var m_nCount:int;
		public var m_ArrayPlayerStateInfoList:Vector.<Game_PlayerStateInfo>;
		
		public function Game_PlayerStateInfoList()
		{
			super();
			
			m_nCount = 0;
			m_ArrayPlayerStateInfoList = new Vector.<Game_PlayerStateInfo>();
		}
		
		override public function Write(msgdata:MsgData):void
		{
			
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_nCount = msgdata.ReadUnsignedShort();
			
			for(var i:int=0;i<m_nCount;i++)
			{
				var TempPSInfo:Game_PlayerStateInfo = new Game_PlayerStateInfo();
				TempPSInfo.Read(msgdata);
				m_ArrayPlayerStateInfoList.push(TempPSInfo);
			}
			//trace("PlayerStateInfoList count="+m_nCount+" Size="+m_ArrayPlayerStateInfoList.length);			
		}
	}
}