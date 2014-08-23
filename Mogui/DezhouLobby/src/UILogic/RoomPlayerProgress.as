package UILogic
{
	import flash.display.Sprite;
	
	import morn.core.components.Image;
	
	public class RoomPlayerProgress extends Sprite
	{
		public var m_spBack:Image;
		public var m_spProgressBlue:Image;
		public var m_spProgressRed:Image;
		
		public function RoomPlayerProgress()
		{
			super();
			
			m_spBack = new Image("png.comp.progress_back");
			addChild(m_spBack);
			m_spBack.sizeGrid = "3,2,3,2";
			m_spBack.width = 80;
			m_spBack.height = 10;
			
			m_spProgressBlue = new Image("png.comp.progrss_blue");
			addChild(m_spProgressBlue);
			m_spProgressBlue.sizeGrid = "3,2,3,2";
			m_spProgressBlue.height = 8;
			m_spProgressBlue.x = 2;
			m_spProgressBlue.y = 0.5;
			
			m_spProgressRed = new Image("png.comp.progress_red");
			addChild(m_spProgressRed);
			m_spProgressRed.sizeGrid = "3,2,3,2";
			m_spProgressRed.height = 8;
			m_spProgressRed.x = 2;
			m_spProgressRed.y = 0.5;
		}
		
		public function SetProgress(nTotal:int,nCur:int):void
		{
			if( nCur < 7 )
			{
				m_spProgressBlue.visible = true;
				m_spProgressRed.visible = false;
				m_spProgressBlue.width = 77*nCur/nTotal;
			}
			else
			{
				m_spProgressBlue.visible = false;
				m_spProgressRed.visible = true;	
				m_spProgressRed.width = 77*nCur/nTotal;
			}			
		}
	}
}