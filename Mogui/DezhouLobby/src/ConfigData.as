package
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class ConfigData extends EventDispatcher
	{
		public var m_strCDNPath:String;
		
		public var m_LobbySwf:String;
		public var m_LobbyVer:String;
		
		public var m_ServerIP:String;
		public var m_ServerPort:int;
		
		public var m_LobbyRes:String;
		public var m_LobbyResVer:String;
		
		public var m_GameRes:String;
		public var m_GameResVer:String;
		
		public static var m_GameConfigRes:String;
		public static var m_GameConfigVer:String;
		
		public static var m_TabFlag:int;
		public static var m_TabPlace:int;
		
		public function ConfigData()
		{
			m_strCDNPath = "";
		}
		public function StartLoad():void
		{
			var TempInfoLoad:URLLoader = new URLLoader();
			TempInfoLoad.load(new URLRequest("dezhou_config.xml?"+Math.random()));
			TempInfoLoad.addEventListener(Event.COMPLETE, OnLoadXMLComplete);
		}
		
		private function OnLoadXMLComplete(evt:Event):void
		{
			trace("ConfigData OnLoadXMLComplete");
			
			var loader:URLLoader = evt.target as URLLoader;
			if (loader != null)
			{
				var tempXML:XML = new XML(loader.data);	
				
				//trace(tempXML);
				
				m_strCDNPath = tempXML.CDN;
				
				m_LobbySwf = tempXML.Loader.lobbySwf;
				m_LobbyVer = tempXML.Loader.lobbySwf.attribute("version");
				trace(m_LobbySwf,m_LobbyVer);
				
				m_ServerIP   = tempXML.Game.ServerAddr.attribute("IP");
				m_ServerPort = tempXML.Game.ServerAddr.attribute("Port");
				trace(m_ServerIP,m_ServerPort);
				
				m_TabFlag   = tempXML.Lobby.Tab.attribute("Flag");
				m_TabPlace  = tempXML.Lobby.Tab.attribute("Place");
				trace(m_TabFlag,m_TabPlace);
				
				m_LobbyRes    = tempXML.Res.LobbyRes;
				m_LobbyResVer = tempXML.Res.LobbyRes.attribute("version");
				trace(m_LobbyRes,m_LobbyResVer);
				
				m_GameRes    = tempXML.Res.GameRes;
				m_GameResVer = tempXML.Res.GameRes.attribute("version");
				trace(m_GameRes,m_GameResVer);
				
				m_GameConfigRes = tempXML.Res.GameConfig;
				m_GameConfigVer = tempXML.Res.GameConfig.attribute("version");
				trace(m_GameConfigRes,m_GameConfigVer);
				
				this.dispatchEvent(evt);
			}
		}
	}
}