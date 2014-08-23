package Data
{
	//主要用于描述游戏桌的各项数据，和游戏有关的信息均放在这里面
	
	import L2C.L2C_TableInfo;
	
	public class Data_GameTable
	{
		public var m_RoomID:int;
		public var m_TableID:int;
		
		//桌子规则相关的数据
		public var m_TableType:int;                               		 //桌子类型，比赛，普通等
		public var m_Limite:int;                                        //是否为有限桌
		public var m_MaxSitPlayer:int;
		
		public var m_nBigBlind:int;                                     //本桌大盲注
		public var m_nSmallBlind:int;                                   //本桌小盲注
		public var m_nMaxTakeIn:Number;                                 //最大带入量
		public var m_nMinTakeIn:Number;                                 //最小带入量
		public var m_nPotMoney:int;                                     //有底桌开始的下注量
		public var m_nServiceMoney:int;                                 //每局的服务费，通常为大盲注的十分之一
		
		public var m_GiftBase:int;
		public var m_FaceBase:int;
		
		//游戏相关的数据
		public var m_GameState:int;                               		 //游戏状态
		public var m_StartPlayer:int;                                   //游戏开始的时候有几个人参加本局
		
		public var m_BankerSitID:int;                                   //庄家坐号
		public var m_BigBlindSitID:int;                                 //大盲注坐号
		public var m_SmallBlindSitID:int;                               //小盲注坐号
		
		public var m_CurPlayerSitID:int;                                //当前玩家坐号
		
		public var m_MaxChipOnTable:Number;                             //当前下的最大注
		public var m_MinAddChip:Number;                                 //当前最小加注量
		
		public var m_TablePai:Vector.<int>;
		public var m_MoneyPool:Vector.<Number>;
		public var m_MoneyPoolCount:int;
		
		public function Data_GameTable()
		{
			m_RoomID = 0;
			m_TableID = 0;
			
			m_TableType = 0;
			m_Limite = 0;
			m_MaxSitPlayer = 0;
			
			m_nBigBlind = 0;
			m_nSmallBlind = 0;
			m_nMaxTakeIn = 0;
			m_nMinTakeIn = 0;
			m_nPotMoney = 0;
			m_nServiceMoney = 0;
			
			m_GiftBase = 0;
			m_FaceBase = 0;
			
			m_GameState = 0;
			m_StartPlayer = 0;
			
			m_BankerSitID = 0;
			m_BigBlindSitID = 0;
			m_SmallBlindSitID = 0;
			
			m_CurPlayerSitID = 0;
			
			m_MaxChipOnTable = 0;
			m_MinAddChip = 0;
			
			m_MoneyPoolCount = 0;
			m_TablePai = new Vector.<int>(5);
			m_MoneyPool = new Vector.<Number>(9);
		}
		public function Init():void
		{
			m_MoneyPoolCount = 0;
			var i:int = 0;
			for(i=0;i<5;i++)m_TablePai[i] = 0;
			for(i=0;i<9;i++)m_MoneyPool[i] = 0;
		}
		public function InitEveryGame():void
		{
			m_MoneyPoolCount = 0;
			var i:int = 0;
			for(i=0;i<5;i++)m_TablePai[i] = 0;
			for(i=0;i<9;i++)m_MoneyPool[i] = 0;
		}
		
		public function IsGamePlaying():Boolean
		{
			return m_GameState>=DeZhouDef.GAME_ST_HAND && m_GameState<=DeZhouDef.GAME_ST_RIVER;
		}
		
		public function SetData(dataTI:L2C_TableInfo):void
		{
			m_RoomID          = dataTI.m_RoomID;
			m_TableID         = dataTI.m_TableID;
			
			m_TableType       = dataTI.m_TableType;
			m_Limite          = dataTI.m_Limite;
			m_MaxSitPlayer    = dataTI.m_MaxSitPlayer;
			
			m_nBigBlind       = dataTI.m_nBigBlind;
			m_nSmallBlind     = dataTI.m_nSmallBlind;
			m_nMaxTakeIn      = dataTI.m_nMaxTakeIn * Number(dataTI.m_nBigBlind);
			m_nMinTakeIn      = dataTI.m_nMinTakeIn * Number(dataTI.m_nBigBlind);
			m_nPotMoney       = dataTI.m_nPotMoney;
			m_nServiceMoney   = dataTI.m_nServiceMoney;
			
			m_GiftBase        = dataTI.m_GiftBase;
			m_FaceBase        = dataTI.m_FaceBase;
		}
	}
}