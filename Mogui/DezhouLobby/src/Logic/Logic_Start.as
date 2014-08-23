package Logic
{	
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Logic_Start extends Public_XYBase
	{
		public static const ID:int     = Logic_XieYiID.GameXYID_GameStart;
		
		public function Logic_Start()
		{
			super();
		}
		
		override public function Write(msgdata:MsgData):void
		{
			msgdata.m_msgID = ID;
		}		
		override public function Read(msgdata:MsgData):void
		{
		}
	}
}