package L2C
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class S2C_AddChipInfo extends Public_XYBase
	{
		public static const ID:int     = LC_XieYiID.XYID_S2C_AddChipInfo;
		
		public var m_ChipAction:int;
		public var m_ChipValue:Number;
		
		public function S2C_AddChipInfo()
		{
			super();
		}
		
		override public function Write(msgdata:MsgData):void
		{
			msgdata.m_msgID = ID;
			msgdata.WriteInt(m_ChipAction);
			msgdata.WriteInt64(m_ChipValue);
		}
		override public function Read(msgdata:MsgData):void
		{
			m_ChipAction = msgdata.ReadInt();
			m_ChipValue = msgdata.ReadInt64();
		}
	}
}