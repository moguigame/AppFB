package UILogic
{
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	
	import L2C.S2L_Flag;
	
	import ui.TitleUI;
	
	public class LobbyTopBar extends TitleUI
	{
		public static const E_Shop:int                 = 1;
		public static const E_ChongZhi:int             = 2;
		
		public function LobbyTopBar()
		{
			super();
			
			m_btnFullScreen.addEventListener(MouseEvent.CLICK,OnBtnFullScreen);
			m_btnShangCheng.addEventListener(MouseEvent.CLICK,OnBtnShangCheng);
			m_btnChongZhi.addEventListener(MouseEvent.CLICK,OnChongZhi);
			
			m_tGameMoney.text = "";
			m_tMoGuiMoney.text = "";
		}
		
		private function OnJuBaoPengClick(evt:MouseEvent):void
		{
			var msgFlag:S2L_Flag = new S2L_Flag();
			msgFlag.m_Flag     = S2L_Flag.BTN_JuBaoPengClick;
			msgFlag.m_Value    = CJuBaoPengRule.OPEN;
			GlobleFunc.SendStageToLobby(stage,msgFlag);
		}
		public function SetGameMoney(nMoney:Number):void
		{
			m_tGameMoney.text = GlobleFunc.MoneyToString(nMoney);
		}
		public function SetMoGuiMoney(nMoGuiMoney:Number):void
		{
			m_tMoGuiMoney.text = GlobleFunc.MoneyToString(nMoGuiMoney);
		}
		
		public function OnBtnShangCheng(evt:MouseEvent):void
		{
			var msgFlag:S2L_Flag = new S2L_Flag();
			msgFlag.m_Flag     = S2L_Flag.Title;
			msgFlag.m_Value    = E_Shop;
			GlobleFunc.SendStageToLobby(stage,msgFlag);
		}
		public function OnChongZhi(evt:MouseEvent):void
		{
			var msgFlag:S2L_Flag = new S2L_Flag();
			msgFlag.m_Flag     = S2L_Flag.Title;
			msgFlag.m_Value    = E_ChongZhi;
			GlobleFunc.SendStageToLobby(stage,msgFlag);
		}
		
		private function OnBtnFullScreen(evt:MouseEvent):void
		{
			if( stage != null )
			{
				if( stage.displayState == StageDisplayState.FULL_SCREEN )
				{
					stage.displayState = StageDisplayState.NORMAL;
				}
				else
				{
					stage.displayState = StageDisplayState.FULL_SCREEN
					stage.scaleMode = StageScaleMode.EXACT_FIT;
				}				
			}
		}
	}
}