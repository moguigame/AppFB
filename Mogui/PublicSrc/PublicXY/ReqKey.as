package PublicXY
{
	import MoGui.net.MsgData;

	public class ReqKey extends Public_XYBase
	{
		public static const ID:int     = PublicXYID.MoGui_ReqKey;
		
		public var m_Flag:int;
		public function ReqKey()
		{
			super();
			
			m_Flag = 0;
		}
		
		override public function Write(msgdata:MsgData):void
		{
			msgdata.m_msgID = ID;
			
			msgdata.WriteByte(m_Flag);
		}
	}
}