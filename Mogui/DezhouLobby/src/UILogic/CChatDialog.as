package UILogic
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import Data.Data_ChatMsg;
	import Data.Data_QuickChat;
	
	import L2C.S2C_Flag;
	import L2C.S2C_TableChatMsg;
	
	import MoGui.display.CRectangle;
	import MoGui.utils.CFunction;
	
	import morn.core.components.ScrollBar;
	import morn.core.components.TextArea;
	import morn.core.components.TextInput;
	
	public class CChatDialog extends Sprite
	{
		private var m_arrayQuickChat:Array;
		
		private var m_tChatList:TextArea;
		private var m_btnChatEnter:SimpleButton;
		private var m_btnQuickChat:SimpleButton;
		private var m_tChatInput:TextInput;
		private var m_spQuickBack:Sprite;
		private var m_listWords:List_ChatWord;
		
		private var m_ArrayColor:Vector.<String>;
		
		public function CChatDialog()
		{
			super();
			
			m_arrayQuickChat = new Array();
			
			var TempBack:CRectangle = new CRectangle();
			TempBack.width = 280;
			TempBack.height = 130;
			//addChild(TempBack);
			TempBack.alpha = 0.15;
			
			var TempClass:Class;
			
			TempClass = GlobleData.S_pResGame.GetResource("ChatEnterBtn");
			m_btnChatEnter = new TempClass();
			//addChild(m_btnChatEnter);
			m_btnChatEnter.x = 210;
			m_btnChatEnter.y = 14;
			//m_btnChatEnter.addEventListener(MouseEvent.CLICK,OnChatEnter);
			
			m_tChatInput = new TextInput();
			addChild(m_tChatInput);
			m_tChatInput.size = 14;
			m_tChatInput.color = "0xffffff";
			//m_tChatInput.text = "123456789123456789123456789123456789";
			m_tChatInput.width = 220;
			m_tChatInput.x = 7;
			m_tChatInput.y = 16;
			m_tChatInput.addEventListener(KeyboardEvent.KEY_DOWN,OnKeyDown);
			
			TempClass = GlobleData.S_pResGame.GetResource("FastChatSmallBtn");
			m_btnQuickChat = new TempClass();
			addChild(m_btnQuickChat);
			m_btnQuickChat.x = 226;
			m_btnQuickChat.y = 17;
			m_btnQuickChat.addEventListener(MouseEvent.CLICK,OnBtnQuckChat);
			
			
			TempClass = GlobleData.S_pResGame.GetResource("FastChatBg");
			m_spQuickBack = new TempClass();
			addChild(m_spQuickBack);
			m_spQuickBack.x = 4;
			m_spQuickBack.y = -186;
			
			m_listWords = new List_ChatWord(9);
			addChild(m_listWords);
			m_listWords.x = 10;
			m_listWords.y = -175;
			m_listWords.addEventListener(Event.SELECT,OnSelectWord);
			
			m_listWords.m_nSelectIdx = 0;
			m_listWords.visible = false;
			m_spQuickBack.visible = false;			
			
			
			m_tChatList = new TextArea();
			addChild(m_tChatList);
			m_tChatList.scrollBarSkin = "png.comp.vscroll_00";
			m_tChatList.color = 0xffffff;
			m_tChatList.width = 240;
			m_tChatList.height = 80;
			m_tChatList.x = 5;
			m_tChatList.y = 40;
			m_tChatList.isHtml = true;
			
			//m_tChatList.text = "123456789123456789123456789123456789\nasdfasdfasdfadf\n56464\n5454n\n\n64654\n";			
			
			m_ArrayColor = new Vector.<String>;
			m_ArrayColor.push("#79a6bd");
			m_ArrayColor.push("#4fa960");
			m_ArrayColor.push("#d4bd46");
			m_ArrayColor.push("#ff9900");
		}
		
		private function OnSelectWord(evt:Event):void
		{
			m_listWords.visible = false;
			m_spQuickBack.visible = false;
			
			if( m_listWords.m_nSelectIdx )
			{
				var msgFlag:S2C_Flag = new S2C_Flag();
				msgFlag.m_Flag        = S2C_Flag.QuickChat;
				msgFlag.m_Value       = m_listWords.m_nSelectIdx;
				GlobleFunc.SendStageToClient(stage,msgFlag);
			}			
		}
		
		private function OnKeyDown(evt:KeyboardEvent):void
		{
			if( evt.keyCode == 13 )
			{
				var strChatMsg:String = m_tChatInput.text;
				if( strChatMsg.length>0 && strChatMsg!="" )
				{
					strChatMsg = CFunction.GetPartStr(strChatMsg,50);
					
					var msgChat:S2C_TableChatMsg = new S2C_TableChatMsg();
					msgChat.m_ChatMsg = strChatMsg;
					GlobleFunc.SendStageToClient(stage,msgChat);
				}				
				m_tChatInput.text = "";
			}
		}
		
		public function InitQuickChat(vectorQC:Vector.<Data_QuickChat>):void
		{
			if( vectorQC.length )
			{
				if( m_arrayQuickChat.length )
				{
					m_arrayQuickChat.splice(0,m_arrayQuickChat.length);
				}
				for(var i:int=0;i<vectorQC.length;++i)
				{
					m_arrayQuickChat.push(vectorQC[i]);
				}
				m_listWords.dataSource = m_arrayQuickChat;
			}
		}
		
		public function OnChatEnter(evt:MouseEvent):void
		{
			var strChatMsg:String = m_tChatInput.text;
			if( strChatMsg.length>0 && strChatMsg!="" )
			{
				strChatMsg = CFunction.GetPartStr(strChatMsg,50);
				
				var msgChat:S2C_TableChatMsg = new S2C_TableChatMsg();
				msgChat.m_ChatMsg = strChatMsg;
				GlobleFunc.SendStageToClient(stage,msgChat);
			}
			m_tChatInput.text = "";
		}
		public function OnBtnQuckChat(evt:MouseEvent):void
		{
			m_listWords.m_nSelectIdx = 0;
			if( m_listWords.visible && m_spQuickBack.visible )
			{
				ShowWordList(false);				
			}
			else
			{
				ShowWordList(true);
				
				var msgFlag:S2C_Flag = new S2C_Flag();
				msgFlag.m_Flag        = S2C_Flag.ShowWordList;
				msgFlag.m_Value       = 0;
				GlobleFunc.SendStageToClient(stage,msgFlag);
			}			
		}
		public function ShowWordList(bShow:Boolean):void
		{
			m_listWords.visible = bShow;
			m_spQuickBack.visible = bShow;
		}
		public function AddChatLog(msgData:Data_ChatMsg):void
		{
			//m_tChatList.appendText('<font size="12" color="#000000"><b>正义的使命</b></font><br>');
			
			var ColorIdx:int = msgData.m_PID % m_ArrayColor.length;
			var AddString:String = '<font size="12" face="宋体"  color=' 
				+ '"' + m_ArrayColor[ColorIdx] + '"' + '>'
				+ msgData.m_Name + " : " + msgData.m_Msg + '</font><br>';
			
			m_tChatList.appendText(AddString);			
			
			var TempBar:ScrollBar = m_tChatList.scrollBar;
			TempBar.value = TempBar.max;
		}
	}
}