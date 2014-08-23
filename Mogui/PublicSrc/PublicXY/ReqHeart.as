package PublicXY
{
	import MoGui.net.MsgData;
	
	public class ReqHeart extends Public_XYBase
	{
		public static const ID:int     = PublicXYID.MOGUI_REQHEART;
		
		public var m_nHeart:Number;
		
		public function ReqHeart()
		{
			super();
			m_nHeart = 0;
		}
		
		override public function Write(msgdata:MsgData):void
		{
			msgdata.m_msgID = ID;
			
			msgdata.WriteInt64(m_nHeart);
		}
	}
}