package Data
{
	//主要用于接收由WEB传进来的参数配置
	public class Data_WebPrama
	{
		public var m_AID:int;
		public var m_PID:int;
		public var m_LoginSession:String;
		
		public function Data_WebPrama()
		{
			m_AID = 0;
			m_PID = 0;
			m_LoginSession = "";
		}
	}
}