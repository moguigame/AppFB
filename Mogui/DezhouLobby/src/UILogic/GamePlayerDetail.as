package UILogic
{
	import flash.display.Sprite;
	
	import Data.Data_PlayerInfo;
	
	import MoGui.display.CLoadImage;
	import MoGui.display.CText;
	import MoGui.utils.CFunction;
	
	public class GamePlayerDetail extends Sprite
	{
		public var m_spBack:Sprite;
		
		private var m_HeadPic:CLoadImage;
		private var m_tLevel:CText;
		private var m_tNickName:CText;
		
		public function GamePlayerDetail()
		{
			super();
			
			var TempClass:Class;
			
			TempClass = GlobleData.S_pResGame.GetResource("UserInfoDetailBG");
			m_spBack = new TempClass();
			addChild(m_spBack);
			
			m_HeadPic = new CLoadImage(100,100);
			addChild(m_HeadPic);
			m_HeadPic.x = 10;
			m_HeadPic.y = 10;
			
			m_tLevel = new CText();
			addChild(m_tLevel);
			m_tLevel.x = 115;
			m_tLevel.y = 10;
			
			m_tNickName = new CText();
			addChild(m_tNickName);
			m_tNickName.x = 140;
			m_tNickName.y = 10;
		}
		
		public function SetData(dataPI:Data_PlayerInfo):void
		{
			m_HeadPic.SetPic(dataPI.m_HeadPicURL);
			m_tLevel.SetText("Lv"+dataPI.m_GameLevel);
			m_tNickName.SetText(CFunction.GetPartStr(dataPI.m_NickName,20));
		}
	}
}