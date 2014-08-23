package Logic
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Logic_ReqShowFace extends Public_XYBase
	{
		public static const ID:int     = Logic_XieYiID.GameXYID_ReqShowFace;
		
		public var m_SitID:int;
		public var m_FaceID:int;
		public function Logic_ReqShowFace()
		{
			super();
			
			m_SitID = 0;
			m_FaceID = 0;
		}
		
		override public function Write(msgdata:MsgData):void
		{
			msgdata.m_msgID = ID;
			msgdata.WriteByte(m_SitID);
			msgdata.WriteByte(m_FaceID);			
		}
	}
}