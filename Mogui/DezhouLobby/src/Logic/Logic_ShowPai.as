package Logic
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Logic_ShowPai extends Public_XYBase
	{
		public static const ID:int     = Logic_XieYiID.GameXYID_ShowPai;
		
		public var m_SitID:int;
		public var m_arrayHandPai:Vector.<int>;		
		public function Logic_ShowPai()
		{
			super();
			
			m_SitID = 0;
			m_arrayHandPai = new Vector.<int>(2);
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_SitID = msgdata.ReadUnsignedByte();
			m_arrayHandPai[0] = msgdata.ReadUnsignedByte();
			m_arrayHandPai[1] = msgdata.ReadUnsignedByte();			
		}
	}
}