package Logic
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Logic_GameState extends Public_XYBase
	{
		public static const ID:int     = Logic_XieYiID.GameXYID_GameState;
		
		public var m_GameST:int;
		public function Logic_GameState()
		{
			super();
			
			m_GameST = 0;
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_GameST = msgdata.ReadUnsignedByte();
		}
	}
}