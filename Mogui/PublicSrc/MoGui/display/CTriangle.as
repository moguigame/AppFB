package MoGui.display
{
	import flash.display.Sprite;
	
	public class CTriangle extends MoveSprite
	{		
		public function CTriangle(color:uint = 0xffffff)
		{
			this.graphics.beginFill( color );
			this.graphics.lineTo(0, 0);
			this.graphics.lineTo(10, 0);
			this.graphics.lineTo(10, 10);
			this.graphics.lineTo(0,0);
			this.graphics.endFill();
		}
	}
}

