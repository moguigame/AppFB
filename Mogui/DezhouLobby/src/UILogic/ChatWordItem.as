package UILogic
{
	import flash.display.Sprite;
	
	import Data.Data_QuickChat;
	
	import morn.core.components.Component;
	import morn.core.components.Label;
	
	public class ChatWordItem extends Component
	{		
		public var m_spOver:Sprite;
		
		public var m_Idx:int;
		public var m_tChatWord:Label;
		
		public function ChatWordItem()
		{
			super();
			
			m_Idx = 0;
			
			var TempClass:Class;
			TempClass = GlobleData.S_pResGame.GetResource("QuickChatBack");
			m_spOver = new TempClass();
			addChild(m_spOver);
			m_spOver.width = 215;
			m_spOver.height = 20;
			
			m_tChatWord = new Label();
			addChild(m_tChatWord);
			m_tChatWord.color = "0xffffff";
		}
		
		public function SetSize(nW:Number,nH:Number):void
		{
			m_spOver.width = nW;
			m_spOver.height = nH;
		}
		
		public function SetChatWord(dataQC:Data_QuickChat):void
		{
			m_Idx            = dataQC.m_Idx;
			m_tChatWord.text = dataQC.m_Chat;
		}
	}
}