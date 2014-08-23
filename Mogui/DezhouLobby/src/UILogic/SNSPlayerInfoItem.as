package UILogic
{	
	import Data.Data_SNSPlayerInfo;
	
	import MoGui.display.CLoadImage;
	import MoGui.display.CRoundRect;
	import MoGui.display.CText;
	
	import morn.core.components.Component;
	
	public class SNSPlayerInfoItem extends Component
	{
		public var m_spBack:CRoundRect;
		public var m_HeadPic:CLoadImage;
		public var m_tNickName:CText;
		public var m_tMoney:CText;
		public var m_tPosition:CText;
		
		public function SNSPlayerInfoItem()
		{
			super();
			
			m_spBack = new CRoundRect();
			m_spBack.Draw(0x000000,210,54,2,2);
			addChild(m_spBack);
			m_spBack.alpha = 0.3;
			
			m_HeadPic = new CLoadImage(48,48);
			addChild(m_HeadPic);
			m_HeadPic.x = 3;
			m_HeadPic.y = 3;
			
			m_tNickName = new CText("_sans",false,0xAAC6DE,12);
			addChild(m_tNickName);
			m_tNickName.x = 55;
			m_tNickName.y = 1;
			
			m_tMoney = new CText("_sans",false,0xf9CF3B,12);
			addChild(m_tMoney);
			m_tMoney.x = 55;
			m_tMoney.y = 17;
			
			m_tPosition = new CText("_sans",false,0x567FA6,12);
			addChild(m_tPosition);
			m_tPosition.x = 55;
			m_tPosition.y = 33;
		}
		
		public function UpdateItemInfo(dataItem:Data_SNSPlayerInfo):void
		{
			m_HeadPic.SetPic(dataItem.m_HeadURL);
			m_tNickName.text = dataItem.m_NickName;
			m_tMoney.text    = "$" + GlobleFunc.MoneyToString(dataItem.m_nMoney);
			m_tPosition.text = dataItem.m_strState;
		}
	}
}