package MoGui.display
{
	import flash.events.Event;
	
	public class CTextNumber extends CMoguiSprite
	{
		var m_bMotion:Boolean;
		
		var m_nCurNumber:int;
		var m_nDesNumber:int;
		
		var m_Step:Number;
		var m_strHead:String;
		
		public function CTextNumber(head:String="")
		{
			m_bMotion = false;
			m_strHead = head;
			
			this.addEventListener(Event.ENTER_FRAME, OnTextNumberEnterFrame);
		}
		
		public function GoTo(nDes:int,nframe:Number):void
		{
			if ( nframe > 1 )
			{
				m_bMotion = true;
				m_nDesNumber = nDes;
				
				m_Step = (m_nDesNumber - m_nCurNumber) / nframe;
				
				if ( Math.abs(m_Step) <= 1 )
				{
					SetNumber(m_nDesNumber);
					m_bMotion = false;
				}
			}
			else
			{
				SetNumber(nDes);
			}
		}
		
		public function GetNumber():int
		{
			if ( m_bMotion )
			{
				return m_nDesNumber;
			}
			return m_nCurNumber;
		}
		
		public function SetNumber(nm:int):void
		{
			m_nCurNumber = nm;
			
			SetText(m_strHead+String(nm));			
		}
		
		function OnTextNumberEnterFrame(evt:Event):void
		{
			if ( !m_bMotion )
			{
				return;
			}
			
			m_nCurNumber += m_Step;
			
			if ( (m_Step >= 0 && m_nCurNumber >= m_nDesNumber)
				  || (m_Step <= 0 && m_nCurNumber <= m_nDesNumber) )
			{
				m_bMotion = false;
				m_nCurNumber = m_nDesNumber;
			}
			
			SetNumber(m_nCurNumber);
		}
	}
}