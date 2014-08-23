package UILogic
{	
	import Data.Data_SNSPlayerInfo;
	
	import MoGui.display.CLoadImage;
	import MoGui.display.CRoundRect;
	import MoGui.display.CText;
	
	import morn.core.components.Button;
	import morn.core.components.Component;
	
	public class Item_SNSPlayerInfo extends Component
	{
		public var m_spBack:CRoundRect;
		public var m_HeadPic:CLoadImage;
		public var m_tNickName:CText;
		public var m_tMoney:CText;
		public var m_tPosition:CText;		
		
		public var m_btnTrace:Button;
		public var m_btnFocus:Button;
		public var m_btnInvite:Button;
		
		public function Item_SNSPlayerInfo()
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
			
			m_btnTrace = new Button("png.comp.button_trace","");
			addChild(m_btnTrace);
			m_btnTrace.x = 165;
			m_btnTrace.y = 17;
			//m_btnTrace.height = 22;
			//m_btnTrace.width = 45;
			m_btnTrace.labelColors = "0xffffff";
			m_btnTrace.labelMargin = "0,5,0,5";
			
			m_btnFocus = new Button("png.comp.button_addfriend","");
			addChild(m_btnFocus);
			m_btnFocus.x = 165;
			m_btnFocus.y = 17;
			//m_btnFocus.height = 22;
			//m_btnFocus.width = 45;
			//m_btnFocus.labelColors = "0xffffff";
			//m_btnFocus.labelMargin = "0,5,0,5";
			
			m_btnInvite = new Button("png.comp.buton_invite","");
			addChild(m_btnInvite);
			m_btnInvite.x = 165;
			m_btnInvite.y = 17;
			//m_btnInvite.height = 22;
			//m_btnInvite.width = 45;
			m_btnInvite.labelColors = "0xffffff";
			m_btnInvite.labelMargin = "0,5,0,5";
		}
		
		public function UpdateItemInfo(dataItem:Data_SNSPlayerInfo):void
		{
			m_HeadPic.SetPic(dataItem.m_HeadURL);
			m_tNickName.text = dataItem.m_NickName;
			m_tMoney.text    = "$" + GlobleFunc.MoneyToString(dataItem.m_nMoney);
			m_tPosition.text = dataItem.m_strState;
			
			m_btnTrace.visible = false;
			m_btnFocus.visible = false;
			m_btnInvite.visible = false;
		}
	}
}