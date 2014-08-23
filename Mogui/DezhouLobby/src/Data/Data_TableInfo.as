package Data
{
	import Game.Game_TableInfo;
	
	import MoGui.utils.CFunction;

	public class Data_TableInfo
	{
		public var m_RoomID:int;
		public var m_TableID:int;
		public var m_TableType:int;
		
		public var m_TableName:String;
		public var m_TableRule:String;
		
		public var m_MaxSitPlayerNumber:int;        //最大能一起玩的玩家
		public var m_CurSitPlayerNumber:int;        //当前坐下的玩家
		public var m_CurStandPlayerNumber:int;      //当前旁观的玩家
		
		public var m_SmallBlind:int;
		public var m_BigBlind:int;
		public var m_Service:int;
		public var m_MinTake:int;
		public var m_MaxTake:int;
		public var m_Pot:int;
		public var m_Limite:int;
		public var m_FaceBase:int;
		public var m_GiftBase:int;
		public var m_ChipTime:int;
		public var m_NeedPW:int;
		public var m_strMark:String;
		
		public var m_CreatePID:int;
		public var m_RankValue:int;
		
		public var m_Ticket:int;
		public var m_MatchTakeMoney:int;
		public var m_MatchState:int;
		public var m_HongBao:int;
		public var m_MatchRank:int;
		
		public var m_ShowFlag:int;
		
		
		public function Data_TableInfo()
		{
			m_RoomID = 0;
			m_TableID = 0;
			m_TableType = 0;
			
			m_TableName = "";
			m_TableRule = "";
			
			m_MaxSitPlayerNumber = 0;
			m_CurSitPlayerNumber = 0;
			m_CurStandPlayerNumber = 0;
			
			m_SmallBlind = 0;
			m_BigBlind = 0;
			m_Service = 0;
			m_MinTake = 0;
			m_MaxTake = 0;
			
			m_Pot = 0;
			m_Limite = 0;
			m_FaceBase = 0;
			m_GiftBase = 0;
			m_ChipTime = 0;
			m_NeedPW = 0;
			m_strMark = "";
			
			m_CreatePID = 0;
			
			m_Ticket = 0;
			m_MatchTakeMoney = 0;
			m_MatchState = 0;
			m_HongBao = 0;
			
			m_ShowFlag = 0;
		}
		
		public function InitMatchRank():void
		{
			if( m_MatchState == DeZhouDef.MatchTable_ST_WaitSign )
			{
				m_MatchRank = 90000 + m_TableID;
			}
			else if( m_MatchState == DeZhouDef.MatchTable_ST_Matching )
			{
				m_MatchRank = 80000 + m_TableID;
			}
			else if( m_MatchState == DeZhouDef.MatchTable_ST_MatchOver )
			{
				m_MatchRank = 70000 + m_TableID;
			}
			else
			{
				m_MatchRank = m_TableID;
			}
		}
		
		public function UpdateRank():void
		{
			m_RankValue = 0;
			if( m_CreatePID == GlobleData.s_MyPID )
			{
				m_RankValue = 1000000;
			}
		}
		
		public function Copy(data:Data_TableInfo):void
		{
			m_RoomID = data.m_RoomID;
			m_TableID = data.m_TableID;
			m_TableType = data.m_TableType;
			
			m_TableName = data.m_TableName;
			m_TableRule = data.m_TableRule;
			
			m_MaxSitPlayerNumber = data.m_MaxSitPlayerNumber;
			m_CurSitPlayerNumber = data.m_CurSitPlayerNumber;
			m_CurStandPlayerNumber = data.m_CurStandPlayerNumber;
			
			m_SmallBlind = data.m_SmallBlind;
			m_BigBlind = data.m_BigBlind;
			m_Service = data.m_Service;
			m_MinTake = data.m_MinTake;
			m_MaxTake = data.m_MaxTake;
			
			m_Pot = data.m_Pot;
			m_Limite = data.m_Limite;
			m_FaceBase = data.m_FaceBase;
			m_GiftBase = data.m_GiftBase;
			m_ChipTime = data.m_ChipTime;
			m_NeedPW = data.m_NeedPW;
			m_strMark = data.m_strMark;
			
			m_CreatePID = data.m_CreatePID;
			
			m_Ticket = data.m_Ticket;
			m_MatchTakeMoney = data.m_MatchTakeMoney;
			m_MatchState = data.m_MatchState;
			m_HongBao    = data.m_HongBao;
			
			m_ShowFlag = data.m_ShowFlag;
		}
		
		public function GetDataFromMsg(msgdata:Game_TableInfo):void
		{
			m_RoomID = msgdata.m_RoomID;
			m_TableID = msgdata.m_TableID;
			m_TableType = msgdata.m_TableType;
			
			m_TableName = msgdata.m_TableName;
			m_TableRule = msgdata.m_TableRule;
			
			m_MaxSitPlayerNumber = msgdata.m_MaxSitPlayerNumber;
			m_CurSitPlayerNumber = msgdata.m_CurSitPlayerNumber;
			m_CurStandPlayerNumber = msgdata.m_CurStandPlayerNumber;
			
			var TempStr:String = "";
			
			TempStr = CFunction.GetStringValue(m_TableRule,"smallblind");
			if( TempStr != "" ) m_SmallBlind = int(TempStr);
			else m_SmallBlind = 0;
			
			TempStr = CFunction.GetStringValue(m_TableRule,"bigblind");
			if( TempStr != "" ) m_BigBlind = int(TempStr);
			else m_BigBlind = 0;
			
			TempStr = CFunction.GetStringValue(m_TableRule,"service");
			if( TempStr != "" ) m_Service = int(TempStr);
			else m_Service = 0;
			
			TempStr = CFunction.GetStringValue(m_TableRule,"mintake");
			if( TempStr != "" ) m_MinTake = int(TempStr);
			else m_MinTake = 0;
			
			TempStr = CFunction.GetStringValue(m_TableRule,"maxtake");
			if( TempStr != "" ) m_MaxTake = int(TempStr);
			else m_MaxTake = 0;
			
			TempStr = CFunction.GetStringValue(m_TableRule,"pot");
			if( TempStr != "" ) m_Pot = int(TempStr);
			else m_Pot = 0;

			TempStr = CFunction.GetStringValue(m_TableRule,"limite");
			if( TempStr != "" ) m_Limite = int(TempStr);
			else m_Limite = 0;
			
			TempStr = CFunction.GetStringValue(m_TableRule,"facebase");
			if( TempStr != "" ) m_FaceBase = int(TempStr);
			else m_FaceBase = 0;

			TempStr = CFunction.GetStringValue(m_TableRule,"giftbase");
			if( TempStr != "" ) m_GiftBase = int(TempStr);
			else m_GiftBase = 0;

			TempStr = CFunction.GetStringValue(m_TableRule,"chiptime");
			if( TempStr != "" ) m_ChipTime = int(TempStr);
			else m_ChipTime = 0;
			
			TempStr = CFunction.GetStringValue(m_TableRule,"password");
			if( TempStr != "" ) m_NeedPW = int(TempStr);
			else m_NeedPW = 0;
			
			m_strMark = CFunction.GetStringValue(m_TableRule,"mark");
			
			TempStr = CFunction.GetStringValue(m_TableRule,"ticket");
			if( TempStr != "" ) m_Ticket = int(TempStr);
			else m_Ticket = 0;
			
			TempStr = CFunction.GetStringValue(m_TableRule,"takemoney");
			if( TempStr != "" ) m_MatchTakeMoney = int(TempStr);
			else m_MatchTakeMoney = 0;
			
			TempStr = CFunction.GetStringValue(m_TableRule,"hongbao");
			if( TempStr != "" ) m_HongBao = int(TempStr);
			else m_HongBao = 0;
		}
	}
}