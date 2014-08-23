package UILogic
{
	import flash.display.Sprite;
	import MoGui.display.CHideLayer;
	
	public class Window_Shop extends Sprite
	{
		private var m_back:CHideLayer;
		public var m_boxShop:Box_Shop;
		
		public function Window_Shop()
		{
			super();
			
			m_back = new CHideLayer(0x000000);
			addChild(m_back);
			m_back.width   = PositionConfig.s_LobbyWidth;
			m_back.height  = PositionConfig.s_LobbyHeight;
			m_back.alpha = 0.5;
			
			m_boxShop = new Box_Shop();
			addChild(m_boxShop);
			m_boxShop.x = (PositionConfig.s_LobbyWidth-m_boxShop.width)/2;
			m_boxShop.y = (PositionConfig.s_LobbyHeight-m_boxShop.height)/2;
		}
	}
}