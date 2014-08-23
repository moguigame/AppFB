package PublicXY
{
	import MoGui.net.MsgData;
	
	public class Public_XieYiList extends Public_XYBase
	{
		public static const ID:int     = PublicXYID.MOGUI_XieYiList;
		
		public var m_XieYiID:int;
		public var m_XYCount:int;
		
		public function Public_XieYiList()
		{
			super();
			
			m_XieYiID = 0;
			m_XYCount = 0;
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_XieYiID = msgdata.ReadUnsignedShort();
			m_XYCount = msgdata.ReadUnsignedByte();
		}
	}
}