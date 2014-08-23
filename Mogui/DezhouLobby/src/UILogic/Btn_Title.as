package UILogic
{
	import flash.display.Sprite;
	
	import morn.core.components.Button;
	import morn.core.components.Clip;
	
	public class Btn_Title extends Sprite
	{
		public var m_btnBack:Button;
		public var m_btnClip:Clip;
		
		public function Btn_Title(btnString:String)
		{
			super();
			
			m_btnBack = new Button("png.comp.button_titleback","");
			this.addChild(m_btnBack);
			
			m_btnClip = new Clip("png.comp." + btnString );
			this.addChild(m_btnClip);
			m_btnClip.x = 5;
			m_btnClip.y = 5;
		}
	}
}