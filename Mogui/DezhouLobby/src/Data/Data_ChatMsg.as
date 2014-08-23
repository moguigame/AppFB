package Data
{
	public class Data_ChatMsg
	{
		public var m_Flag:int;
		public var m_PID:int;                       //主要是用于标识玩家字体及颜色的
		public var m_Name:String;
		public var m_Msg:String;
		
		public function Data_ChatMsg()
		{
			Init();
		}
		public function Init():void
		{
			m_Flag = 0;
			m_PID  = 0;
			m_Name = "";
			m_Msg  = "";
		}
	}
}