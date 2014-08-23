package MoGui.display
{
	import flash.display.Sprite;
	
	public class CRectangle extends Sprite
	{		
		public function CRectangle(color:uint = 0xffffff, w:int = 10, h:int = 10 )		
		{
			super();
			
			this.graphics.clear();
			this.graphics.beginFill( color );
			this.graphics.drawRect(0,0,w,h);
			this.graphics.endFill();
		}
	}
}