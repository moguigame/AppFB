package UILogic
{
	import MoGui.display.CText;
	import MoGui.display.CTimeSprite;
	
	public class TimeShowTishi extends CTimeSprite
	{
		public var m_tTishi:CText;
		public function TimeShowTishi()
		{
			super();
			
			m_tTishi = new CText();
			addChild(m_tTishi);
		}
	}
}