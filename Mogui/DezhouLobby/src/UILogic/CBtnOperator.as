package UILogic
{
	import flash.display.Sprite;
	
	import MoGui.display.CText;
	
	import morn.core.components.Button;
	import morn.core.components.Image;
	
	public class CBtnOperator extends Sprite
	{		
		public var m_btnBack:Button;
		public var m_spRes:Image;
		
		public var m_tLabel:CText;
		public var m_tMoney:CText;
		
		public var m_btnIdx:int;
		public var m_nMoney:Number;
		
		public function CBtnOperator(strLabel:String,strButton:String, strRes:String="")
		{
			super();
			
			m_nMoney = 0;
			
			m_btnBack = new Button("png.comp."+strButton);
			addChild(m_btnBack);
			m_btnBack.width = 230;
			m_btnBack.sizeGrid = "16,16,16,16";
			
			m_spRes = new Image("png.comp."+strRes);
			addChild(m_spRes);
			m_spRes.x = 12;
			m_spRes.y = 7;
			
			m_tLabel = new CText("黑体",false,0xffffff,16);
			addChild(m_tLabel);
			m_tLabel.text = strLabel;
			m_tLabel.mouseEnabled = false;
			m_tLabel.mouseChildren = false;
			
			m_tMoney = new CText("_sans",false,0xeffd55,14);
			addChild(m_tMoney);			
			m_tMoney.SetCenterPointXY(150,15);
			m_tMoney.mouseEnabled = false;
			m_tMoney.mouseChildren = false;
		}
		
		public function SetLabel(strName:String):void
		{
			m_tLabel.text = strName;
		}		
		public function SetMoney(nMoney:Number):void
		{
			m_nMoney = nMoney;
			m_tMoney.text = GlobleFunc.MoneyToString(nMoney);
		}
	}
}