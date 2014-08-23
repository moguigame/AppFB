package L2C
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class S2C_MoveMinPai extends Public_XYBase
	{
		public static const ID:int     = LC_XieYiID.XYID_S2C_MoveMinPai;
		
		public static const FaPaiQu:int      = -1;
		
		public var m_StartSit:int;                       //起始或者终止位置-1表示发牌区，0-8表示各个玩家区
		public var m_EndSit:int;
		public var m_Idx:int;
		
		public function S2C_MoveMinPai()
		{
			super();
			
			m_StartSit = 0;
			m_EndSit = 0;
			m_Idx = 0;
		}
		
		override public function Write(msgdata:MsgData):void
		{
			msgdata.m_msgID = ID;
			msgdata.WriteInt(m_StartSit);
			msgdata.WriteInt(m_EndSit);
			msgdata.WriteInt(m_Idx);
		}		
		override public function Read(msgdata:MsgData):void
		{
			m_StartSit = msgdata.ReadInt();
			m_EndSit   = msgdata.ReadInt();
			m_Idx      = msgdata.ReadInt();
		}
	}
}