package UILogic
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import L2C.S2L_Flag;
	
	import MoGui.display.CMotionSprite;
	
	public class CJuBaoPengRule extends CMotionSprite
	{
		public static const  OPEN:int     = 1;
		public static const  CLOSE:int    = 2;
		
		public var m_spRule:Sprite;
		public var m_btnClose:SimpleButton;
		
		public function CJuBaoPengRule()
		{
			super();
			/*
			var TempClass:Class;			
			TempClass = GlobleData.S_pResLobby.GetResource("JuBaoPenRule");
			m_spRule = new TempClass();
			addChild(m_spRule);
			
			TempClass = GlobleData.S_pResLobby.GetResource("BTN_JBPClose");
			m_btnClose = new TempClass();
			addChild(m_btnClose);
			m_btnClose.x = 530;
			m_btnClose.y = 10;
			m_btnClose.addEventListener(MouseEvent.CLICK,OnBtnClose);
			*/
		}
		
		public function OnBtnClose(evt:MouseEvent):void
		{
			var msgFlag:S2L_Flag = new S2L_Flag();
			msgFlag.m_Flag     = S2L_Flag.BTN_JuBaoPengClick;
			msgFlag.m_Value    = CJuBaoPengRule.CLOSE;
			GlobleFunc.SendStageToLobby(stage,msgFlag);
		}
	}
}