package Logic
{
	import MoGui.net.MsgData;	
	import PublicXY.Public_XYBase;
	
	public class Logic_ReqSendGift extends Public_XYBase
	{
		public static const ID:int     = Logic_XieYiID.GameXYID_SendGift;
		
		public var m_GiftID:int;
		public var m_SendPID:int;		
		public var m_vecToPID:Vector.<int>;
		
		public function Logic_ReqSendGift()
		{
			super();
			
			m_GiftID = 0;
			m_SendPID = 0;			
			m_vecToPID = new Vector.<int>();
		}
		
		override public function Write(msgdata:MsgData):void
		{
			msgdata.m_msgID = ID;
			
			msgdata.WriteShort(m_GiftID);
			msgdata.WriteInt(m_SendPID);
			msgdata.WriteByte(m_vecToPID.length);
			for(var i:int=0;i<m_vecToPID.length;++i){
				msgdata.WriteInt(m_vecToPID[i]);
			}
		}
	}
}