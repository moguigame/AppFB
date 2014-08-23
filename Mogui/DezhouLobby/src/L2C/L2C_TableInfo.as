package L2C
{
	import Data.Data_TableInfo;
	
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class L2C_TableInfo extends Public_XYBase
	{
		public static const ID:int     = LC_XieYiID.XYID_L2C_TableInfo;
		
		public var m_RoomID:int;
		public var m_TableID:int;
		public var m_TableName:String;
		
		//桌子规则相关的数据
		public var m_TableType:int;                               		 //桌子类型，比赛，普通等
		public var m_Limite:int;                                        //是否为有限桌
		public var m_MaxSitPlayer:int;
		
		public var m_nBigBlind:int;                                     //本桌大盲注
		public var m_nSmallBlind:int;                                   //本桌小盲注
		public var m_nMaxTakeIn:int;                                    //最大带入量
		public var m_nMinTakeIn:int;                                    //最小带入量
		public var m_nPotMoney:int;                                     //有底桌开始的下注量
		public var m_nServiceMoney:int;                                 //每局的服务费，通常为大盲注的十分之一
		public var m_nChipTime:int;                                     //下注时间秒数
		
		public var m_GiftBase:int;
		public var m_FaceBase:int;
		
		public var m_Ticket:int;
		
		public function L2C_TableInfo()
		{
			super();
			
			m_RoomID = 0;
			m_TableID = 0;
			
			m_TableName = "";
			
			m_TableType = 0;
			m_Limite = 0;
			m_MaxSitPlayer = 0;
			
			m_nBigBlind = 0;
			m_nSmallBlind = 0;
			m_nMaxTakeIn = 0;
			m_nMinTakeIn = 0;
			m_nPotMoney = 0;
			m_nServiceMoney = 0;
			m_nChipTime = 0;
			
			m_GiftBase = 0;
			m_FaceBase = 0;
			
			m_Ticket = 0;
		}
		
		public function GetData(dataTI:Data_TableInfo):void
		{
			m_RoomID = dataTI.m_RoomID;
			m_TableID = dataTI.m_TableID;
			m_TableName = dataTI.m_TableName;
			
			m_TableType = dataTI.m_TableType;
			m_Limite = dataTI.m_Limite;
			m_MaxSitPlayer = dataTI.m_MaxSitPlayerNumber;
			
			m_nBigBlind = dataTI.m_BigBlind;
			m_nSmallBlind = dataTI.m_SmallBlind;
			m_nMaxTakeIn = dataTI.m_MaxTake;
			m_nMinTakeIn = dataTI.m_MinTake;
			m_nPotMoney = dataTI.m_Pot;
			m_nServiceMoney = dataTI.m_Service;
			m_nChipTime = dataTI.m_ChipTime;
			
			m_GiftBase = dataTI.m_GiftBase;
			m_FaceBase = dataTI.m_FaceBase;
			
			m_Ticket = dataTI.m_Ticket;
		}
		
		override public function Write(msgdata:MsgData):void
		{
			msgdata.m_msgID = ID;
			
			msgdata.WriteInt(m_RoomID);
			msgdata.WriteInt(m_TableID);
			msgdata.WriteString(m_TableName);
			
			msgdata.WriteInt(m_TableType);
			msgdata.WriteInt(m_Limite);
			msgdata.WriteInt(m_MaxSitPlayer);
			
			msgdata.WriteInt(m_nBigBlind);
			msgdata.WriteInt(m_nSmallBlind);
			msgdata.WriteInt(m_nMaxTakeIn);
			msgdata.WriteInt(m_nMinTakeIn);
			msgdata.WriteInt(m_nPotMoney);
			msgdata.WriteInt(m_nServiceMoney);
			msgdata.WriteInt(m_nChipTime);
			
			msgdata.WriteInt(m_GiftBase);
			msgdata.WriteInt(m_FaceBase);
			
			msgdata.WriteInt(m_Ticket);
		}
		
		override public function Read(msgdata:MsgData):void
		{
			m_RoomID         = msgdata.ReadInt();
			m_TableID        = msgdata.ReadInt();
			m_TableName      = msgdata.ReadString();
			
			m_TableType      = msgdata.ReadInt();
			m_Limite         = msgdata.ReadInt();
			m_MaxSitPlayer   = msgdata.ReadInt();
			
			m_nBigBlind      = msgdata.ReadInt();
			m_nSmallBlind    = msgdata.ReadInt();
			m_nMaxTakeIn     = msgdata.ReadInt();
			m_nMinTakeIn     = msgdata.ReadInt();
			m_nPotMoney      = msgdata.ReadInt();
			m_nServiceMoney  = msgdata.ReadInt();
			m_nChipTime      = msgdata.ReadInt();			
			
			m_GiftBase       = msgdata.ReadInt();
			m_FaceBase       = msgdata.ReadInt();
			
			m_Ticket         = msgdata.ReadInt();
		}
	}
}