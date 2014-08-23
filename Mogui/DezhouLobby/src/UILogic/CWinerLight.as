package UILogic
{
	import flash.display.MovieClip;
	//import flash.display.Sprite;
	import MoGui.display.CTimeSprite;
	
	public class CWinerLight extends CTimeSprite
	{
		public var m_spLight:MovieClip;
		
		public function CWinerLight()
		{
			super();
			
			var TempClass:Class = GlobleData.S_pResGame.GetResource("WinerLight");
			m_spLight = new TempClass();
			addChild(m_spLight);
		}
		
		public function Play():void
		{
			this.visible = true;
			m_spLight.gotoAndPlay(1);
			
			ShowTime(1000);
		}
	}
}