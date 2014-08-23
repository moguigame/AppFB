package MoGui.display
{	
	public class CHideLayer extends CMoveSprite
	{		
		public function CHideLayer(color:uint = 0xffffff)
		{
			this.graphics.beginFill( color );
			this.graphics.drawRect(0,0,10,10);
			this.graphics.endFill();
		}
	}
}