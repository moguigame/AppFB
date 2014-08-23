package UILogic
{
	import flash.display.MovieClip;
	
	import MoGui.display.CTimeSprite;
	
	public class CSitDownMotion extends CTimeSprite
	{
		private var m_mcSitDown:MovieClip;
		public function CSitDownMotion()
		{
			super();
			
			var TempClass:Class = GlobleData.S_pResGame.GetResource("UserSelectMC");
			m_mcSitDown = new TempClass();
			addChild(m_mcSitDown);
		}
	}
}