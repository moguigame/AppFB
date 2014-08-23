package Logic
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Logic_GamePlayerInfo extends Public_XYBase
	{
		public static const ID:int     = Logic_XieYiID.GameXYID_GamePlayerInfo;
		
		public var m_nPlayerCount:int;
		public var m_arrayPlayerInfo:Vector.<Logic_msgGamePlayerInfo>;

		public function Logic_GamePlayerInfo()
		{
			super();
			
			m_nPlayerCount = 0;
			m_arrayPlayerInfo = new Vector.<Logic_msgGamePlayerInfo>();
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_nPlayerCount = msgdata.ReadUnsignedByte();
			for(var i:int=0;i<m_nPlayerCount;++i)
			{
				var TempGPI:Logic_msgGamePlayerInfo = new Logic_msgGamePlayerInfo();
				TempGPI.Read(msgdata);
				m_arrayPlayerInfo.push(TempGPI);
			}
		}
	}
}