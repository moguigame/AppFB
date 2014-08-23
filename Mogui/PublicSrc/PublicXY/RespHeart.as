package PublicXY
{	
	import MoGui.net.MsgData;
	
	public class RespHeart extends Public_XYBase
	{
		public static const ID:int     = PublicXYID.MOGUI_RESQHEART;
		
		public var m_nHeart:Number;
		
		public function RespHeart()
		{
			super();
			m_nHeart = 0;
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_nHeart = msgdata.ReadInt64();
		}
	}
}