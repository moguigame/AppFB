package UILogic
{
	import flash.display.Sprite;
	import MoGui.display.CMotionSprite;
	
	public class CSpriteWin extends CMotionSprite
	{
		public var m_spBack:Sprite;
		
		public function CSpriteWin()
		{
			super();
			
			var TempClass:Class;			
			TempClass = GlobleData.S_pResGame.GetResource("YouWin");
			m_spBack = new TempClass();
			addChild(m_spBack);
		}
	}
}