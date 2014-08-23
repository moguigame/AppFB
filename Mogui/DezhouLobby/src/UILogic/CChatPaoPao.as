package UILogic
{	
	import MoGui.display.CTimeSprite;
	
	import morn.core.components.Image;
	import morn.core.components.TextArea;
	
	public class CChatPaoPao extends CTimeSprite
	{
		public static const Type_Down:int  = 1;
		public static const Type_Up:int    = 2;
		
		public var m_spBack:Image;
		public var m_spArrow:Image;
		public var m_Type:int;
		
		public var m_ChatText:TextArea;
		
		public function CChatPaoPao(nType:int)
		{
			super();
			
			m_Type = nType;			
			
			m_spBack = new Image("png.comp.image_chat_bk");
			addChild(m_spBack);
			m_spBack.sizeGrid = "20,20,20,20";
			m_spBack.width = 140;
			m_spBack.height = 47;
			
			m_ChatText = new TextArea();
			addChild(m_ChatText);
			m_ChatText.width = 135;
			m_ChatText.height = 40;
			
			if( m_Type == Type_Down ){
				m_spArrow = new Image("png.comp.image_chat_down");
				addChild(m_spArrow);
				m_spArrow.x = 62;
				m_spArrow.y = 47;
				
				m_ChatText.x = 5;
				m_ChatText.y = 4;
			}
			else {
				m_spArrow = new Image("png.comp.image_chat_up");
				addChild(m_spArrow);
				m_spArrow.x = 62;
				m_spArrow.y = 0;
				m_spBack.y = 7;
				
				m_ChatText.x = 5;
				m_ChatText.y = 11;
			}
			
			m_ChatText.text = "2845029845298459824-985248524582452-394852-34985-";
		}
		
		public function ShowChatMsg(str:String,nTime:int):void{
			m_ChatText.text = str;
			ShowTime(nTime);
		}
	}
}