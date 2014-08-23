package UILogic
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import MoGui.display.CText;
	
	import morn.core.components.Button;
	import morn.core.components.Clip;
	
	public class CBtnPreOpreator extends Sprite
	{
		public var m_btnBack:Button;
		public var m_clipCheck:Clip;
		
		public var m_tLabel:CText;
		public var m_tMoney:CText;

		private var m_nMoney:Number;
		
		public function CBtnPreOpreator(strLabel:String,strButton:String)
		{
			super();
			
			m_nMoney = 0;
			
			m_btnBack = new Button("png.comp."+strButton);
			addChild(m_btnBack);
			m_btnBack.width = 230;
			m_btnBack.sizeGrid = "16,16,16,16";
			
			m_clipCheck = new Clip("png.comp.clip_checkbox",1,3);
			addChild(m_clipCheck);
			m_clipCheck.x = 12;
			m_clipCheck.y = 7;
			
			m_tLabel = new CText("宋体",false,0xffffff,18);
			addChild(m_tLabel);			
			m_tLabel.mouseEnabled = false;
			m_tLabel.mouseChildren = false;
			m_tLabel.SetCenterPoint(new Point(115,15));
			m_tLabel.text = strLabel;
			
			m_tMoney = new CText("_sans",false,0xcfff88,14);
			addChild(m_tMoney);		
			m_tMoney.SetCenterPointXY(150,15);
			m_tMoney.mouseEnabled = false;
			m_tMoney.mouseChildren = false;
		}
		
		public function GetMoney():Number
		{
			return m_nMoney;
		}
		public function SetMoney(nMoney:Number):void
		{
			m_nMoney      = nMoney;
			m_tMoney.text = GlobleFunc.MoneyToString(nMoney);
		}
		public function SetLabel(strLabel:String):void
		{
			m_tLabel.text = strLabel;
		}
		
		public function SetSelect(bSelect:Boolean):void
		{
			if( bSelect )
			{
				m_clipCheck.frame = 2;
			}
			else
			{
				m_clipCheck.frame = 1;
			}
		}
	}
}