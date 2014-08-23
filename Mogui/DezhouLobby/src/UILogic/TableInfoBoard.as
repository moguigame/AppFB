package UILogic
{
	import flash.display.Sprite;
	import MoGui.display.CText;
	
	public class TableInfoBoard extends Sprite
	{
		public var m_tName:CText;
		public var m_tBlind:CText;
		public var m_tService:CText;
		
		public function TableInfoBoard()
		{
			super();
			
			m_tName = new CText("宋体",false,0x77a7d5,12);
			addChild(m_tName);			
			m_tName.y = 5;
			m_tName.x = 5;
			
			m_tBlind = new CText("宋体",false,0x77a7d5,12);	
			addChild(m_tBlind);		
			m_tBlind.y = 23;
			m_tBlind.x = 5;
			
			m_tService = new CText("宋体",false,0x77a7d5,12);
			addChild(m_tService);
			m_tService.y = 41;
			m_tService.x = 5;
		}
		
		/*
		public function SetName(strName:String):void
		{
			m_tName.SetText("桌  子 : " + strName);
		}
		public function SetBlind(bigBlind:int,smallBlind:int):void
		{
			m_tBlind.SetText("盲  注 : " + smallBlind + "/" + bigBlind);
		}
		public function SetService(nService:int):void
		{
			m_tService.SetText("服务费 : " + nService);
		}
		*/
	}
}