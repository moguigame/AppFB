package
{
	public class DeZhouDef
	{
		public static const MaxPlayerOnTable:int          = 9;     //一桌最大的玩家数
		
		//房间标签分类
		public static const Place_ChuJi:int               = 1;     //初级
		public static const Place_ZhongJi:int             = 11;    //中级
		public static const Place_GaoJi:int               = 21;    //高级
		
		public static const Place_AutoRoom:int            = 30;    //初中高级分隔线
		
		public static const Place_KuaiSu:int              = 31;    //快速场
		public static const Place_Private:int             = 41;    //自建房间场
		
		public static const Place_TopCommon:int           = 100;   //普通场和比赛场的分类
		
		public static const Place_TaoJingMatch:int        = 101;   //注意和数据以及游戏服务器的对应关系
		public static const Place_GuanJunMatch:int        = 111;
		public static const Place_JingBiaoMatch:int       = 121;
		
		public static const ROOM_TYPE_Common:int          = 1;     //桌间模式是普通的还是排队性质的		
		public static const ROOM_TYPE_TableMatch:int      = 2;     //单桌比赛,
		public static const ROOM_TYPE_RoomMatch:int       = 3;     //整个房间的比赛，主要是组织大型比赛		
		
		public static const TABLE_TYPE_COMMON:int         = 1;     //桌间模式是普通的还是排队性质的		
		public static const TABLE_TYPE_TableMatch:int     = 2;     //单桌比赛,
		public static const TABLE_TYPE_RoomMatch:int      = 3;     //整个房间的比赛，主要是组织大型比赛
		
		public static const ClientState_None:int          = 0;     //客户端的状态初始化，初始化完成，刚开始，正在游戏等
		public static const ClientState_Init:int          = 1;
		public static const ClientState_Gamming:int       = 2;
		
		public static const MatchTable_ST_None:int        = 0;     //单桌比赛的状态
		public static const MatchTable_ST_WaitSign:int    = 1;
		public static const MatchTable_ST_Matching:int    = 2;
		public static const MatchTable_ST_MatchOver:int   = 3;
		
		public static const MatchRoom_ST_None:int         = 0;     //房间比赛的状态
		public static const MatchRoom_ST_WaitSign:int     = 1;
		public static const MatchRoom_ST_HaveSign:int     = 2;
		public static const MatchRoom_ST_WaitEnter:int    = 3;
		public static const MatchRoom_ST_MatchStart:int   = 4;
		public static const MatchRoom_ST_MatchOver:int    = 5;
		
		public static const TabFlag_Common:int            = 1;     //指TAB控件对普通和比赛的区分
		public static const TabFlag_Match:int             = 2;

		public static const PLAYER_ST_NONE:int            = 0;     //表示玩家刚创建或者无效
		public static const PLAYER_ST_LOBBY:int           = 1;     //表示玩家在大厅里
		public static const PLAYER_ST_ROOM:int            = 2;     //在房间里站着,
		public static const PLAYER_ST_SEEING:int          = 3;     //旁观
		public static const PLAYER_ST_WAIT:int            = 4;     //在桌上等待其它玩家的加入或者待开始
		public static const PLAYER_ST_PALYING:int         = 5;     //正在游戏中，此时桌上玩害大于或者2个		
	
		public static const GAME_ST_NONE:int              = 0;     //人数为0时的状态
		public static const GAME_ST_WAIT:int              = 1;     //人数不足或两局中间的等待
		public static const GAME_ST_HAND:int              = 2;     //发过HAND牌后的状态，余下依次类推
		public static const GAME_ST_FLOP:int              = 3;
		public static const GAME_ST_TURN:int              = 4;
		public static const GAME_ST_RIVER:int             = 5;
		public static const GAME_ST_DIVIDEMONEY:int       = 6;     //分派筹码的过程
		public static const GAME_ST_END:int               = 7;
		
		//玩家在游戏逻辑中的状态，和桌子上有区别
		public static const GAME_PLAYER_ST_NULL:int       = 0;
		public static const GAME_PLAYER_ST_WAITING:int    = 1;     //等待游戏，钱不足没有加入
		public static const GAME_PLAYER_ST_GIVEUP:int     = 2;     //游戏中弃牌
		public static const GAME_PLAYER_ST_ALLIN:int      = 3;     //游戏中ALL IN
		public static const GAME_PLAYER_ST_PLAYING:int    = 4;     //正在游戏中
		public static const GAME_PLAYER_ST_WASHOUT:int    = 5;     //比赛被淘汰出去
		
		public static const ACTION_NONE:int               = 0;
		public static const ACTION_Chip:int               = 1;     //下注，指一轮的第一个玩家
		public static const ACTION_Follow:int             = 2;     //跟注
		public static const ACTION_AddChip:int            = 4;     //加注
		public static const ACTION_KanPai:int             = 8;     //看牌
		public static const ACTION_GiveUp:int             = 16;    //放弃
		public static const ACTION_AllIn:int              = 32;    //全下，也可能全下后仍然不足基本额
		public static const ACTION_POT:int                = 64;    //底注
		public static const ACTION_SMALLBLIND:int         = 128;   //小盲注
		public static const ACTION_BIGBLIND:int           = 256;   //大盲注
		public static const ACTION_NewBlind:int           = 512;
		public static const ACTION_WaitChip:int           = 8912;
		
		public static const BTN_OP_GiveUp:int             = 1;
		public static const BTN_OP_KanPai:int             = 2;
		public static const BTN_OP_Chip:int               = 3;     //无论是下注，跟注，加注 ALLIN最终都是CHIP的数值
		
		public static const BTN_OP_Start:int              = 100;   //按下快速开始按钮
		
		
		public static const ChatFlag_Sys:int              = 1;
		public static const ChatFlag_Player:int           = 2;
		public static const ChatFlag_HeGuan:int           = 3;
		
		public static const CurGift:int                   = 1;
		public static const PassGift:int                  = 2;
		
		public static const  CLOSE:int                    = 0;     //关闭窗口
		public static const  OPEN:int                     = 1;     //打开窗口
		
		public static const  MsgFlag_Success:int          = 0;
		
		public static const  PriceFlag_Chang:int          = 1;
		public static const  PriceFlag_Fixed:int          = 2;
		public static const  PriceFlag_MoGui:int          = 3;	
		
		public function DeZhouDef()
		{
		}
	}
}