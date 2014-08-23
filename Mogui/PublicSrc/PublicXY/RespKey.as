package PublicXY
{
	import flash.utils.ByteArray;
	
	import MoGui.net.MsgData;
	
	public class RespKey extends Public_XYBase
	{
		public static const ID:int     = PublicXYID.MoGui_RespKey;
		
		public var m_Len:int;
		public var m_KeyBA:ByteArray;
		
		public function RespKey()
		{
			super();
			
			m_Len = 0;
			m_KeyBA = new ByteArray();
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_Len = msgdata.ReadUnsignedByte();
			msgdata.ReadBytes(m_KeyBA,m_Len);
		}
	}
}