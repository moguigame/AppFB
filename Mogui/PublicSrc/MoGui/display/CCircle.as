package MoGui.display
{
	import flash.display.Sprite;
	
	public class CCircle extends MoveSprite
	{		
		public function CCircle(color:uint = 0xffffff)
		{
			this.graphics.beginFill( color );
			this.graphics.drawCircle(0, 0, 10);
			this.graphics.endFill();
		}
	}
}