package UILogic
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	
	import MoGui.display.CText;
	
	import morn.core.components.Button;
	
	public class CBtn_JuBaoPeng extends Sprite
	{
		public var m_btnJuBaoPeng:Button;
		public var m_tJuBaoPeng:CText;
		
		public function CBtn_JuBaoPeng()
		{
			super();
			
			var TempClass:Class;
				
			m_btnJuBaoPeng = new Button("png.comp.button_yellow","聚宝盆");
			addChild(m_btnJuBaoPeng);
			
			m_tJuBaoPeng = new CText("_sans",false,0x000000,14);
			addChild(m_tJuBaoPeng);			
			m_tJuBaoPeng.SetCenterPointXY(103,18);			
			m_tJuBaoPeng.mouseEnabled = false;
			m_tJuBaoPeng.mouseChildren = false;
			
			SetMoney(100000000);
		}
		
		public function SetMoney(nMoney:Number):void
		{
			m_tJuBaoPeng.text = GlobleFunc.MoneyToString(nMoney);
		}
	}
}