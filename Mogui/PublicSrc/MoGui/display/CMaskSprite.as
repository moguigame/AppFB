package MoGui.display
{	
	public class CMaskSprite extends CMoveSprite
	{		
		public var m_Width:int;
		public var m_Height:int;
		
		public var m_Back:CRectangle;
		
		public function CMaskSprite(w:int,h:int)
		{
			m_Width = w;
			m_Height = h;
			
			m_Back = new CRectangle(0xff0000);
			addChild(m_Back);
			
			m_Back.width = w;
			m_Back.height = h;
		}
		
		public function SetSize(w:int,h:int):void
		{
			m_Width = w;
			m_Height = h;
			
			m_Back.width = w;
			m_Back.height = h;
		}
	}
}