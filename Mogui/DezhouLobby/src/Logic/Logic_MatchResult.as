package Logic
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Logic_MatchResult extends Public_XYBase
	{
		public static const ID:int     = Logic_XieYiID.GameXYID_MatchResult;
		
		public var m_MatchID:int;
		public var m_Position:int;
		public var m_nAwardMoney:Number;
		public var m_nGameMoney:Number;
		public var m_nAwardJF:Number;
		public var m_nMatchJF:Number;
		
		public function Logic_MatchResult()
		{
			super();
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_MatchID = msgdata.ReadInt();
			m_Position = msgdata.ReadInt();
			
			m_nAwardMoney = msgdata.ReadBigNumber();
			m_nGameMoney = msgdata.ReadBigNumber();
			m_nAwardJF = msgdata.ReadBigNumber();
			m_nMatchJF = msgdata.ReadBigNumber();
		}
	}
}