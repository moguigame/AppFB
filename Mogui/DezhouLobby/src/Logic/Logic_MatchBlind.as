package Logic
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Logic_MatchBlind extends Public_XYBase
	{
		public static const ID:int     = Logic_XieYiID.GameXYID_MatchBlind;
		
		public var m_BigBlind:int;
		public var m_SmallBlind:int;		
		public function Logic_MatchBlind()
		{
			super();
			
			m_BigBlind = 0;
			m_SmallBlind = 0;
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_BigBlind = msgdata.ReadInt();
			m_SmallBlind = msgdata.ReadInt();
		}
	}
}