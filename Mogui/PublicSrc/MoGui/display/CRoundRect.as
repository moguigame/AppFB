package MoGui.display
{
	//import flash.display.Sprite;
	
	public class CRoundRect extends CMoguiSprite
	{
		public function CRoundRect()
		{
			super();
		}
		
		public function Draw(color:uint = 0xffffff, w:int = 10, h:int = 10, rw:int=10, rh:int = 10):void
		{
			this.graphics.clear();
			this.graphics.beginFill( color );
			this.graphics.drawRoundRect(0,0,w,h,rw,rh);
			this.graphics.endFill();
		}
	}
}