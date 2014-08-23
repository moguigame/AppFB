package UILogic
{
	import flash.display.Sprite;
	
	import Data.Data_ChatMsg;
	
	import MoGui.display.CRectangle;
	
	import morn.core.components.ScrollBar;
	import morn.core.components.TextArea;
	
	public class CHeGuanDialog extends Sprite
	{
		private var m_tChatTextArea:TextArea;
		
		private var m_ArrayColor:Vector.<String>;
		public function CHeGuanDialog()
		{
			super();
			
			var TempBack:CRectangle = new CRectangle();
			TempBack.width = 250;
			TempBack.height = 90;
			//addChild(TempBack);
			TempBack.alpha = 0.15;
			
			m_tChatTextArea = new TextArea();
			addChild(m_tChatTextArea);
			m_tChatTextArea.scrollBarSkin = "png.comp.vscroll_00";
			m_tChatTextArea.color = 0xffffff;
			m_tChatTextArea.width = 240;
			m_tChatTextArea.height = 80;
			m_tChatTextArea.x = 5;
			m_tChatTextArea.y = 4;
			m_tChatTextArea.isHtml = true;
			
			//m_tChatTextArea.text = "123456789123456789123456789123456789\nasdfasdfasdfadf\n56464\n5454n\n\n64654\n";
			
			m_ArrayColor = new Vector.<String>;
			m_ArrayColor.push("#79a6bd");
			m_ArrayColor.push("#4fa960");
			m_ArrayColor.push("#d4bd46");
		}
		
		public function AddChatLog(msgData:Data_ChatMsg):void
		{
			//m_tChatTextArea.appendText('<font size="12" color="#000000"><b>正义的使命</b></font><br>');
			
			var ColorIdx:int = msgData.m_PID % m_ArrayColor.length;
			var AddString:String = '<font size="12" face="宋体"  color=' 
				+ '"' + m_ArrayColor[ColorIdx] + '"' + '>'
				+ msgData.m_Name + " : " + msgData.m_Msg + '</font><br>';
			
			m_tChatTextArea.appendText(AddString);
			
			var TempBar:ScrollBar = m_tChatTextArea.scrollBar;
			TempBar.value = TempBar.max;
		}
	}
}