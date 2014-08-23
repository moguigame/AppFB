package L2C
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class S2C_ClickSitDownButton extends Public_XYBase
	{
		public static const ID:int     = LC_XieYiID.XYID_S2C_ClickSitDownButton;
		
		public static const BtnFlag_SitDown:int      = 1;
		
		public var m_ButtonIdx:int;      //第几个BUTTON
		
		public function S2C_ClickSitDownButton()
		{
			super();
			
			m_ButtonIdx = 0;
		}		
		override public function Write(msgdata:MsgData):void
		{
			msgdata.m_msgID = ID;			
			msgdata.WriteInt(m_ButtonIdx);
		}		
		override public function Read(msgdata:MsgData):void
		{			
			m_ButtonIdx = msgdata.ReadInt();
		}
	}
}