package Data
{
	//主要用来描述游戏中坐下的玩家的数据，包括个人信息以及牌，注码，状态等
	
	import Logic.Logic_SitPlayerInfo;
	import Logic.Logic_msgGamePlayerInfo;

	public class Data_GamePlayer
	{
		public var m_AID:int;
		public var m_PID:int;
		
		public var m_NickName:String;
		public var m_HeadPicURL:String;
		public var m_HomePageURL:String;
		
		public var m_GiftID:int;
		
		public var m_GameLevel:int;
		public var m_VipLevel:int;
		public var m_JuBaoPeng:int;          //是否参加聚宝盆
		
		public var m_SitID:int;
		public var m_PlayerGameState:int;    //指玩家在桌面的游戏状态
		public var m_Action:int;
		public var m_arrayHandPai:Vector.<int>;
		
		public var m_TableMoney:Number;      //桌面上的游戏币数量
		public var m_ChipMoney:Number;       //当前注的大小	
		
		public var m_PaiType:int;
		public var m_WinPaiType:Vector.<int>;
		public var m_bWin:int;
		public var m_FaPaiCount:int;         //给玩家发牌的张数2表示已发完
		
		public var m_MatchRank:int;          //比赛的淘汰的名次
		
		public function Data_GamePlayer()
		{
			m_arrayHandPai = new Vector.<int>(2);
			m_WinPaiType = new Vector.<int>(5);
			
			Init();
		}
		public function Init():void
		{
			m_AID = 0;
			m_PID = 0;
			
			m_NickName = "";
			m_HeadPicURL = "";
			m_HomePageURL = "";
			
			m_GiftID = 0;			
			m_GameLevel = 0;
			m_VipLevel = 0;
			m_JuBaoPeng = 0;			
			
			m_PlayerGameState = 0;
			m_Action = 0;			
			m_TableMoney = 0;
			m_ChipMoney = 0;
			m_PaiType = 0;
			m_bWin = 0;
			
			m_FaPaiCount = 0;
			
			m_arrayHandPai[0] = m_arrayHandPai[1] = 0;
			for(var i:int=0;i<5;i++)
			{
				m_WinPaiType[i] = 0;
			}
			
			m_MatchRank = 0;
		}
		
		public function InitPlayerData():void
		{
			m_AID = 0;
			m_PID = 0;
			
			m_NickName = "";
			m_HeadPicURL = "";
			m_HomePageURL = "";
			
			m_GiftID = 0;
			m_GameLevel = 0;
			m_VipLevel = 0;
			m_JuBaoPeng = 0;
			
			m_PlayerGameState = DeZhouDef.GAME_PLAYER_ST_NULL;
			
			m_MatchRank = 0;
		}
		
		public function InitGameData():void
		{
			m_Action = DeZhouDef.ACTION_NONE;
			m_PlayerGameState = DeZhouDef.GAME_PLAYER_ST_WAITING;
			
			m_PaiType = 0;
			m_bWin = 0;
			m_FaPaiCount = 0;
			
			m_ChipMoney = 0;
			
			m_arrayHandPai[0] = m_arrayHandPai[1] = 0;
			for(var i:int=0;i<5;i++)
			{
				m_WinPaiType[i] = 0;
			}
		}
		
		public function IsExit():Boolean //没有玩家或者玩家离开
		{
			return m_PlayerGameState == DeZhouDef.GAME_PLAYER_ST_NULL;
		}  
		public function IsWashOut():Boolean //被淘汰玩家
		{
			return m_PlayerGameState == DeZhouDef.GAME_PLAYER_ST_WASHOUT;  
		}  
		public function IsWait():Boolean	 //等待中的玩家
		{ 
			return m_PlayerGameState == DeZhouDef.GAME_PLAYER_ST_WAITING;
		}
		public function IsPlaying():Boolean   //正在游戏并且有钱继续
		{ 
			return m_PlayerGameState == DeZhouDef.GAME_PLAYER_ST_PLAYING;
		}
		public function IsGiveUp():Boolean
		{ 
			return m_PlayerGameState == DeZhouDef.GAME_PLAYER_ST_GIVEUP;
		}
		public function IsAllIn():Boolean   //ALLIN的玩家
		{ 
			return m_PlayerGameState == DeZhouDef.GAME_PLAYER_ST_ALLIN;
		}
		public function IsInGame():Boolean   //游戏玩家并且没有弃牌的，但包括ALLIN的玩家
		{ 
			return IsPlaying() || IsAllIn();
		}
		public function IsAttendGame():Boolean   //是否参加过本轮游戏
		{ 
			return IsGiveUp() || IsAllIn() || IsPlaying();
		}
		public function IsHavePlayer():Boolean   //有玩家
		{
			return IsWait() || IsAttendGame();
		}
		
		public function IsEmpty():Boolean
		{
			return m_PID == 0;
		}
		public function IsSitPlayer():Boolean
		{
			return m_PID != 0;
		}
		public function HavePai():Boolean
		{
			return m_arrayHandPai[0]>0&&m_arrayHandPai[0]<=55&&m_arrayHandPai[1]>0&&m_arrayHandPai[1]<=55;
		}
		public function SetBaseInfo(dataPlayerInfo:Data_PlayerInfo):void
		{
			m_AID           = dataPlayerInfo.m_AID;
			m_PID           = dataPlayerInfo.m_PID;
			m_NickName      = dataPlayerInfo.m_NickName;
			m_HeadPicURL    = dataPlayerInfo.m_HeadPicURL;
			m_GameLevel     = dataPlayerInfo.m_GameLevel;
		}
		public function SetGamePlayerInfo(dataGamePlayer:Logic_msgGamePlayerInfo):void
		{
			if( m_SitID == dataGamePlayer.m_SitID)
			{
				m_PlayerGameState      = dataGamePlayer.m_GameState;
				m_Action               = dataGamePlayer.m_Action;
				m_arrayHandPai[0]      = dataGamePlayer.m_arrayHandPai[0];
				m_arrayHandPai[1]      = dataGamePlayer.m_arrayHandPai[1];
				m_TableMoney           = dataGamePlayer.m_nTableMoney;
				m_ChipMoney            = dataGamePlayer.m_nChip;
			}
			else
			{
				GlobleFunc.LogError("Data_GamePlayer SetGamePlayerInfo",m_SitID,dataGamePlayer.m_SitID);
			}
		}
		public function SetSitPlayerInfo(dataSitPlayer:Logic_SitPlayerInfo):void
		{
			if( m_PID == dataSitPlayer.m_PID && m_SitID == dataSitPlayer.m_SitID )
			{
				m_HomePageURL   = dataSitPlayer.m_HomePageURL;				
				
				m_GiftID        = dataSitPlayer.m_GiftID;				
				m_GameLevel     = dataSitPlayer.m_GameLevel;
				m_VipLevel      = dataSitPlayer.m_VipLevel;
			}
			else
			{
				GlobleFunc.LogError("Data_GamePlayer SetSitPlayerInfo",m_PID,dataSitPlayer.m_PID);
			}
		}
	}
}