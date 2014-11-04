package Logic
{
	public class Logic_XieYiID
	{
		public static const LogicXYIDStart:int                         = 0;
		//public static const GameXYID_Ready:int	  					 = LogicXYIDStart+1;
		public static const GameXYID_GameStart:int                     = LogicXYIDStart+2;
		public static const GameXYID_GameState:int                     = LogicXYIDStart+3;
		public static const GameXYID_BankerInfo:int                    = LogicXYIDStart+4;
		public static const GameXYID_StartInfo:int                     = LogicXYIDStart+5;
		public static const GameXYID_HandPai:int                       = LogicXYIDStart+6;
		//public static const GameXYID_TableRule:int                     = LogicXYIDStart+7;
		
		public static const GameXYID_GamePlayerInfo:int                = LogicXYIDStart+10; //和当前局游戏紧密相关
		public static const GameXYID_TablePai:int                      = LogicXYIDStart+11;
		public static const GameXYID_SitPlayerInfo:int                 = LogicXYIDStart+12; //玩家属性和游戏数据关系不大
		public static const GameXYID_WashOutPlayerInfo:int             = LogicXYIDStart+13;
		
		public static const GameXYID_ReqAddMoney:int                   = LogicXYIDStart+14;
		public static const GameXYID_RespAddMoney:int                  = LogicXYIDStart+15;
		public static const GameXYID_TableMoney:int                    = LogicXYIDStart+16;
		public static const GameXYID_GameMoney:int                     = LogicXYIDStart+17;
		public static const GameXYID_AddMoneyInfo:int                  = LogicXYIDStart+18;
		
		public static const GameXYID_ReqAddChip:int                    = LogicXYIDStart+21;
		//public static const GameXYID_RespAddChip:int                   = LogicXYIDStart+22;
		public static const GameXYID_AddChipInfo:int                   = LogicXYIDStart+23;
		public static const GameXYID_PlayerTurn:int                    = LogicXYIDStart+24; //轮到谁了
		public static const GameXYID_PlayerPower:int                   = LogicXYIDStart+25; //权限是什么
		
		public static const GameXYID_ReqShowPai:int                    = LogicXYIDStart+27;
		public static const GameXYID_ShowPai:int                       = LogicXYIDStart+28;
		
		public static const GameXYID_MoneyPool:int                     = LogicXYIDStart+30;
		public static const GameXYID_Result:int                        = LogicXYIDStart+31;
		public static const GameXYID_ReLink:int                        = LogicXYIDStart+32;
		
		//比赛部分
		public static const GameXYID_MatchBlind:int                    = LogicXYIDStart+41;
		public static const GameXYID_MatchResult:int                   = LogicXYIDStart+42;
		//public static const GameXYID_MatchWaitTable:int                = LogicXYIDStart+43;           //等待配桌
		//public static const GameXYID_PlayerRank:int                    = LogicXYIDStart+44;
		
		public static const GameXYID_Flag:int                          = LogicXYIDStart+51;
		
		public static const GameXYID_TableChat:int                     = LogicXYIDStart+101;
		public static const GameXYID_TableQuickChat:int                = LogicXYIDStart+103;		
		
		public static const GameXYID_ReqShowFace:int                   = LogicXYIDStart+111;
		public static const GameXYID_RespShowFace:int                  = LogicXYIDStart+112;
		
		public static const GameXYID_SendGift:int                      = LogicXYIDStart+131;
		public static const GameXYID_RespSendGift:int                  = LogicXYIDStart+132;
		//public static const GameXYID_ReqChangGift:int                  = LogicXYIDStart+133;
		//public static const GameXYID_RespChangGift:int                 = LogicXYIDStart+134;
		
		public static const GameXYID_PromoteTime:int                   = LogicXYIDStart+141;
		
		public static const GameXYID_JoinJuBaoPengInfo:int             = LogicXYIDStart+163;
		
		public function Logic_XieYiID()
		{
			
		}
	}
}