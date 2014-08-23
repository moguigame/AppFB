package Logic
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Logic_C2SAddMoney extends Public_XYBase
	{
		public static const ID:int     = Logic_XieYiID.GameXYID_RespAddMoney;
		
		public var m_SitID:int;
		public var m_AddMoney:Number;
		
		public function Logic_C2SAddMoney()
		{
			super();
			
			m_SitID = 0;
			m_AddMoney = 0;
		}
		
		override public function Write(msgdata:MsgData):void
		{
			msgdata.m_msgID = ID;
			msgdata.WriteByte(m_SitID);
			msgdata.WriteBigNumber(m_AddMoney);			
		}		
	}
}