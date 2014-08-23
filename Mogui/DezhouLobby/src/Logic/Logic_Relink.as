package Logic
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Logic_Relink extends Public_XYBase
	{
		public static const ID:int     = Logic_XieYiID.GameXYID_ReLink;
		
		public static const Start:int = 1;
		public static const End:int   = 2;
		
		public var m_Flag:int;
		
		public function Logic_Relink()
		{
			super();
			
			m_Flag = 0;
		}
		override public function Read(msgdata:MsgData):void
		{
			m_Flag = msgdata.ReadUnsignedByte();
		}
	}
}