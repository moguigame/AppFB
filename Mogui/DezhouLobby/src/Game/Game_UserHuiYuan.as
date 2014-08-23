package Game
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Game_UserHuiYuan extends Public_XYBase
	{
		public static const ID:int     = LobbyGameXYID.GameLobbyXYID_UserHuiYuan;
		
		
		public var m_PID:int;
		public var m_nAddMoney:Number;
		public var m_nGameMoney:Number;
		public var m_nDayGivenMoney:Number;
		public var m_OpenBank:int;
		public var m_FreeFaceTime:uint;
		public var m_VipLevel:int;
		public var m_VipEndTime:uint;
		public var m_ActionTime:uint;		
		
		public function Game_UserHuiYuan()
		{
			super();
			
			m_PID = 0;
			m_nAddMoney = 0;
			m_nGameMoney = 0;
			m_nDayGivenMoney = 0;
			
			m_OpenBank = 0;
			m_FreeFaceTime = 0;
			m_VipLevel = 0;
			m_VipEndTime = 0;
			m_ActionTime = 0;
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_PID = msgdata.ReadInt();
			m_nAddMoney = msgdata.ReadBigNumber();
			m_nGameMoney = msgdata.ReadBigNumber();
			m_nDayGivenMoney = msgdata.ReadBigNumber();
			
			m_OpenBank = msgdata.ReadUnsignedByte();
			m_FreeFaceTime = msgdata.ReadUnsignedInt();
			m_VipLevel = msgdata.ReadUnsignedByte();
			m_VipEndTime = msgdata.ReadUnsignedInt();
			m_ActionTime = msgdata.ReadUnsignedInt();
		}
	}
}