package UILogic
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import L2C.S2C_ClickSitDownButton;
	
	import events.StageToClient;
	
	public class BtnSitDown extends Sprite
	{
		public var m_Idx:int;
		public var m_btnSitDown:SimpleButton;
		public function BtnSitDown()
		{
			super();
			
			m_Idx = -1;
			
			var TempClass:Class = GlobleData.S_pResGame.GetResource("SitDownBtn");
			m_btnSitDown = new TempClass();
			addChild(m_btnSitDown);
			m_btnSitDown.addEventListener(MouseEvent.CLICK,OnBtnClick);
		}
		
		private function OnBtnClick(evt:MouseEvent):void
		{
			if( stage != null )
			{				
				var msgSB:S2C_ClickSitDownButton = new S2C_ClickSitDownButton();
				msgSB.m_ButtonIdx = m_Idx;				
				GlobleFunc.SendStageToClient(stage,msgSB);
			}
		}
	}
}