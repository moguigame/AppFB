package Game
{	
	import PublicXY.Public_XYDef;
	
	public class LobbyGameXYID
	{
		public static const LobbyXY_LobbyPlayerConnect:int        = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 1;
		public static const MoGuiXYID_RespPlayerConnect:int       = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 2;
		public static const MoGui_GAME_FLAG:int                   = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 3;//大厅里的消息提示
		public static const MoGuiXYID_GameRule:int                = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 4;//服务器有关游戏的规则  
		
		public static const MoGuiXYID_PlayerData:int              = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 5;//玩家的完整数据
		public static const MoGuiXYID_PlayerDataEx:int            = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 6;//玩家的扩展数据
		public static const MoGuiXYID_PlayerMatchData:int         = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 7;
		
		public static const MoGui_REQJOINROOM:int                 = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 11;//加入房间离开房间等
		public static const MoGui_RESPJOINROOM:int                = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 12;
		public static const MoGui_JOINROOM:int                    = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 13;
		public static const MoGui_REQLEAVEROOM:int                = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 14;
		public static const MoGui_RESPLEAVEROOM:int               = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 15;
		public static const MoGui_LEAVEROOM:int                   = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 16;
		//public static const MoGui_REQROOMINFO:int                 = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 17;
		//public static const MoGui_RESPROOMINFO:int                = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 18;
		
		public static const MoGui_ROOMINFO:int                    = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 19;
		public static const MoGui_ROOMINIFOLIST:int               = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 20;
		
		public static const MoGui_REQJOINTABLE:int                = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 21;//请求加入桌子
		public static const MoGui_RESPJOINTABLE:int               = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 22;
		public static const MoGui_JOINTABLE:int                   = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 23;
		public static const MoGui_REQLEAVETABLE:int				= Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 24;//离开桌子
		public static const MoGui_RESPLEAVETABLE:int				= Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 25;
		public static const MoGui_LEAVETABLE:int					= Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 26;
		public static const MoGui_REQROOMTABLEINFO:int            = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 27;
		public static const MoGui_RESPROOMTABLEINFO:int           = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 28;
		public static const MoGui_TABLEINFO:int                   = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 29;
		public static const MoGui_TABLEINFOLIST:int               = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 30;
		
		public static const MoGui_REQPLAYERACT:int                = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 31;//玩家动作，坐下，站起等
		public static const MoGui_RESPPLAYERACT:int              	= Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 32;
		public static const MoGui_PLAYERACT:int                 	= Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 33;//坐下站起的专们协议通知
		
		public static const MoGuiXYID_ShowTable:int               = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 36;//指示那些桌子可以显示
		public static const MoGuiXYID_ShowTableList:int           = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 37;
		
		public static const MoGui_PLAYERBASEINFO:int              = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 41;
		public static const MoGui_PLAYERGAMEINFO:int              = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 42;
		public static const MoGui_PLAYERSTATEINFO:int             = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 43;
		
		public static const GameLobbyXYID_PlayerStateInfoList:int = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 47;
		
		public static const GameLobbyXYID_PlayerGameMoney:int     = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 51;
		public static const GameLobbyXYID_PlayerMoGuiMoney:int    = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 52;
		
		
		public static const GameLobbyXYID_JuBaoPengMoney:int      = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 56;
		
		public static const GameLobbyXYID_GameLevelAward:int      = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 58;
		
		public static const GameLobbyXYID_ReqTailInfo:int         = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 60;
		public static const GameLobbyXYID_ReqPlayerGiftInfo:int   = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 61;
		public static const GameLobbyXYID_PlayerGiftInfo:int      = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 62;
		public static const GameLobbyXYID_PlayerGiftInfoList:int  = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 63;
		
		public static const GameLobbyXYID_PlayerHonorInfoList:int = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 64;
		public static const GameLobbyXYID_PlayerTailInfo:int      = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 65;
		
		
		public static const GameLobbyXYID_ReqSendGift:int         = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 66;
		public static const GameLobbyXYID_RespSendGift:int        = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 67;
		public static const GameLobbyXYID_RecvGift:int            = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 68;
		public static const GameLobbyXYID_ReqSoldGift:int         = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 69;
		public static const GameLobbyXYID_RespSoldGift:int        = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 70;
		public static const GameLobbyXYID_ReqChangGift:int        = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 71;
		public static const GameLobbyXYID_RespChangGift:int       = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 72;
		
		public static const GameLobbyXYID_ReqChangeBank:int       = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 76;
		public static const GameLobbyXYID_RespChangeBank:int      = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 77;
		
		public static const GameLobbyXYID_UserAwardList:int       = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 81;
		public static const GameLobbyXYID_UserHuiYuan:int         = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 82;
		public static const GameLobbyXYID_UserMoguiExchange:int   = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 83;
		
		public static const GameLobbyXYID_MaxPai:int              = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 85;
		public static const GameLobbyXYID_MaxWin:int              = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 86;
		public static const GameLobbyXYID_MaxMoney:int            = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 87;
		
		public static const MoGui_TABLEPLAYERCOUNTLIST:int        = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 133;
		
		
		public static const GameLobbyXYID_MatchTableState:int     = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 254;
		public static const GameLobbyXYID_MatchRoomState:int      = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 255;
		
		public static const GameLobbyXYID_ReqCreateTable:int      = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 301;
		public static const GameLobbyXYID_RespCreateTable:int     = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 302;
		public static const GameLobbyXYID_CreateTablePID:int      = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 303;
		
		public static const MoGui_GAME_SERVERTOCLIENT:int         = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 501;
		public static const MoGui_GAME_CLIENTTOSERVER:int         = Public_XYDef.MOGUI_FIRST_CLIENT_GAMELOBBY + 502;
		
		public function LobbyGameXYID()
		{
		}
	}
}