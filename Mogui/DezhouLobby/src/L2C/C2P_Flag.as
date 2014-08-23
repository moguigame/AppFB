package L2C
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class C2P_Flag extends Public_XYBase
	{
		public static const ID:int     = LC_XieYiID.XYID_C2P_Flag;
		
		public static const FaceOver:int           = 1;
		
		public var m_Flag:int;
		public var m_Value:Number;
		public function C2P_Flag()
		{
			super();
			
			m_Flag = 0;
			m_Value = 0;
		}
		override public function Write(msgdata:MsgData):void
		{
			msgdata.m_msgID = ID;
			msgdata.WriteInt(m_Flag);
			msgdata.WriteInt64(m_Value);
		}
		override public function Read(msgdata:MsgData):void
		{
			m_Flag     = msgdata.ReadInt();
			m_Value    = msgdata.ReadInt64();
		}
	}
}