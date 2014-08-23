package L2C
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class S2C_MoveMoney extends Public_XYBase
	{
		public static const ID:int     = LC_XieYiID.XYID_S2C_MoveMoney;
		
		public var m_MoneyFlag:int;                 //钱的性质，比如分钱，比如下注
		public var m_ServerStartSitID:int;          //指的是服务器对应的SITID
		public var m_ServerEndSitID:int;            //结束的坐位号
		public var m_ClientStartSit:int;
		public var m_ClientEndSit:int;
		public function S2C_MoveMoney()
		{
			super();
		}
		
		override public function Write(msgdata:MsgData):void
		{
			msgdata.m_msgID = ID;
			msgdata.WriteInt(m_MoneyFlag);
			msgdata.WriteInt(m_ServerStartSitID);
			msgdata.WriteInt(m_ServerEndSitID);
			msgdata.WriteInt(m_ClientStartSit);
			msgdata.WriteInt(m_ClientEndSit);
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_MoneyFlag = msgdata.ReadInt();
			m_ServerStartSitID = msgdata.ReadInt();
			m_ServerEndSitID = msgdata.ReadInt();
			m_ClientStartSit = msgdata.ReadInt();
			m_ClientEndSit = msgdata.ReadInt();
		}
	}
}