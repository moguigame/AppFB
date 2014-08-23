package Logic
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Logic_TableQuickChat extends Public_XYBase
	{
		public static const ID:int     = Logic_XieYiID.GameXYID_TableQuickChat;
		
		public var m_PID:int;
		public var m_Idx:int;
		public function Logic_TableQuickChat()
		{
			super();
		}
		
		override public function Write(msgdata:MsgData):void
		{
			msgdata.m_msgID = ID;
			msgdata.WriteInt(m_PID);
			msgdata.WriteByte(m_Idx);			
		}		
		override public function Read(msgdata:MsgData):void
		{
			m_PID   = msgdata.ReadInt();
			m_Idx   = msgdata.ReadUnsignedByte();
		}
	}
}