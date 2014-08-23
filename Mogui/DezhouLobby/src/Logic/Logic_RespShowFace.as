package Logic
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class Logic_RespShowFace extends Public_XYBase
	{
		public static const ID:int     = Logic_XieYiID.GameXYID_RespShowFace;
		
		public var m_SitID:int;
		public var m_FaceID:int;
		public var m_PayMoney:Number;
		public var m_TableMoney:Number;
		
		public function Logic_RespShowFace()
		{
			super();
			
			m_SitID = 0;
			m_FaceID = 0;
			m_PayMoney = 0;
			m_TableMoney = 0;
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_SitID = msgdata.ReadUnsignedByte();
			m_FaceID = msgdata.ReadUnsignedByte();
			m_PayMoney = msgdata.ReadBigNumber();
			m_TableMoney = msgdata.ReadBigNumber();
		}
	}
}