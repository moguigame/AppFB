package UILogic
{
	import flash.display.Sprite;
	
	import morn.core.components.Image;
	
	public class CNoticeBoard extends Sprite
	{
		public var m_spBack:Image;
		
		public function CNoticeBoard()
		{
			super();			
			
			m_spBack = new Image("png.comp.Image_Back3");
			m_spBack.sizeGrid = "10,10,10,10";
			addChild(m_spBack);
			
			m_spBack.width  = 670;
			m_spBack.height = 100;
		}
	}
}