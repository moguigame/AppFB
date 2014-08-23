package Data
{
	public class Data_SNSPlayerInfo
	{
		public var m_PID:int;
		public var m_HeadURL:String;
		public var m_NickName:String;
		public var m_nMoney:Number;
		public var m_GameLevel:int;
		
		public var m_RoomID:int;
		public var m_TableID:int;
		public var m_SitID:int;
		public var m_PlayerState:int;
		public var m_strState:String;
		
		public function Data_SNSPlayerInfo()
		{
			m_PID = 0;
			m_HeadURL = "";
			m_NickName = "";
			m_nMoney = 0;
			m_GameLevel = 0;
			
			m_RoomID = 0;
			m_TableID = 0;
			m_SitID = 0;
			m_PlayerState = 0;
			
			m_strState = "";
		}
	}
}