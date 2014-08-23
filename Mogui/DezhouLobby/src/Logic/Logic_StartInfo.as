package Logic
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Logic_StartInfo extends Public_XYBase
	{
		public static const ID:int     = Logic_XieYiID.GameXYID_StartInfo;
		
		public var m_nPlayerCount:int;
		public var m_arrayPlayerInfo:Vector.<Logic_msgStartPlayerInfo>;

		public function Logic_StartInfo()
		{
			super();
			
			m_nPlayerCount = 0;
			m_arrayPlayerInfo = new Vector.<Logic_msgStartPlayerInfo>();
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_nPlayerCount = msgdata.ReadUnsignedByte();
			for(var i:int=0;i<m_nPlayerCount;++i)
			{
				var TempPI:Logic_msgStartPlayerInfo = new Logic_msgStartPlayerInfo();
				TempPI.Read(msgdata);
				m_arrayPlayerInfo.push(TempPI);
			}
		}
	}
}