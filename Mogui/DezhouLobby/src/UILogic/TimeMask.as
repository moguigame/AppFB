package UILogic
{
	import MoGui.display.CRectangle;
	import MoGui.display.CTimeSprite;
	
	public class TimeMask extends CTimeSprite
	{
		public var m_mask:CRectangle;
		public function TimeMask(w:int,h:int)
		{
			super();
			
			m_mask = new CRectangle(0x000000,w,h);
			addChild(m_mask);
		}
	}
}