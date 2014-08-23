package UILogic
{
	import flash.display.Sprite;
	import MoGui.display.CHideLayer;
	
	public class Window_CreateTable extends Sprite
	{
		private var m_back:CHideLayer;
		public var m_boxCreateTable:Box_CreateTable;
		
		public function Window_CreateTable()
		{
			super();
			
			m_back = new CHideLayer(0x000000);
			addChild(m_back);			
			m_back.width   = PositionConfig.s_LobbyWidth;
			m_back.height  = PositionConfig.s_LobbyHeight;
			m_back.alpha = 0.5;
			
			m_boxCreateTable = new Box_CreateTable();
			addChild(m_boxCreateTable);
			m_boxCreateTable.x = (PositionConfig.s_LobbyWidth-m_boxCreateTable.width)/2;
			m_boxCreateTable.y = (PositionConfig.s_LobbyHeight-m_boxCreateTable.height)/2;
		}
	}
}