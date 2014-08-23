package UILogic
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import L2C.S2L_Flag;
	
	import morn.core.components.Clip;
	
	public class CCommonMatch extends Sprite
	{
		public static const CommonState:int = 1;
		public static const MatchState:int  = 2;
		
		public var m_btnCommon:Clip;
		public var m_btnMatch:Clip;
		
		public var m_nSelect:int;
		
		public function CCommonMatch()
		{
			super();
			
			m_nSelect = 0;
			
			var TempClass:Class;
			
			m_btnCommon = new Clip("png.comp.clip_tab_lobby",1,3);
			addChild(m_btnCommon);
			
			m_btnCommon.addEventListener(MouseEvent.ROLL_OVER,OnCommonOver);
			m_btnCommon.addEventListener(MouseEvent.ROLL_OUT,OnCommonOut);
			m_btnCommon.addEventListener(MouseEvent.CLICK,OnCommonClick);
			
			m_btnMatch = new Clip("png.comp.clip_tab_match",1,3);
			addChild(m_btnMatch);
			m_btnMatch.x = 150;
			
			m_btnMatch.addEventListener(MouseEvent.ROLL_OVER,OnMatchOver);
			m_btnMatch.addEventListener(MouseEvent.ROLL_OUT,OnMatchOut);
			m_btnMatch.addEventListener(MouseEvent.CLICK,OnMatchClick);
		}
		
		public function SetSelect(nSelect:int):void
		{
			if( m_nSelect != nSelect )
			{
				var msgFlag:S2L_Flag = new S2L_Flag();
				msgFlag.m_Flag       = S2L_Flag.ChangDi;
				
				m_nSelect = nSelect;
				if( nSelect == CommonState )
				{					
					m_btnCommon.frame = 2;
					m_btnMatch.frame = 0;
					
					msgFlag.m_Value = CommonState;
				}
				else if( nSelect == MatchState )
				{					
					m_btnCommon.frame = 0;
					m_btnMatch.frame = 2;
					
					msgFlag.m_Value = MatchState;
				}
				
				GlobleFunc.SendStageToLobby(stage,msgFlag);
			}			
		}
		
		private function OnCommonOver(evt:MouseEvent):void
		{
			if( m_nSelect != CommonState )
			{
				m_btnCommon.frame = 1;
			}
		}
		private function OnCommonOut(evt:MouseEvent):void
		{
			if( m_nSelect != CommonState )
			{
				m_btnCommon.frame = 0;
			}
		}
		private function OnCommonClick(evt:MouseEvent):void
		{
			SetSelect(CommonState);
		}
		
		private function OnMatchOver(evt:MouseEvent):void
		{
			if( m_nSelect != MatchState )
			{
				m_btnMatch.frame = 1;
			}
		}
		private function OnMatchOut(evt:MouseEvent):void
		{
			if( m_nSelect != MatchState )
			{				
				m_btnMatch.frame = 0;
			}
		}
		private function OnMatchClick(evt:MouseEvent):void
		{
			SetSelect(MatchState);
		}
	}
}