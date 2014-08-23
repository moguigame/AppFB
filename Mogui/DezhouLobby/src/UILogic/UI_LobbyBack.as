package UILogic
{
	import flash.display.Sprite;
	
	import morn.core.components.Image;
	
	public class UI_LobbyBack extends Sprite
	{
		public function UI_LobbyBack()
		{
			super();
			
			var smallImage:Image = new Image("jpg.comp.Image_lobbyback");			
			graphics.beginBitmapFill(smallImage.bitmapData);
			graphics.drawRect(0, 0, 1000, 620);
			graphics.endFill();
		}
	}
}