package Logic
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Logic_PlayerGameMoney extends Public_XYBase
	{
		public static const ID:int     = Logic_XieYiID.GameXYID_GameMoney;
		
		public var m_SitID:int;
		public var m_nGameMoney:Number;
		
		public function Logic_PlayerGameMoney()
		{
			super();
			
			m_SitID = 0;
			m_nGameMoney = 0;
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_SitID = msgdata.ReadUnsignedByte();
			m_nGameMoney = msgdata.ReadBigNumber();
		}
	}
}