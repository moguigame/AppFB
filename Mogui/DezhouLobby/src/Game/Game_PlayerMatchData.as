package Game
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_PlayerMatchData extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.MoGuiXYID_PlayerMatchData;
		
		public var m_AID:int;
		public var m_PID:int
		
		public var m_TaoJinTimes:int;
		public var m_TaoJinWinMoney:Number;		
		public var m_TaoJinBest:int;;
		public var m_TaoJinBestTime:int;;
		
		public var m_JingBiaoTimes:int;;
		public var m_JingBiaoWinMoney:Number;
		public var m_JingBiaoBest:int;;
		public var m_JingBiaoBestTime:int;;
		
		public var m_GuanJunTimes:int;;
		public var m_GuanJunWinMoney:Number;
		public var m_GuanJunBest:int;;
		public var m_GuanJunBestTime:int;
		
		public function Game_PlayerMatchData()
		{
			super();
			
			m_AID = 0;
			m_PID = 0;
			
			m_TaoJinTimes = 0;
			m_TaoJinWinMoney = 0;
			m_TaoJinBest = 0;
			m_TaoJinBestTime = 0;
			
			m_JingBiaoTimes = 0;
			m_JingBiaoWinMoney = 0;
			m_JingBiaoBest = 0;
			m_JingBiaoBestTime = 0;
			
			m_GuanJunTimes = 0;
			m_GuanJunWinMoney = 0;
			m_GuanJunBest = 0;
			m_GuanJunBestTime = 0;
		}
		
		override public function Write(msgdata:MsgData):void
		{
			
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_AID = msgdata.ReadShort();
			m_PID = msgdata.ReadUnsignedInt();
			
			m_TaoJinTimes = msgdata.ReadInt();
			m_TaoJinWinMoney = msgdata.ReadInt64();
			m_TaoJinBest = msgdata.ReadInt();
			m_TaoJinBestTime = msgdata.ReadUnsignedInt();
			
			m_JingBiaoTimes = msgdata.ReadInt();
			m_JingBiaoWinMoney = msgdata.ReadInt64();
			m_JingBiaoBest = msgdata.ReadInt();
			m_JingBiaoBestTime = msgdata.ReadUnsignedInt();
			
			m_GuanJunTimes = msgdata.ReadInt();
			m_GuanJunWinMoney = msgdata.ReadInt64();
			m_GuanJunBest = msgdata.ReadInt();
			m_GuanJunBestTime = msgdata.ReadUnsignedInt();
		}
	}
}