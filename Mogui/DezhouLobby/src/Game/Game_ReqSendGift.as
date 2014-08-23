package Game
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_ReqSendGift extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.GameLobbyXYID_ReqSendGift;
		
		public var m_GiftID:int;
		public var m_SendPID:int;
		public var m_arrayRecvPID:Array;
		
		public function Game_ReqSendGift()
		{
			super();
			
			m_arrayRecvPID = new Array();
		}
		override public function Write(msgdata:MsgData):void
		{
			msgdata.m_msgID = ID;
			
			msgdata.WriteShort(m_GiftID);
			msgdata.WriteInt(m_SendPID);
			msgdata.WriteByte(m_arrayRecvPID.length);
			for(var i:int=0;i<m_arrayRecvPID.length;++i){
				msgdata.WriteInt(m_arrayRecvPID[i]);
			}
		}
	}
}