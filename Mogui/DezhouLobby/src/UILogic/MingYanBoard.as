package UILogic
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	
	import MoGui.display.CRectangle;
	
	import morn.core.components.Label;
	
	public class MingYanBoard extends Sprite
	{
		private var m_arrayWord:Vector.<String>;
		private var m_LastUpTime:int;
		private var m_Total:int;
		private var m_Cur:int;
		
		private var m_spText:Label;
		private var m_btnLeft:SimpleButton;
		private var m_btnRight:SimpleButton;
		
		public function MingYanBoard()
		{
			super();
			
			m_Total = 0;
			m_Cur = 0;
			m_LastUpTime = 0;
			
			m_arrayWord = new Vector.<String>;
			
			var TempBack:CRectangle = new CRectangle();
			TempBack.width = 500;
			TempBack.height = 130;
			//addChild(TempBack);
			TempBack.alpha = 0.15;
			
			var TempClass:Class;
			
			TempClass = GlobleData.S_pResGame.GetResource("Word_ArrowLeftBtn");
			m_btnLeft = new TempClass();
			addChild(m_btnLeft);
			m_btnLeft.x = 400;
			m_btnLeft.y = 30;
			m_btnLeft.addEventListener(MouseEvent.CLICK,OnBtnLeft);
			
			
			TempClass = GlobleData.S_pResGame.GetResource("Word_ArrowRightBtn");
			m_btnRight = new TempClass();
			addChild(m_btnRight);
			m_btnRight.x = 430;
			m_btnRight.y = 30;
			m_btnRight.addEventListener(MouseEvent.CLICK,OnBtnRight);
			
			
			m_spText = new Label();
			addChild(m_spText);
			m_spText.color = 0xffffff;
			m_spText.size = 14;
			m_spText.multiline = true;
			m_spText.wordWrap = true;
			m_spText.leading = 5;
			m_spText.indent = 22;
			m_spText.width = 400;
			m_spText.x = 30;
			m_spText.y = 50;
			
			m_spText.text = "【规则】德州牌型由大到小依次为：皇家同花顺>>同花顺>>四条>>葫芦>>同花>>顺子>>三条>>两对>>一对>>高牌";
		}
		
		public function InitWordSet(wordset:Vector.<String>):void
		{
			m_Total = wordset.length;
			m_Cur = 0;
			if( m_Total > 0 )
			{
				m_arrayWord.splice(0,m_arrayWord.length);
				m_Cur = Math.ceil(Math.random()*10000)%m_Total;
				for(var i:int=0;i<m_Total;++i)
				{
					m_arrayWord.push(wordset[i]);
				}
				m_spText.text = m_arrayWord[m_Cur];
			}
			else
			{
				GlobleFunc.LogError("InitWordSet..",m_Total);
			}
		}
		public function OnGameTime(nGameTime:int):void
		{
			if( this.visible && nGameTime-m_LastUpTime>30*1000 )
			{
				m_LastUpTime = nGameTime;
				NextWord();
			}
		}
		
		private function OnBtnRight(evt:MouseEvent):void
		{
			NextWord();
		}
		private function NextWord():void
		{
			if( m_Total>0 && this.visible )
			{
				m_LastUpTime = getTimer();
				m_Cur = (m_Cur+1)%m_Total;
				m_spText.text = m_arrayWord[m_Cur];
			}
		}
		private function OnBtnLeft(evt:MouseEvent):void
		{
			PreWord();
		}
		private function PreWord():void
		{
			if( m_Total>0 && this.visible )
			{
				m_LastUpTime = getTimer();
				m_Cur = (m_Cur-1+m_Total)%m_Total;
				m_spText.text = m_arrayWord[m_Cur];
			}			
		}
	}
}