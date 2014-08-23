package L2C
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class S2L_Flag extends Public_XYBase
	{
		public static const ID:int     = LC_XieYiID.XYID_S2L_Flag;
		
		public static const ChangDi:int                    = 1;   //切换普通场与比赛场
		public static const BTN_JuBaoPengClick:int         = 2;
		public static const BTN_ZILIAO:int                 = 3;   //显示玩家资料
		public static const BTN_BANK:int                   = 4;   //显示银行功能
		
		public static const Bank_Close:int                 = 11;  //关闭银行窗口
		public static const Bank_In:int                    = 12;
		public static const Bank_Out:int                   = 13;
		
		public static const CreateTable_Close:int          = 21;  //关闭创建桌子的窗口
		
		public static const PlayerInfo:int                 = 31;  //关闭玩家资料窗口
		
		public static const Title:int                      = 41;  //商城		
		
		public static const Shop:int                       = 51;  //商店的消息
		
		public static const PlayerAction:int               = 61;  //玩家交互动作
		
		public var m_Flag:int;
		public var m_Value:Number;
		public var m_msgString:String;
		
		public function S2L_Flag()
		{
			super();
			
			m_Flag = 0;
			m_Value = 0;
			m_msgString = "";
		}		
		override public function Write(msgdata:MsgData):void
		{
			msgdata.m_msgID = ID;
			msgdata.WriteInt(m_Flag);
			msgdata.WriteInt64(m_Value);
			msgdata.WriteString(m_msgString);
		}
		override public function Read(msgdata:MsgData):void
		{
			m_Flag = msgdata.ReadInt();
			m_Value = msgdata.ReadInt64();
			m_msgString = msgdata.ReadString();
		}
	}
}