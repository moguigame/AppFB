package UILogic
{
	import flash.display.Sprite;
	
	import MoGui.display.CHideLayer;
	
	public class Window_PlayerInfo extends Sprite
	{
		private var m_back:CHideLayer;
		public var m_boxInfo:Box_PlayerInfo;
		
		public function Window_PlayerInfo()
		{
			super();
			
			m_back = new CHideLayer(0x000000);
			addChild(m_back);
			m_back.width   = PositionConfig.s_LobbyWidth;
			m_back.height  = PositionConfig.s_LobbyHeight;
			m_back.alpha = 0.5;
			
			m_boxInfo = new Box_PlayerInfo();
			addChild(m_boxInfo);
			m_boxInfo.x = (PositionConfig.s_LobbyWidth-m_boxInfo.width)/2;
			m_boxInfo.y = (PositionConfig.s_LobbyHeight-m_boxInfo.height)/2;
		}
	}
}