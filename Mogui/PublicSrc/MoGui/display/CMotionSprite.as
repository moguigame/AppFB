package MoGui.display
{
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	public class CMotionSprite extends CMoguiSprite
	{
		public static var MOTION_NONE:int            = 0;
		public static var MOTION_HIDE:int            = 1;//隐藏
		public static var MOTION_SHOW:int            = 2;//隐藏
		
		public static var FLAG_HIDE:int              = 1;//隐藏
		public static var FLAG_SHOW:int              = 2;//隐藏
		
		//移动
		private var m_bMoveByCenter:Boolean;
		private var m_OrigX:int;                     //出发地及目标地坐标
		private var m_OrigY:int;
		private var m_DesX:int;
		private var m_DesY:int;
		private var m_TotalMoveFrame:int;            //移动总帧数
		private var m_CurMoveFrame:int;              //当前帧数
		public  var m_funcStartMove:Function;
		public  var m_funcEndMove:Function;
		
		//缩放
		private var m_bScaleInCenter:Boolean;        //是否以中心点为放大
		private var m_ptScaleCenter:Point;                //中心点的位置
		private var m_OrigScaleX:Number;             //原始缩放值
		private var m_OrigScaleY:Number;             //原始缩放值
		private var m_DesScaleX:Number;
		private var m_DesScaleY:Number;
		private var m_TotalScaleFrame:int;           //移动总帧数
		private var m_CurScaleFrame:int;             //当前帧数
		public  var m_funcStartScale:Function;
		public  var m_funcEndScale:Function;
		
		//隐藏
		private var m_ShowHideFlag:int;
		private var m_OrigAlpha:Number;              //原始缩放值
		private var m_DesAlpha:Number;		
		private var m_TotalAlphaFrame:int;           //移动总帧数
		private var m_CurAlphaFrame:int;             //当前帧数
		public  var m_funcStartShowHide:Function;
		public  var m_funcEndShowHide:Function;
		
		//定时隐藏
		public var m_StartTime:int;
		public var m_LastTime:int;
		
		public var m_funPreShow:Function;
		public var m_funEndShow:Function;
		
		public function CMotionSprite()
		{
			super();
			
			m_funcEnterFrame = OnMotionEnterFrame;
			
			m_bMoveByCenter = false;
			m_TotalMoveFrame = 0;
			m_CurMoveFrame = 0;
			m_funcStartMove = null;
			m_funcEndMove = null;
			
			m_bScaleInCenter = false;
			m_ptScaleCenter = new Point(0,0);
			m_TotalScaleFrame = 0;
			m_CurScaleFrame = 0;
			m_funcStartScale = null;
			m_funcEndScale = null;
			
			m_ShowHideFlag = 0;
			m_TotalAlphaFrame = 0;
			m_CurAlphaFrame = 0;
			m_funcStartShowHide = null;
			m_funcEndShowHide = null;
			
			m_StartTime = 0;
			m_LastTime = 0;
			
			m_funPreShow = null;
			m_funEndShow = null;
		}
		
		public function ShowByTime(nTime:Number):void
		{
			if( this.stage != null )
			{
				var nFrame:int = this.stage.frameRate * nTime;
				if( nFrame > 0 )
				{
					m_ShowHideFlag = FLAG_SHOW;
					m_OrigAlpha = 0;
					m_DesAlpha = 1;
					
					m_TotalAlphaFrame = nFrame;
					m_CurAlphaFrame = 0;
				}
			}
		}
		public function HideByTime(nTime:Number):void
		{
			if( this.stage != null )
			{
				var nFrame:int = this.stage.frameRate * nTime;
				if( nFrame > 0 )
				{
					m_ShowHideFlag = FLAG_HIDE;
					m_OrigAlpha = 1;
					m_DesAlpha = 0;
					
					m_TotalAlphaFrame = nFrame;
					m_CurAlphaFrame = 0;
				}
			}
		}
		public function MoveToPointByTime(pt:Point,ntime:Number):void
		{
			m_bMoveByCenter = false;
			
			if( this.stage != null )
			{
				var nFrame:int = this.stage.frameRate * ntime;
				if( nFrame > 0 )
				{
					if( m_funcStartMove != null )
					{
						m_funcStartMove.call();
					}
					
					m_OrigX = this.x;
					m_OrigY = this.y;
					m_DesX = pt.x;
					m_DesY = pt.y;
					
					m_TotalMoveFrame = nFrame;
					m_CurMoveFrame = 0;
				}
			}
		}
		public function MoveCenterByTime(pt:Point,ntime:Number):void
		{
			if( this.stage != null )
			{
				var nFrame:int = this.stage.frameRate * ntime;
				if( nFrame > 0 )
				{
					m_bMoveByCenter = true;
					
					if( m_funcStartMove != null )
					{
						m_funcStartMove.call();
					}
					
					var TempPt:Point = this.GetCenterPt();
					
					m_OrigX = TempPt.x;
					m_OrigY = TempPt.y;
					m_DesX = pt.x;
					m_DesY = pt.y;
					
					m_TotalMoveFrame = nFrame;
					m_CurMoveFrame = 0;
				}
			}
		}
		public function SetScaleCenter(pt:Point):void
		{
			m_ptScaleCenter.x = pt.x;
			m_ptScaleCenter.y = pt.y;
		}
		public function ScaleByTime(desScaleX:Number,desScaleY:Number,ntime:Number,bCenter:Boolean=false):void
		{
			if( this.stage != null )
			{
				var nFrame:int = this.stage.frameRate * ntime;
				if( nFrame > 0 )
				{
					if( m_funcStartScale != null )
					{
						m_funcStartScale.call();
					}
					
					m_bScaleInCenter = bCenter;
					
					m_OrigScaleX = this.scaleX;
					m_OrigScaleY = this.scaleY;
					m_DesScaleX  = desScaleX;
					m_DesScaleY  = desScaleY;
					
					m_TotalScaleFrame = nFrame;
					m_CurScaleFrame = 0;
				}
			}
		}
		public function ShowTime(nLastTime:Number):void
		{
			if( nLastTime > 0 )
			{
				this.visible = true;
				m_StartTime = getTimer();
				m_LastTime = nLastTime;
				
				if( m_funPreShow )
				{
					m_funPreShow.call();
				}
			}
		}
		public function EndMoving(bAuto:Boolean=false):void
		{
			if( m_TotalMoveFrame>0 )
			{
				this.x = m_DesX;
				this.y = m_DesY;
				
				m_TotalMoveFrame = 0;
				m_CurMoveFrame = 0;
				
				if( m_funcEndMove!=null && bAuto )
				{
					m_funcEndMove.call();
				}
			}
		}
		public function EndScale(bAuto:Boolean=false):void
		{			
			if( m_TotalScaleFrame>0 )
			{
				this.scaleX = m_DesScaleX;
				this.scaleY = m_DesScaleY;
				
				if( m_bScaleInCenter )
				{
					CenterByPoint(m_ptScaleCenter);
				}
				
				m_TotalScaleFrame = 0;
				m_CurScaleFrame = 0;
				
				if( m_funcEndScale!=null && bAuto )
				{
					m_funcEndScale.call();
				}
			}
		}
		public function EndShowHide(bAuto:Boolean=false):void
		{
			if ( m_TotalAlphaFrame>0 )
			{
				if( m_ShowHideFlag == FLAG_HIDE )
				{
					this.visible = false;
				}
				else if( m_ShowHideFlag == FLAG_SHOW )
				{
					this.visible = true;
				}
				this.alpha = 1;
				m_CurAlphaFrame = 0;
				m_TotalAlphaFrame = 0;
				
				if( m_funcEndShowHide!=null && bAuto )
				{
					m_funcEndShowHide.call();
				}
			}
		}
		public function OnTime(nTime:int):void
		{
			if( m_StartTime>0 && m_LastTime>0 && nTime>=m_StartTime+m_LastTime )
			{
				this.visible = false;
				
				m_StartTime = 0;
				m_LastTime = 0;
				
				if( m_funEndShow )
				{
					m_funEndShow.call();
				}
			}
		}
		public function OnMotionEnterFrame():void
		{
			var percent:Number;
			if( m_TotalMoveFrame>0 )
			{
				m_CurMoveFrame++;
				percent = (1.0 * m_CurMoveFrame) / (m_TotalMoveFrame * 1.0);
				
				if ( m_CurMoveFrame >= m_TotalMoveFrame )
				{
					EndMoving(true);
				}
				else if ( m_CurMoveFrame > 0 && m_CurMoveFrame < m_TotalMoveFrame)
				{
					var TempX:int = m_OrigX + (m_DesX - m_OrigX) * percent;
					var TempY:int = m_OrigY + (m_DesY - m_OrigY) * percent;
					if( m_bMoveByCenter )
					{
						this.CenterXByX(TempX);
						this.CenterYByY(TempY);
					}
					else
					{
						this.x = TempX;
						this.y = TempY;
					}
				}
			}			
			if( m_TotalScaleFrame>0 )
			{
				m_CurScaleFrame++;
				percent = (1.0 * m_CurScaleFrame) / (m_TotalScaleFrame * 1.0);
				
				if ( m_CurScaleFrame >= m_TotalScaleFrame )
				{
					EndScale(true);
				}
				else if ( m_CurScaleFrame > 0 && m_CurScaleFrame < m_TotalScaleFrame)
				{
					this.scaleX = m_OrigScaleX + (m_DesScaleX - m_OrigScaleX) * percent;
					this.scaleY = m_OrigScaleY + (m_DesScaleY - m_OrigScaleY) * percent;
					
					if( m_bScaleInCenter )
					{
						CenterByPoint(m_ptScaleCenter);
					}
				}
			}
			if( m_TotalAlphaFrame>0 )
			{
				m_CurAlphaFrame++;
				percent = (1.0 * m_CurAlphaFrame) / (m_TotalAlphaFrame * 1.0);
				
				if ( m_CurAlphaFrame >= m_TotalAlphaFrame )
				{
					EndShowHide(true);
				}
				else if ( m_CurAlphaFrame > 0 && m_CurAlphaFrame < m_TotalAlphaFrame )
				{
					this.alpha = m_OrigAlpha + (m_DesAlpha - m_OrigAlpha) * percent;
				}
			}
		}
	}
}