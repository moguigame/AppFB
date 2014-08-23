package Game
{
	import Data.Data_MaxPai
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_PlayerDataEx extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.MoGuiXYID_PlayerDataEx;
		
		public var m_AID:int;
		public var m_PID:int;
		
		public var m_dataMaxPai:Data_MaxPai;
		public var m_MaxPaiTime:int;
		public var m_MaxMoney:Number;
		public var m_MaxMoneyTime:int;
		public var m_MaxWin:Number;
		public var m_MaxWinTime:int;
		
		public var m_VipLevel:int;
		public var m_FriendCount:int;
		
		
		public function Game_PlayerDataEx()
		{
			super();
			
			m_AID = 0;
			m_PID = 0;
			
			m_dataMaxPai = new Data_MaxPai();
			m_MaxPaiTime = 0;
			m_MaxMoney = 0;
			m_MaxMoneyTime = 0;
			m_MaxWin = 0;
			m_MaxWinTime = 0;
			
			m_VipLevel = 0;
			m_FriendCount = 0;
		}
		
		override public function Write(msgdata:MsgData):void
		{
			
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_AID = msgdata.ReadShort();
			m_PID = msgdata.ReadUnsignedInt();
			
			m_dataMaxPai.Read(msgdata);
			m_MaxPaiTime = msgdata.ReadUnsignedInt();
			m_MaxMoney = msgdata.ReadInt64();
			m_MaxMoneyTime = msgdata.ReadUnsignedInt();
			m_MaxWin = msgdata.ReadInt64();
			m_MaxWinTime = msgdata.ReadUnsignedInt();
			
			m_VipLevel = msgdata.ReadUnsignedByte();
			m_FriendCount = msgdata.ReadShort();
		}
	}
}