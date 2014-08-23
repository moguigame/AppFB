package  
{
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;

	public class Logger
	{
		public static var logFlag:Boolean=true;//可输出日志.默认为开,flase为不输出日志
		
		public static const CONNECT_NAME_LOGGERIN:String = "_york_Logger_In";
		public static const CONNECT_NAME_LOGGEROUT:String = "_york_Logger_Out";
		
		//日志的最大数目：能存放多少句话。
		public static var MAX_LOG_COUNT:int = 500;
		
		//实例。本类为单例模式。
		private static var _instance:Logger;
		
		//本地连接对象。
		private var _lc:LocalConnection;
		//存储调试信息
		private var _msgs:Array;
		
		/**
		 * 构造函数。
		 */
		public function Logger() {
			_msgs = new Array();
			_lc = new LocalConnection();
			_lc.client = this;
			_lc.addEventListener(StatusEvent.STATUS, onStatus);
			_lc.allowDomain("*");
			try {
				_lc.connect(CONNECT_NAME_LOGGERIN);
			}catch(e:ArgumentError) {
				//trace(e);
			}
		}
		
		private function onStatus(event:StatusEvent):void {
			switch (event.level) {
				case "status":
					//trace("LocalConnection.send() succeeded");
					break;
				case "error":
					//trace("LocalConnection.send() failed");
					break;
			}
		}
		
		private static function getInstance():Logger {
			if(!_instance) 
			{
				_instance = new Logger();
			}
			return _instance;
		}
		
		public static function log(...parment):void
		{
			if(logFlag){
				var tObj:Array=new Array();
				tObj.push(new Date().toLocaleTimeString());
				tObj.push(parment);
				var ins:Logger = getInstance();
				var msg:Object = {content:tObj, type:"info", source:null};
				ins._lc.send(CONNECT_NAME_LOGGEROUT, "log", msg);
				//记录消息。
				ins._msgs.push(msg);
				//记录的消息个数有上限。
				if (ins._msgs.length > MAX_LOG_COUNT) {
					ins._msgs.shift();
				}
			}
		}
		
		/**
		 * private
		 * 此函数提供给 控制台显示器使用。
		 * 提供给外部的回调。用于一次性获取所有的日志信息。日志显示器通常在开始会掉用此函数，
		 * 因为日志显示程序有可能在程序执行之后才打开，这样可以先调用一次getLogs()来获取已经
		 * 打印的日志信息。
		 */
		public function getLogs():void {
			var ins:Logger = getInstance();
			ins._lc.send(CONNECT_NAME_LOGGEROUT, "log", msgs);
		}
		
		/**
		 * 获取日志信息。
		 */
		private static function get msgs():Array {
			var ins:Logger = getInstance();
			return (ins._msgs);
		}
	}
}