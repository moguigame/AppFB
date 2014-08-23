package
{
	import flash.display.Sprite;
	import flash.display.Stage;
	
	import PublicXY.Public_XYBase;
	
	import events.ChildToParent;
	import events.StageToClient;
	import events.StageToLobby;

	public class GlobleFunc
	{
		public static function LogError(...args):void
		{
			trace( new Date().toLocaleTimeString(),"Log ?????????????????????",args );
			Logger.log("Log ?????????????????????",args);
		}
		
		public static function SendStageToClient(sg:Stage,msg:Public_XYBase):void
		{
			if( sg != null )
			{
				var evtS2C:StageToClient = new StageToClient();	
				msg.Write(evtS2C.m_msgData);
				evtS2C.m_msgData.ResetDataPosition();
				sg.dispatchEvent(evtS2C);
			}
		}
		public static function SendStageToLobby(sg:Stage,msg:Public_XYBase):void
		{
			if( sg != null )
			{
				var evtS2L:StageToLobby = new StageToLobby();
				msg.Write(evtS2L.m_msgData);
				evtS2L.m_msgData.ResetDataPosition();
				sg.dispatchEvent(evtS2L);
			}
		}
		public static function SendChildToParent(sp:Sprite,msg:Public_XYBase):void
		{
			if( sp != null )
			{
				var evtC2P:ChildToParent = new ChildToParent();
				msg.Write(evtC2P.m_msgData);
				evtC2P.m_msgData.ResetDataPosition();
				sp.dispatchEvent(evtC2P);
			}
		}
		
		public static function IsPaiBack(nPai:int):Boolean
		{
			return nPai == 55;
		}
		public static function IsPaiMian(nPai:int):Boolean
		{
			return nPai>=1 && nPai<=52 ;
		}
		public static function IsPaiNone(nPai:int):Boolean
		{
			return nPai == 0;
		}
		public static function IsRightPaiType(nType:int):Boolean
		{
			return nType>0 && nType<=10 ;
		}
		
		public static function GetDate(nSecond:int):String
		{
			var retString:String = "";
			var TempDate:Date = new Date(nSecond*Number(1000));
			//TempDate.setSeconds(nSecond);
			retString = String(TempDate.getUTCFullYear())+"年"+String(TempDate.month)+"月"+String(TempDate.date)+"日";
			
			return retString;
		}
		public static function GetDate_XXYYZZ(nSecond:int):String
		{
			var retString:String = "";
			var TempDate:Date = new Date(nSecond*Number(1000));
			retString = String(TempDate.getUTCFullYear())+"."
				      + ((TempDate.month>=10) ? String(TempDate.month) : ("0"+String(TempDate.month))) +"."
					  + ((TempDate.date>=10) ? String(TempDate.date) : ("0"+String(TempDate.date)) );
			
			return retString;
		}
		public static function GetTime_XXYYZZ(nSecond:int):String{
			var retString:String = "";
			var TempDate:Date = new Date(nSecond*Number(1000));
			retString = ((TempDate.hours>=10)   ? String(TempDate.hours)   : ("0"+String(TempDate.hours))) +":"
				      + ((TempDate.minutes>=10) ? String(TempDate.minutes) : ("0"+String(TempDate.minutes))) +":"
				      + ((TempDate.seconds>=10) ? String(TempDate.seconds) : ("0"+String(TempDate.seconds)) );
			return retString;
		}
		public static function GetDateTime(nSecond:int):String
		{
			var retString:String = "";
			var TempDate:Date = new Date(nSecond*Number(1000));	
			//TempDate.setSeconds(nSecond);	
			retString = String(TempDate.fullYear)+"年"+String(TempDate.month)+"月"+String(TempDate.date)+"日"
				+String(TempDate.hours)+"时"+String(TempDate.minutes)+"分"+String(TempDate.seconds)+"秒";
			
			return retString;
		}
		
		public static function MoneyToString(nMoney:Number):String
		{
			var YuShu:Number = 0;
			var Shang:Number = Math.abs(nMoney);
			var strRet:String = "";
			var TempStr:String = "";
			while( Shang>= 1000 )
			{
				YuShu = Math.floor(Shang%1000);
				Shang = Math.floor(Shang/1000);
				
				TempStr = String(YuShu);
				while(TempStr.length<3)
				{
					TempStr += "0";
				}				
				strRet = "," + TempStr + strRet;
			}
			strRet = String(Shang) + strRet;
			if(nMoney<0)
			{
				strRet = "-"+strRet;
			}
			return strRet;
		}
		
		public static function MoneyToChineseWan(nMoney:Number):String
		{
			var retStr:String = "";			
			
			return retStr;
		}
		
		public function GlobleFunc()
		{
			
		}
	}
}