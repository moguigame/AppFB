package UILogic
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	
	import L2C.S2C_Flag;
	
	import MoGui.display.CHideLayer;
	import MoGui.display.CText;
	
	import morn.core.components.Button;
	import morn.core.components.Image;
	import morn.core.components.Slider;
	
	import morn.core.components.Tab
	
	public class Box_TakeMoney extends Sprite
	{
		private var m_btnClose:Button;
		private var m_btnSitDown:Button;
		private var m_btnBuyMoney:Button;
		
		private var m_spSlider:Slider;
		private var m_spImage:Image;
		private var m_tSelectMoney:CText;
		
		private var m_tCurMoney:CText;
		private var m_tMinMoney:CText;
		private var m_tMaxMoney:CText;
		private var m_tTakeMoney:CText;
		private var m_tTiShi:CText;
		
		private var m_minMoney:Number;
		private var m_maxMoney:Number;
		private var m_BigBliend:int;
		private var m_myMoney:Number;
		
		public function Box_TakeMoney()
		{
			super();
			
			var m_spHideBack:CHideLayer;
			m_spHideBack = new CHideLayer(0x000000);
			m_spHideBack.width = PositionConfig.s_GameWidth;
			m_spHideBack.height = PositionConfig.s_GameHeight;
			m_spHideBack.alpha = 0.6;
			addChild(m_spHideBack);
			
			var StartX:int = (PositionConfig.s_GameWidth  - 440)/2;
			var StartY:int = (PositionConfig.s_GameHeight - 370)/2;
			
			var back1:Image = new Image("png.comp.image_box_bg1");
			back1.sizeGrid = "10,10,10,10";
			back1.width  = 440;
			back1.height = 360;
			back1.x = StartX;
			back1.y = StartY;
			addChild(back1);
			
			var tTitle:CText = new CText();
			tTitle.SetText("游 戏 币 带 入");
			addChild(tTitle);
			var tf:TextFormat = tTitle.GetTextFormat();
			tf.size  =  20;
			tf.font = "黑体";
			tf.bold = true;
			tTitle.SetTextFormat(tf);
			tTitle.SetCenterPointXY(StartX+220,StartY+30);
			
			var back4:Image = new Image("png.comp.image_box_bg4");
			back4.x = StartX + (440-back4.width)/2;
			back4.y = StartY;
			addChild(back4);
			
			var back2:Image = new Image("png.comp.image_box_bg2");
			back2.sizeGrid = "10,10,10,10";
			back2.width  = 430;
			back2.height = 300;
			back2.x = StartX + 5;
			back2.y = StartY + 55;
			addChild(back2);
			
			var back3:Image = new Image("png.comp.image_box_bg3");
			back3.sizeGrid = "10,10,10,10";
			back3.width  = 430;
			back3.height = 95;
			back3.x = StartX + 5;
			back3.y = StartY + 260;
			addChild(back3);
			
			m_btnClose = new Button("png.comp.button_box_close");
			addChild(m_btnClose);
			m_btnClose.x = StartX + 415;
			m_btnClose.y = StartY - 10;
			m_btnClose.addEventListener(MouseEvent.CLICK,OnBtnClose);
			
			m_btnSitDown = new Button("png.comp.button_box_blue","开 始 游 戏");
			m_btnSitDown.sizeGrid = "22,22,22,22";
			addChild(m_btnSitDown);
			m_btnSitDown.labelColors = "0xffffff";
			m_btnSitDown.labelBold = true;
			m_btnSitDown.labelFont = "黑体";
			m_btnSitDown.labelSize = 16;
			m_btnSitDown.x = StartX + 100;
			m_btnSitDown.y = StartY + 295;
			m_btnSitDown.width = 250;
			
			m_btnBuyMoney = new Button("png.comp.button_box_yellow","购 买 游 戏 币");
			m_btnBuyMoney.sizeGrid = "22,22,22,22";
			addChild(m_btnBuyMoney);
			m_btnBuyMoney.labelColors = "0xffffff";
			m_btnBuyMoney.labelBold = true;
			m_btnBuyMoney.labelFont = "黑体";
			m_btnBuyMoney.labelSize = 16;
			m_btnBuyMoney.x = StartX + 100;
			m_btnBuyMoney.y = StartY + 295;
			m_btnBuyMoney.width = 250;
			
			m_tTiShi = new CText("黑体");
			m_tTiShi.SetTextColor(0xd53a3d);
			m_tTiShi.SetTextSize(14);
			m_tTiShi.SetText("你的游戏币低于本桌最小带入额，请充值");
			addChild(m_tTiShi);
			m_tTiShi.SetCenterPointXY(StartX + 220,StartY + 280);
			
			m_spSlider = new Slider("png.comp.hslider_1");
			m_spSlider.direction = Slider.HORIZONTAL;
			m_spSlider.showLabel = false;
			m_spSlider.height = 5;
			m_spSlider.width = 300;
			addChild(m_spSlider);
			m_spSlider.x = StartX + 72;
			m_spSlider.y = StartY + 160;
			m_spSlider.addEventListener(Event.CHANGE,OnSliderChange);
			m_spSlider.setSlider(200000,2000000,5000);
			
			var t1:CText = new CText("黑体",false,0x575a5a,14);
			t1.SetText("我的游戏币：");
			t1.x = StartX + 20;
			t1.y = StartY + 70;
			addChild(t1);
			
			m_tCurMoney = new CText("Arial",true,0xff6700,14);
			m_tCurMoney.x = t1.x + 85;
			m_tCurMoney.y = t1.y;
			addChild(m_tCurMoney);
			m_tCurMoney.SetText("$1339949");
			
			var t2:CText = new CText("黑体",false,0x575a5a,14);
			t2.SetText("带入游戏币：");
			t2.x = StartX + 20;
			t2.y = StartY + 115;
			addChild(t2);
			
			m_tTakeMoney = new CText("Arial",true,0xff6700,30);
			m_tTakeMoney.SetCenterPointXY(StartX+220,StartY+120);
			addChild(m_tTakeMoney);
			m_tTakeMoney.SetText("$1339949");
			
			var tMin:CText = new CText("黑体",true,0x575a5a,16);
			tMin.SetText("最小");
			tMin.x = StartX + 25;
			tMin.y = StartY + 153;
			addChild(tMin);
			
			m_tMinMoney = new CText("Arial",false,0x004c8c,14);
			addChild(m_tMinMoney);
			m_tMinMoney.SetCenterPointXY(StartX+50,StartY+190);
			m_tMinMoney.SetText("$1339949");
			
			var tMax:CText = new CText("黑体",true,0x575a5a,16);
			tMax.SetText("最大");		
			tMax.x = StartX + 380;
			tMax.y = StartY + 153;
			addChild(tMax);
			
			m_tMaxMoney = new CText("Arial",false,0x004c8c,14);
			addChild(m_tMaxMoney);
			m_tMaxMoney.SetCenterPointXY(StartX+390,StartY+190);
			m_tMaxMoney.SetText("$1339949");
			
			m_spImage = new Image("png.comp.box_takemoney");
			addChild(m_spImage);
			
			m_tSelectMoney = new CText("黑体");
			addChild(m_tSelectMoney);
		}
		
		private function OnSliderChange(evt:Event):void
		{
			if( stage )
			{
				//var msgFlag:S2C_Flag  = new S2C_Flag();
				//msgFlag.m_Flag        = S2C_Flag.ChipSliderChange;
				//msgFlag.m_Value       = m_spSlider.value;
				//GlobleFunc.SendStageToClient(stage,msgFlag);
			}
		}
		
		private function SetSelectMoney(nSelectMoney:Number):void
		{
			if( nSelectMoney<m_spSlider.min || nSelectMoney>m_spSlider.max )
			{
				m_spImage.visible = false;
				m_tSelectMoney.visible = false;
			}
			else
			{
				var nLength:int = 300 - 30;
				var DiffX:int   = (300-30);
				//m_spImage.x = 
			}
		}
		private function OnBtnClose(evt:MouseEvent):void
		{
			this.visible = false;
		}
		public function Show(myMoney:Number,minMoney:Number,maxMoney:Number,bigblind:int):void
		{
			m_myMoney   = myMoney;
			m_minMoney  = minMoney;
			m_maxMoney  = maxMoney;
			m_BigBliend = bigblind;
			
			if( myMoney < minMoney )
			{
				m_btnSitDown.visible = false;
				m_btnBuyMoney.visible = true;
			}
			else
			{
				m_btnSitDown.visible = true;
				m_btnBuyMoney.visible = false;
			}
			
			m_spSlider.setSlider(minMoney,maxMoney,bigblind);
			
			this.visible = true;
		}
	}
}