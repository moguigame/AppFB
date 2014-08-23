package MoGui.display
{
	import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.DisplayObject;
    import flash.display.Loader;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.net.URLLoader;
    import flash.net.URLLoaderDataFormat;
    import flash.net.URLRequest;
    import flash.utils.ByteArray;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.system.LoaderContext;
	import flash.events.IOErrorEvent;
	
	import MoGui.events.CLogEvent;
	
	public class CLoadImage_CrossDomain extends MoveSprite
	{
		static const ReloadTimes       = 2;
		static const Time_ReLoad       = 20;
		
		public static var s_strServerPath:String = "";
		
		var m_ImageLoader:Loader;
		var m_Bitmap:Bitmap;
		var m_BitmapData:BitmapData;
		
		var m_bReLoad:Boolean;
		var m_bLoadPic:Boolean;           //正在加载
		var m_bSuccess:Boolean;           //是否成功加载了照片
		var m_strPicPath:String;          //加载照片的路径
		
		var m_ReloadTimes:int = 0;
		var m_nToTalTimes:int;
		var m_nCurTimes:int;
		
		var m_PicWidth:int;
		var m_PicHeight:int;		
		
		public static function SetServerPath(str:String):void
		{
			s_strServerPath = str;
		}
		
		public function CLoadImage_CrossDomain(w:int,h:int,reload:Boolean=false)
		{
			super();
			
			m_ImageLoader = null;
			m_Bitmap = null;
			m_BitmapData = null;
			
			m_PicWidth = 0;
			m_PicHeight = 0;
			
			m_bReLoad = reload;
			m_ReloadTimes = 0;
			m_nToTalTimes = 0;
			m_nCurTimes = 0;
			
			m_bLoadPic = false;
			m_bSuccess = true;
			m_strPicPath = "";			
			
			SetSize(w,h);
			
			if ( m_bReLoad )
			{
				this.addEventListener(Event.ENTER_FRAME, OnEnterFrameLoadImage);
			}
		}
		
		public function SetSize(w:int,h:int):void
		{
			m_PicWidth = w;
			m_PicHeight = h;
			
			if ( m_BitmapData == null )
			{			
				m_BitmapData = new BitmapData(m_PicWidth, m_PicHeight,false);
			}
			else
			{
				m_BitmapData.dispose();
				m_BitmapData = new BitmapData(m_PicWidth, m_PicHeight,false);
			}
		}
		
		function OnEnterFrameLoadImage(evt:Event):void
		{
			if ( !m_bSuccess && m_strPicPath.length > 0 )
			{
				m_nCurTimes--;				
				if ( m_nCurTimes == 0 )
				{
					SetPic(m_strPicPath);
				}
			}
		}
		
		public function SetPic(strpath:String):void
		{	
			Log("CLoadImage_CrossDomain:" + "SetPic:" + String(m_bSuccess)+":"+String(m_bLoadPic)+":"+String(m_nToTalTimes)+":"+String(m_nCurTimes)+":"+String(s_strServerPath) + ":" + String(strpath));
			
			m_bSuccess = false;
			m_strPicPath = strpath;
			
			m_nToTalTimes = Time_ReLoad*this.stage.frameRate;
			m_nCurTimes = m_nToTalTimes;
			
			if ( m_bLoadPic )
			{
				return;
			}
			
			
			if ( m_Bitmap != null )
			{
				this.removeChild(m_Bitmap);
				m_Bitmap = null;
				m_BitmapData.dispose();
			}
			
			m_bLoadPic = true;
			
			m_ImageLoader = new Loader();
			m_ImageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, OnLoadPicComplete);
			m_ImageLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, OnIoError);
			
			try 
			{
				if ( s_strServerPath == "" )
				{
					m_ImageLoader.load(new URLRequest(m_strPicPath),new LoaderContext(true));
				}
				else
				{
					
					m_ImageLoader.load(new URLRequest(s_strServerPath+"?file="+m_strPicPath),new LoaderContext(true));
				}				
            }
            catch (e:SecurityError)
			{
                stage.dispatchEvent(new CLogEvent("error SetPic:"+String(e)));
            }
		}
		
		public function OnLoadPicComplete(evt:Event):void
		{
			Log("CLoadImage_CrossDomain:" + "OnLoadPicComplete:" + s_strServerPath+"?file=" + m_strPicPath);			
			
			try
			{
               m_Bitmap = Bitmap(m_ImageLoader.content);
            }
            catch (e:SecurityError)
			{
				Log("error OnLoadPicComplete:"+String(e));
            }
			
			addChild(m_Bitmap);			
			m_Bitmap.width = this.m_PicWidth;
			m_Bitmap.height = this.m_PicHeight;
			
			while (this.numChildren > 1)
			{
				this.removeChildAt(0);
			}
			
			m_bSuccess = true;
			m_bLoadPic = false;
			m_nCurTimes = 0;
			
			if ( m_bReLoad )
			{
				this.removeEventListener(Event.ENTER_FRAME, OnEnterFrameLoadImage);
			}		
		}
		
		public function OnIoError(evt:IOErrorEvent):void
		{
			trace("OnIoError:" + evt);			
			Log("CLoadImage_CrossDomain:"+"OnIoError:"+m_strPicPath);
			
			m_bLoadPic = false;
			m_bSuccess = false;
			
			m_ReloadTimes++;
			if ( m_ReloadTimes < ReloadTimes )
			{
				m_nCurTimes = m_nToTalTimes;
			}
			else
			{
				this.removeEventListener(Event.ENTER_FRAME, OnEnterFrameLoadImage);
			}
		}
		
		private function Log(strlog:String):void
		{
			stage.dispatchEvent(new CLogEvent(strlog));
		}
	}
}