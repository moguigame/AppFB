package
{
	import Data.Data_GiftConfig;
	import Data.Data_PlayerInfo;
	
	import MoGui.net.CLoadResource;
	import MoGui.utils.CFunction;
	import MoGui.utils.Map;

	public class GlobleData
	{
		//存放配置文件
		public static var s_PlayerTailTime:int;
		
		//游戏规则的配置文件
		public static var s_FaceBase:int;
		public static var s_GiftBase:int;
		public static var s_AddMoney:int;
		
		public static var s_CanSend:int;
		public static var S_MinSend:int;
		public static var S_MaxSend:int;
		
		public static var s_OneHourBlind:int;
		public static var s_MinPay:int;
		public static var s_MaxPay:int;
		public static var s_MinLastTime:int;
		public static var s_MaxLastTime:int;
		public static var s_MinAddTime:int;
		public static var s_MaxAddTime:int;
		
		public static var s_MyPID:int;
		
		public static function InitGameRule(strRule:String):void
		{
			var TempStr:String = "";
			var TempArray:Array;
			
			s_GiftBase = 1000;
			TempStr = CFunction.GetStringValue(strRule,"giftbase");
			if( TempStr!="" )s_GiftBase = int(TempStr);
			
			s_FaceBase = 1000;
			TempStr = CFunction.GetStringValue(strRule,"facebase");
			if( TempStr!="" )s_FaceBase = int(TempStr);
			
			s_AddMoney = 100;
			TempStr = CFunction.GetStringValue(strRule,"addmoney");
			if( TempStr!="" )s_AddMoney = int(TempStr);			
			
			s_CanSend = 0;
			S_MinSend = 1;
			S_MaxSend = 1000;
			TempStr = CFunction.GetStringValue(strRule,"sendmoney");
			if( TempStr!="" )
			{
				TempArray = TempStr.split(",");
				if( TempArray.length >= 3 )
				{
					s_CanSend = int(TempArray[0]);
					S_MinSend = int(TempArray[1]);
					S_MaxSend = int(TempArray[2]);
				}
			}
			
			s_OneHourBlind = 25;
			s_MinPay       = 10000;
			s_MaxPay       = 1000000;
			s_MinLastTime  = 4;
			s_MaxLastTime  = 24;
			s_MinAddTime   = 1;
			s_MaxAddTime   = 4;
			TempStr = CFunction.GetStringValue(strRule,"createtable");
			if( TempStr!="" )
			{
				TempArray = TempStr.split(",");
				if( TempArray.length >= 7 )
				{
					s_OneHourBlind = int(TempArray[0]);
					s_MinPay       = int(TempArray[1]);
					s_MaxPay       = int(TempArray[2]);
					s_MinLastTime  = int(TempArray[3]);
					s_MaxLastTime  = int(TempArray[4]);
					s_MinAddTime   = int(TempArray[5]);
					s_MaxAddTime   = int(TempArray[6]);
				}
			}
		}
		
		public  static var S_ArrayPaiType:Array = 
			[
				"",
				"高牌",
				"对子",
				"两对",
				"三条",
				"顺子",
				"同花",
				"葫芦",
				"四条",
				"同花顺",
				"皇家同花顺",
				""
			];
		
		//用于存放
		public static var S_ArrayChip:Array =  
			[
				1000000000,500000000,200000000,
				100000000, 50000000, 20000000,
				10000000,  5000000,  2000000,
				1000000,   500000,   200000,
				100000,    50000,    20000,
				10000,     5000,     2000,
				1000,      500,      200,
				100,       50,       20,
				10,        5,        2,
				1
			];
		
		public static var S_MapMoneyClass:Map;    //筹码对应的类
		public static var S_MapPaiClass:Map;      //扑克牌对应的类
		
		public static var S_pResLobby:CLoadResource;
		public static var S_pResGame:CLoadResource;
		
		public static function StaticInitChipClass(pRes:CLoadResource):void
		{
			S_MapMoneyClass = new Map();
			for(var i:int=0;i<S_ArrayChip.length;++i)
			{
				var strClassName:String = "Chip_" + S_ArrayChip[i];
				var TempChipClass:Class = pRes.GetResource(strClassName);
				S_MapMoneyClass.put(Number(S_ArrayChip[i]),TempChipClass);
				
				//trace(S_ArrayChip[i],strClassName,TempChipClass);
			}
		}
		
		public static function StaticInitPaiClass(pRes:CLoadResource):void
		{
			S_MapPaiClass = new Map();
			for(var i:int=1;i<=55;++i)
			{
				if(i==53 || i==54)
					continue;
				var strClassName:String = "poker" + i;
				var TempChipClass:Class = pRes.GetResource(strClassName);
				S_MapPaiClass.put(i,TempChipClass);
			}
		}
		
		public static var s_arrayPlayerInfo:Vector.<Data_PlayerInfo>;
		public static function StaticInitPlayerInfo():void
		{
			s_arrayPlayerInfo = new Vector.<Data_PlayerInfo>();
		}
		public static function GetPlayerInfoByPID(srcPID:int):Data_PlayerInfo
		{
			var retPI:Data_PlayerInfo = null;
			for(var i:int=0;i<s_arrayPlayerInfo.length;++i ){
				if( s_arrayPlayerInfo[i].m_PID == srcPID ){
					retPI = s_arrayPlayerInfo[i];
					break;
				}
			}
			return retPI;
		}
		
		//用于存放礼物的配置信息
		public static var m_BasePrice:int = 1000;
		public static var m_vectorGiftConfig:Vector.<Data_GiftConfig>;
		public static function StaticInitGiftConfig(GC:Vector.<Data_GiftConfig>):void
		{
			m_vectorGiftConfig = new Vector.<Data_GiftConfig>();
			for(var i:int=0;i<GC.length;++i){
				m_vectorGiftConfig.push(GC[i]);
			}
		}
		public static function GetGiftConfig(GiftID:int):Data_GiftConfig
		{
			if( !m_vectorGiftConfig ) return null;
			
			var retGC:Data_GiftConfig = null;
			for(var i:int=0;i<m_vectorGiftConfig.length;++i){
				if( m_vectorGiftConfig[i].m_GiftID == GiftID ){
					retGC = m_vectorGiftConfig[i];
					break;
				}
			}
			return retGC;
		}
		
		
		public function GlobleData()
		{
		}
	}
}