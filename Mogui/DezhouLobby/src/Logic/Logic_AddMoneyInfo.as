package Logic
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Logic_AddMoneyInfo extends Public_XYBase
	{
		public static const ID:int     = Logic_XieYiID.GameXYID_AddMoneyInfo;		
		
		public static const SUCCESS:int         = 0;
		public static const UNSUCCESS:int       = 1;
		public static const OUTMONEY:int        = 2;     //游戏币不足
		public static const FULLMONEY:int       = 3;     //你不需要再加游戏币
		public static const PLAYING:int         = 4;     //游戏中
		public static const MATCH:int           = 5;     //比赛中
		public static const TAKELESSMONEY:int   = 6;     //加的钱太少了
		
		public var m_Flag:int;
		public var m_AddMoney:Number;
		public var m_TableMoney:Number;
		public var m_GameMoney:Number;
		
		public function Logic_AddMoneyInfo()
		{
			super();
			
			m_Flag = 0;
			m_AddMoney = 0;
			m_TableMoney = 0;
			m_GameMoney = 0;
		}		
		override public function Read(msgdata:MsgData):void
		{
			m_Flag = msgdata.ReadUnsignedByte();
			if( m_Flag == SUCCESS )
			{
				m_AddMoney = msgdata.ReadBigNumber();
				m_TableMoney = msgdata.ReadBigNumber();
				m_GameMoney = msgdata.ReadBigNumber();
			}			
		}
	}
}