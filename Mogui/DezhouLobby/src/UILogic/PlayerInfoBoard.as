package UILogic
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import L2C.S2L_Flag;
	
	import MoGui.display.CLoadImage;
	import MoGui.display.CText;
	
	import morn.core.components.Button;
	import morn.core.components.Image;
	
	public class PlayerInfoBoard extends Sprite
	{
		private var m_spBack:Image;
		private var m_btnZiLiao:Button;
		private var m_btnBaoXianXiang:Button;
		
		public var m_HeadPIC:CLoadImage;
		public var m_NickName:CText;
		public var m_Level:CText;
		
		public function PlayerInfoBoard()
		{
			super();
			
			var TempClass:Class;
			
			m_spBack = new Image("png.comp.Image_Back3");
			m_spBack.sizeGrid = "10,10,10,10";
			m_spBack.width = 300;
			m_spBack.height = 100;
			addChild(m_spBack);
			
			m_btnBaoXianXiang = new Button("png.comp.button_blue","我的银行");
			addChild(m_btnBaoXianXiang);
			m_btnBaoXianXiang.x = 170;
			m_btnBaoXianXiang.y = 65;
			m_btnBaoXianXiang.height = 26;
			m_btnBaoXianXiang.width  = 70;
			m_btnBaoXianXiang.labelColors = "0xffffff,0xffffff,0xffffff,0xffffff";
			m_btnBaoXianXiang.labelSize = 12;
			m_btnBaoXianXiang.addEventListener(MouseEvent.CLICK,OnBtnBank);
			
			m_btnZiLiao = new Button("png.comp.button_blue","个人资料");
			addChild(m_btnZiLiao);
			m_btnZiLiao.x = 95;
			m_btnZiLiao.y = 65;
			m_btnZiLiao.height = 26;
			m_btnZiLiao.width  = 70;
			m_btnZiLiao.labelColors = "0xffffff,0xffffff,0xffffff,0xffffff";
			m_btnZiLiao.labelSize = 12;
			m_btnZiLiao.addEventListener(MouseEvent.CLICK,OnBtnZiLiao);
			
			m_NickName = new CText();
			m_NickName.text = "";
			addChild(m_NickName);
			m_NickName.x = 135;
			m_NickName.y = 10;
			m_NickName.SetFont("黑体");
			m_NickName.SetTextSize(16);
			//m_NickName.SetBold(true);
			
			m_Level = new CText();
			m_Level.text = "Lv10";
			addChild(m_Level);
			m_Level.x = 95;
			m_Level.y = 10;
			m_Level.SetTextColor("0xfad03b");
			m_Level.SetTextSize(16);
			
			m_HeadPIC = new CLoadImage(80,80);
			addChild(m_HeadPIC);
			m_HeadPIC.x = 8;
			m_HeadPIC.y = 10;
		}		
		public function SetPlayerNickName(Name:String):void
		{
			m_NickName.text = Name;
		}
		public function SetPlayerHeadURL(strURL:String):void
		{
			m_HeadPIC.SetPic(strURL);
		}
		
		private function OnBtnBank(evt:MouseEvent):void
		{
			var msgFlag:S2L_Flag = new S2L_Flag();
			msgFlag.m_Flag       = S2L_Flag.BTN_BANK;
			GlobleFunc.SendStageToLobby(stage,msgFlag);
		}
		
		private function OnBtnZiLiao(evt:MouseEvent):void
		{
			var msgFlag:S2L_Flag = new S2L_Flag();
			msgFlag.m_Flag       = S2L_Flag.BTN_ZILIAO;
			GlobleFunc.SendStageToLobby(stage,msgFlag);
		}
	}
}