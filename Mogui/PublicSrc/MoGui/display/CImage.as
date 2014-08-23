package MoGui.display
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	public class CImage extends MoveSprite
	{
		var m_Bitmap:Bitmap;
		var m_BitmapData:BitmapData;
		
		public function CImage()
		{
			m_Bitmap = null;
			m_BitmapData = null;
		}
		
		public function SetImage(bd:BitmapData):void
		{
			if ( m_BitmapData != null )
			{
				m_BitmapData.dispose();
			}
			
			m_BitmapData = bd.clone();
			m_Bitmap = new Bitmap(m_BitmapData,"auto",true);
			addChild(m_Bitmap);
			
			while (this.numChildren > 1)
			{
				this.removeChildAt(0);
			}
		}
		
		public function SetSize(w:int,h:int):void
		{
			if ( m_Bitmap != null )
			{
				m_Bitmap.width  = w;
				m_Bitmap.height = h;
			}			
		}
		
		public function Clear():void
		{
			this.rotation = 0;
			while (this.numChildren > 0)
			{
				this.removeChildAt(0);
			}
		}
	}
}