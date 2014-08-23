package Game
{
	import MoGui.net.MsgData;
	public class msgPlayerGiftInfo
	{
		public var m_GiftIdx:int;
		public var m_GiftID:int;
		public var m_Price:int;
		public var m_ActionTime:int;
		public var m_NickName:String;
		
		public function msgPlayerGiftInfo()
		{
			m_GiftIdx = 0;
			m_GiftID = 0;
			m_Price = 0;
			m_ActionTime = 0;
			m_NickName = "";
		}
		
		public function Read(msgdata:MsgData):void
		{
			m_GiftIdx      = msgdata.ReadInt();
			m_GiftID       = msgdata.ReadShort();
			m_Price        = msgdata.ReadInt();
			m_ActionTime   = msgdata.ReadInt();			
			m_NickName     = msgdata.ReadString();
		}
		
		public function Copy(srcData:msgPlayerGiftInfo):void
		{
			m_GiftIdx      = srcData.m_GiftIdx;
			m_GiftID       = srcData.m_GiftID;
			m_Price        = srcData.m_Price;
			m_ActionTime   = srcData.m_ActionTime;
			m_NickName     = srcData.m_NickName;
		}
	}
}