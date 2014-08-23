package Logic
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Logic_TableChat extends Public_XYBase
	{
		public static const ID:int     = Logic_XieYiID.GameXYID_TableChat;
		
		public var m_PID:int;
		public var m_strChat:String;
		public function Logic_TableChat()
		{
			super();
			
			m_PID = 0;
			m_strChat = "";
		}
		
		override public function Write(msgdata:MsgData):void
		{
			msgdata.m_msgID = ID;
			msgdata.WriteInt(m_PID);
			msgdata.WriteString(m_strChat);
		}		
		override public function Read(msgdata:MsgData):void
		{
			m_PID     = msgdata.ReadInt();
			m_strChat = msgdata.ReadString();
		}
	}
}