package L2C
{
	import MoGui.net.MsgData;
	
	import PublicXY.Public_XYBase;
	
	public class S2C_Flag extends Public_XYBase
	{
		public static const ID:int     = LC_XieYiID.XYID_S2C_Flag;
		
		public static const ChipSpriteClick:int            = 1;
		public static const ChipSliderChange:int           = 2;
		public static const MouseOverHeadPic:int           = 3;
		public static const MouseOutHeadPic:int            = 4;
		public static const QuickStart:int                 = 5;
		public static const QuickChat:int                  = 6;
		public static const ShowFace:int                   = 7;
		public static const ShowWordList:int               = 8;
		public static const ClickPlayerHead:int            = 9;
		
		public var m_Flag:int;
		public var m_Value:Number;
		
		public function S2C_Flag()
		{
			super();
			
			m_Flag = 0;
			m_Value = 0;
		}
		
		override public function Write(msgdata:MsgData):void
		{
			msgdata.m_msgID = ID;
			msgdata.WriteInt(m_Flag);
			msgdata.WriteInt64(m_Value);
		}
		override public function Read(msgdata:MsgData):void
		{
			m_Flag = msgdata.ReadInt();
			m_Value = msgdata.ReadInt64();
		}
	}
}