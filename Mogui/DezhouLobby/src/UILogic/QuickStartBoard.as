package UILogic
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import L2C.S2C_Flag;
	
	import MoGui.display.CRectangle;
	import MoGui.display.CText;
	
	import morn.core.components.Button;
	
	public class QuickStartBoard extends Sprite
	{
		public var m_btnStart:Button;
		public var m_nTakeMoney:Number;
		
		public function QuickStartBoard()
		{
			super();
			
			m_nTakeMoney = 0;
			
			var TempBack:CRectangle = new CRectangle();
			TempBack.width = 500;
			TempBack.height = 130;
			//addChild(TempBack);
			TempBack.alpha = 0.15;
			
			m_btnStart = new Button("png.comp.button_startgame","快 速 开 始");
			m_btnStart.sizeGrid = "20,20,20,20";
			addChild(m_btnStart);
			m_btnStart.width = 330;
			
			//m_btnStart.labelBold = true;
			m_btnStart.labelFont = "黑体";
			m_btnStart.labelSize = 24;
			m_btnStart.labelColors = "0xffffff,0xffffff,0xffffff,0xffffff";
			m_btnStart.labelMargin = "0,-2,0,0";
			m_btnStart.x = 100;
			m_btnStart.y = 40;
			
			m_btnStart.addEventListener(MouseEvent.CLICK,OnBtnQuickStart);
			//m_btnStart.labelStroke = "0xe45600, 1, 3, 3, 10, 1";
		}
		
		public function SetTakeMoney(nMoney:Number):void
		{
			m_nTakeMoney = Math.ceil(nMoney);
		}
		
		public function OnBtnQuickStart(evt:MouseEvent):void
		{
			var msgFlag:S2C_Flag = new S2C_Flag();
			msgFlag.m_Flag       = S2C_Flag.QuickStart;
			msgFlag.m_Value      = m_nTakeMoney;
			GlobleFunc.SendStageToClient(stage,msgFlag);
		}
	}
}