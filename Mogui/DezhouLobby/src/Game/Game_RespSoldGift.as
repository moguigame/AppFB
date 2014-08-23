package Game
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_RespSoldGift extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.GameLobbyXYID_RespSoldGift;
		
		public var m_SoldPID:int;
		public var m_nMoney:Number;
		public var m_arraySoldIdx:Array;
		
		public function Game_RespSoldGift()
		{
			super();
			
			m_SoldPID = 0;
			m_nMoney = 0;
			m_arraySoldIdx = new Array();
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_SoldPID = msgdata.ReadInt();
			m_nMoney  = msgdata.ReadBigNumber();
			
			var nCount:int = msgdata.ReadUnsignedByte();
			for(var i:int=0;i<nCount;++i){
				m_arraySoldIdx.push(msgdata.ReadInt());
			}
		}
	}
}