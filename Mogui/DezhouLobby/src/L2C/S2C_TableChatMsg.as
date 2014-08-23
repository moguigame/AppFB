package L2C
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class S2C_TableChatMsg extends Public_XYBase
	{
		public static const ID:int     = LC_XieYiID.XYID_S2C_TableChat;
		
		public var m_ChatMsg:String;
		public function S2C_TableChatMsg()
		{
			super();
			m_ChatMsg = "";
		}		
		override public function Write(msgdata:MsgData):void
		{
			msgdata.m_msgID = ID;
			msgdata.WriteString(m_ChatMsg);			
		}
		override public function Read(msgdata:MsgData):void
		{
			m_ChatMsg = msgdata.ReadString();
		}
	}
}