package
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import Data.Data_FaceInfo;
	import Data.Data_QuickChat;
	
	public class GameConfig extends EventDispatcher
	{
		public var m_PlayerTailTime:int;
		
		public var m_arrayWordSet:Vector.<String>;
		public var m_arrayFastChat:Vector.<Data_QuickChat>;
		public var m_arrayFaceInfo:Vector.<Data_FaceInfo>;
		
		public function GameConfig()
		{
			m_PlayerTailTime = 500;
			
			m_arrayWordSet = new Vector.<String>();
			m_arrayFastChat = new Vector.<Data_QuickChat>();
			m_arrayFaceInfo = new Vector.<Data_FaceInfo>();
			
			var TempInfoLoad:URLLoader = new URLLoader();
			TempInfoLoad.load(new URLRequest(ConfigData.m_GameConfigRes+"?"+ConfigData.m_GameConfigVer));
			TempInfoLoad.addEventListener(Event.COMPLETE, OnLoadXMLComplete);
		}
		
		private function OnLoadXMLComplete(evt:Event):void
		{
			trace("GameConfig OnLoadXMLComplete");
			
			var loader:URLLoader = evt.target as URLLoader;
			if (loader != null)
			{
				var tempXML:XML = new XML(loader.data );
				
				m_PlayerTailTime = tempXML.GameConfig.PlayerTailTime;
				
				var item:Object;				
				for each( item in tempXML.WordsSet.Words)
				{
					m_arrayWordSet.push(item);
				}
				for each( item in tempXML.FastChat.Chat )
				{
					var datQC:Data_QuickChat = new Data_QuickChat();
					datQC.m_Chat   = String(item);
					datQC.m_Idx    = int(item.attribute("Idx"));
					m_arrayFastChat.push(datQC);
				}
				for each( item in tempXML.FaceInfo.Face )
				{
					var dataFI:Data_FaceInfo = new Data_FaceInfo();
					dataFI.m_FaceID      = int(item.attribute("id"));
					dataFI.m_FaceName    = item.attribute("info");
					m_arrayFaceInfo.push(dataFI);
				}
				
				var nLeft:int;
				var nRight:int;
				var TempStr:String;
				for(var nCount:int=0;nCount<1000;++nCount)
				{
					nLeft = (Math.random()*100000)%m_arrayWordSet.length;
					nRight = (Math.random()*100000)%m_arrayWordSet.length;
					
					TempStr = m_arrayWordSet[nLeft];
					m_arrayWordSet[nLeft] = m_arrayWordSet[nRight];
					m_arrayWordSet[nRight] = TempStr;					
				}
				
				this.dispatchEvent(evt);
			}
		}
		
		public function GetWordByIdx(nIdx:int):String
		{
			var strRet:String = "";
			for(var i:int=0;i<m_arrayFastChat.length;++i)
			{
				if( nIdx == m_arrayFastChat[i].m_Idx )
				{
					strRet = m_arrayFastChat[i].m_Chat;
					break;
				}
			}
			return strRet;
		}
	}
}