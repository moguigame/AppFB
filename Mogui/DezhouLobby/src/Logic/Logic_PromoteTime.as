package Logic
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Logic_PromoteTime extends Public_XYBase
	{
		public static const ID:int     = Logic_XieYiID.GameXYID_PromoteTime;
		
		public var m_Step:int;
		public var m_LeftTime:int;
		public var m_AwardMoney:int;
		
		public function Logic_PromoteTime()
		{
			super();
			
			m_Step = 0;
			m_LeftTime = 0;
			m_AwardMoney = 0;
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_Step = msgdata.ReadUnsignedByte();
			m_LeftTime = msgdata.ReadUnsignedInt();
			m_AwardMoney = msgdata.ReadInt();
		}
	}
}