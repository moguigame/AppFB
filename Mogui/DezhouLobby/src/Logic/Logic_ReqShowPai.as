package Logic
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Logic_ReqShowPai extends Public_XYBase
	{
		public static const ID:int     = Logic_XieYiID.GameXYID_ReqShowPai;
		
		public var m_SitID:int;
		public function Logic_ReqShowPai()
		{
			super();
			
			m_SitID = 0;
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_SitID = msgdata.ReadUnsignedByte();
		}
	}
}