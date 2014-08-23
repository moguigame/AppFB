package MoGui.display
{	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	import MoGui.events.MoguiEvent;
	
	public class CLoadImage extends Sprite
	{
		private var m_ImageLoader:Loader;
		private var m_Bitmap:Bitmap;
		private var m_BitmapData:BitmapData;
		
		private var m_bLoadPic:Boolean;           //正在加载
		private var m_bSuccess:Boolean;           //是否成功加载了照片
		private var m_strPicPath:String;          //加载照片的路径
		private var m_RetryTime:int;
		
		private var m_PicWidth:int;
		private var m_PicHeight:int;
		
		public function CLoadImage(w:int,h:int)
		{
			super();
			
			m_ImageLoader = null;
			m_Bitmap = null;
			m_BitmapData = null;
			
			m_PicWidth = 0;
			m_PicHeight = 0;			
			
			m_bLoadPic = false;
			m_bSuccess = true;
			m_strPicPath = "";
			
			m_RetryTime = 0;
			
			SetSize(w,h);			
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
		public function SetRetryTime(nTimes:int):void
		{
			if( nTimes >= 0 )
			{
				m_RetryTime = nTimes;
			}			
		}
		
		public function set url(strpath:String):void
		{
			if( strpath != "" && strpath != m_strPicPath )
			{
				SetPic(strpath);
			}
		}
		
		public function SetPic(strpath:String):void
		{
			if ( strpath == m_strPicPath )
			{
				return ;
			}
			
			m_bSuccess = false;
			m_strPicPath = strpath;			
			
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
			
			LoadImage();
		}
		
		private function LoadImage():void
		{
			m_bLoadPic = true;
			
			m_ImageLoader = new Loader();
			m_ImageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, OnLoadPicComplete);
			m_ImageLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, OnIoError);			
			try 
			{
				m_ImageLoader.load(new URLRequest(m_strPicPath),new LoaderContext(true));
			}
			catch (e:SecurityError)
			{
				m_bLoadPic = false;
				m_bSuccess = false;
			}
		}
		
		private function OnLoadPicComplete(evt:Event):void
		{			
			try
			{
               m_Bitmap = Bitmap(m_ImageLoader.content);
            }
            catch (e:SecurityError)
			{
            }
			
			this.dispatchEvent(new MoguiEvent(MoguiEvent.IMAGE_LOADED,null));
			
			addChild(m_Bitmap);
			m_Bitmap.width = this.m_PicWidth;
			m_Bitmap.height = this.m_PicHeight;
			
			while (this.numChildren > 1)
			{
				this.removeChildAt(0);
			}
			
			m_bSuccess = true;
			m_bLoadPic = false;				
		}
		
		private function OnIoError(evt:IOErrorEvent):void
		{
			trace("OnIoError:" + this.m_strPicPath);			
			
			m_bLoadPic = false;
			m_bSuccess = false;
			
			if( m_RetryTime > 0 )
			{
				--m_RetryTime;
				LoadImage();
			}
		}
	}
}