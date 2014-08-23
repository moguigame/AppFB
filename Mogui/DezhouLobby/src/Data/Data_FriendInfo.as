package Data
{
	public class Data_FriendInfo
	{
		public var m_PID:int;
		public var m_HeadURL:String;
		public var m_NickName:String;
		public var m_nGameMoney:Number;
		public var m_GameLevel:int;
		
		public function Data_FriendInfo()
		{
			m_PID         = 0;
			m_HeadURL     = "";
			m_NickName    = "";
			m_nGameMoney  = 0;
			m_GameLevel   = 0;
		}
		
		public function Copy(dataSrc:Data_FriendInfo):void
		{
			m_PID         = dataSrc.m_PID;
			m_HeadURL     = dataSrc.m_HeadURL;
			m_NickName    = dataSrc.m_NickName;
			m_nGameMoney  = dataSrc.m_nGameMoney;
			m_GameLevel   = dataSrc.m_GameLevel;
		}
	}
}