package UILogic
{
	import flash.geom.Point;
	
	import Data.Data_FriendInfo;
	
	import MoGui.display.CLoadImage;
	import MoGui.display.CText;
	
	import morn.core.components.Clip;
	import morn.core.components.Component;
	
	public class Item_FriendInfo extends Component
	{
		public var m_PID:int;
		public var m_spBack:Clip;		
		public var m_HeadPic:CLoadImage;
		public var m_tName:CText;
		public var m_tGameMoney:CText;		
		
		public function Item_FriendInfo()
		{
			super();
			
			m_PID = 0;
			
			m_spBack = new Clip("png.comp.clip_giftback",1,3);
			m_HeadPic = new CLoadImage(100,100);
			m_tName = new CText("微软雅黑",false,0x292929,12);
			m_tGameMoney = new CText("微软雅黑",false,0xff6100,12);
			
			m_HeadPic.x = 12;
			m_HeadPic.y = 15;
			
			m_tName.SetCenterPoint(new Point(60,130));
			m_tGameMoney.SetCenterPoint(new Point(60,148));			
			
			addChild(m_spBack);
			addChild(m_HeadPic);
			addChild(m_tName);
			addChild(m_tGameMoney);			
		}
		
		public function Update(FI:Data_FriendInfo):void
		{
			m_PID = FI.m_PID;
			
			m_HeadPic.SetPic(FI.m_HeadURL);
			m_tName.SetText(FI.m_NickName);
			m_tGameMoney.SetText("$"+String(FI.m_nGameMoney));
		}
	}
}