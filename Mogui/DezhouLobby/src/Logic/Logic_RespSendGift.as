package Logic
{
	import MoGui.net.MsgData;
	import PublicXY.Public_XYBase;
	
	public class Logic_RespSendGift extends Public_XYBase
	{
		public static const ID:int     = Logic_XieYiID.GameXYID_RespSendGift;
		
		public var m_Flag:int;
		public var m_GiftID:int;
		public var m_SendPID:int;		
		public var m_vecToPID:Vector.<int>;
		

		public function Logic_RespSendGift()
		{
			super();
			
			m_Flag = 0;
			m_GiftID = 0;
			m_SendPID = 0;			
			m_vecToPID = new Vector.<int>();
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_Flag = msgdata.ReadUnsignedByte();
			if( m_Flag == 0 ){
				m_GiftID = msgdata.ReadShort();
				m_SendPID = msgdata.ReadInt();
				var m_nCount:int = msgdata.ReadUnsignedByte();
				for(var i:int=0;i<m_nCount;++i){
					m_vecToPID.push(msgdata.ReadInt());
				}		
			}			
		}
	}
}