package Game
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_ReqSoldGift extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.GameLobbyXYID_ReqSoldGift;
		
		public var m_SoldPID:int;
		public var m_arrayGiftIdx:Array;
		
		public function Game_ReqSoldGift()
		{
			super();
			
			m_SoldPID = 0 ;
			m_arrayGiftIdx = new Array();
		}
		
		override public function Write(msgdata:MsgData):void
		{
			msgdata.m_msgID = ID;
			
			msgdata.WriteInt(m_SoldPID);
			msgdata.WriteByte(m_arrayGiftIdx.length);
			for(var i:int=0;i<m_arrayGiftIdx.length;++i){
				msgdata.WriteInt(m_arrayGiftIdx[i]);
			}
		}
	}
}