package Data
{
	import Game.Game_RoomInfo;
	
	import MoGui.utils.CFunction;

	public class Data_RoomInfo
	{
		public var m_RoomID:int;
		public var m_RoomName:String;
		public var m_RoomRule:String;
		
		public var m_MaxPlayerInRoom:int;
		public var m_CurPlayerInRoom:int;
		
		public var m_Place:int;                   //指房间摆放的位置
		public var m_RoomType:int;                //排队模式还是自已坐的模式
		public var m_NeedPassword:int;            //是否需要密码访问
		
		public var m_Private:int;
		
		//----------扩展内容-----------------------------
		public var m_MatchId:int;                 //比赛ID
		public var m_StartTime:int;               //比赛开始时间70年以来的秒数
		public var m_Ticket:int;                  //比赛的门票
		
		public var m_MaxMoneyInRoom:Number;
		public var m_MinMoneyInRoom:Number;
		
		public function Data_RoomInfo()
		{
			m_RoomID = 0;
			m_RoomName = "";
			m_RoomRule = "";
			
			m_MaxPlayerInRoom = 0;
			m_CurPlayerInRoom = 0;
			
			m_Place = 0;
			m_RoomType = 0;
			m_NeedPassword = 0;	
			
			m_Private = 0;
			
			m_MatchId = 0;
			m_StartTime = 0;
			m_Ticket = 0;
			
			m_MaxMoneyInRoom = 0;
			m_MinMoneyInRoom = 0;
		}
		
		public function GetDataFromMsg(msgdata:Game_RoomInfo):void
		{
			m_RoomID = msgdata.m_RoomID;
			m_RoomName = msgdata.m_RoomName;
			m_RoomRule = msgdata.m_RoomRule;
			
			m_MaxPlayerInRoom = msgdata.m_MaxPlayerInRoom;
			m_CurPlayerInRoom = msgdata.m_CurPlayerInRoom;
			
			m_Place = msgdata.m_Place;
			m_RoomType = msgdata.m_RoomType;
			m_NeedPassword = msgdata.m_NeedPassword;
			
			var TempStr:String = "";
			
			TempStr = CFunction.GetStringValue(m_RoomRule,"private");
			if( TempStr != "" ) m_Private = int(TempStr);
			else m_Private = 0;			
			
			TempStr = CFunction.GetStringValue(m_RoomRule,"matchid");
			if( TempStr != "" ) m_MatchId = int(TempStr);
			else m_MatchId = 0;
			
			TempStr = CFunction.GetStringValue(m_RoomRule,"starttime");
			if( TempStr != "" ) m_StartTime = int(TempStr);
			else m_StartTime = 0;
			
			TempStr = CFunction.GetStringValue(m_RoomRule,"ticket");
			if( TempStr != "" ) m_Ticket = int(TempStr);
			else m_Ticket = 0;
			
			TempStr = CFunction.GetStringValue(m_RoomRule,"maxplaymoney");
			if( TempStr != "" ) m_MaxMoneyInRoom = Number(TempStr);
			else m_MaxMoneyInRoom = 0;
			
			TempStr = CFunction.GetStringValue(m_RoomRule,"minplaymoney");
			if( TempStr != "" ) m_MinMoneyInRoom = Number(TempStr);
			else m_MinMoneyInRoom = 0;
		}
	}
}