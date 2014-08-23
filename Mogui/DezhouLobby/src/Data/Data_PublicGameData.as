package Data
{
	public class Data_PublicGameData
	{
		//giftbase=1000;facebase=1000;addmoney=100;sendmoney=1,1,1000;createtable=25,10000,10000000,4,24,1,4;
		
		public static var s_giftbase:int;                           //在大厅时默认的基本分数
		public static var s_facebase:int;                           //
		public static var s_addmoney:int;                           //补充游戏币的时候至少加的盲注的倍数
		
		public static var s_CanSendMoney:int;                       //是否可以相互送游戏以及送的大小值
		public static var s_minSendMoney:int;
		public static var s_maxSendMoney:int;	
		
		public static var s_OneHourMul:int;                         //每小时收费大盲注的倍数
		public static var s_minPay:int;                             //最少收费
		public static var s_maxPay:int;                             //最多收费
		public static var s_minLastTime:int;                        //最短持续时间
		public static var s_maxLastTime:int;                        //最多持续时间
		public static var s_minAddTime:int;                         //最小添加时间
		public static var s_maxAddTime:int;                         //最大添加时间
		
		public function Data_PublicGameData()
		{
			
		}
	}
}