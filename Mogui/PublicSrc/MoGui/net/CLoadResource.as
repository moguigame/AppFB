package MoGui.net
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;

	//主要用于存放各种资源，比如图片，声音，皮肤等
	public class CLoadResource extends EventDispatcher
	{
		private var m_bInitOK:Boolean;
		private var m_RepeatTime:int;
		private var m_ResPath:String;
		private var m_Version:String;
		private var m_LoadResource:LoaderInfo;
		
		public function CLoadResource(path:String,ver:String,repeat:int=1)
		{
			m_bInitOK = false;
			
			m_ResPath = path;
			m_Version = ver;
			m_RepeatTime = repeat;
			
			StartLoadRes();
		}
		public function GetResource(str:String):Class
		{
			return m_LoadResource.applicationDomain.getDefinition(str) as Class;
		}
		public function GetResSprite(str:String):Sprite
		{
			var TempClass:Class = m_LoadResource.applicationDomain.getDefinition(str) as Class;
			return new TempClass();
		}
		public function get InitOK():Boolean
		{
			return m_bInitOK;
		}
		
		private function StartLoadRes():void
		{
			m_bInitOK = false;
			var ResLoader:Loader = new Loader();
			var context:LoaderContext = new LoaderContext();
			context.applicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
			ResLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,LoadResComplete);
			ResLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,LoadResError);			
			ResLoader.load(new URLRequest(m_ResPath+"?"+m_Version),context);
		}
		
		private function LoadResComplete(evt:Event):void
		{
			(evt.target as LoaderInfo).removeEventListener(Event.COMPLETE,LoadResComplete);
			(evt.target as LoaderInfo).removeEventListener(IOErrorEvent.IO_ERROR,LoadResError);
			m_LoadResource = evt.target as LoaderInfo;
			this.dispatchEvent(evt);
		}
		private function LoadResError(e:Event):void
		{
			if( m_RepeatTime > 0 )
			{
				m_RepeatTime--;
				StartLoadRes();
			}
		}
	}
}