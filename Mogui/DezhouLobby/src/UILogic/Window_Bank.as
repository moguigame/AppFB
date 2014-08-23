package UILogic
{
	import flash.display.Sprite;
	
	import MoGui.display.CHideLayer;
	
	public class Window_Bank extends Sprite
	{
		private var m_back:CHideLayer;
		public var m_boxbank:Box_Bank;
		
		public function Window_Bank()
		{
			super();
			
			m_back = new CHideLayer(0x000000);
			addChild(m_back);			
			m_back.width   = PositionConfig.s_LobbyWidth;
			m_back.height  = PositionConfig.s_LobbyHeight;
			m_back.alpha = 0.5;
			
			m_boxbank = new Box_Bank();
			addChild(m_boxbank);
			m_boxbank.x = (PositionConfig.s_LobbyWidth-m_boxbank.width)/2;
			m_boxbank.y = (PositionConfig.s_LobbyHeight-m_boxbank.height)/2;
		}
	}
}