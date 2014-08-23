package MoGui.display
{
	import flash.geom.Point;
	
	public class CMoveSprite extends CMoguiSprite
	{
		private var m_OrigX:int;                 //出发地及目标地坐标
		private var m_OrigY:int;
		private var m_DesX:int;
		private var m_DesY:int;
		
		private var m_TotalMoveFrame:int;            //移动总帧数
		private var m_CurMoveFrame:int;              //当前帧数
		
		public  var m_funcStartMove:Function;
		public  var m_funcEndMove:Function;
		
		public function CMoveSprite()
		{
			super();
			
			m_TotalMoveFrame = 0;
			m_CurMoveFrame = 0;
			
			m_funEndMotion = EndMoving;
			m_funcEnterFrame = OnMoveFrame;
			
			m_funcStartMove = null;
			m_funcEndMove = null;
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
		public function OnMoveFrame():void
		{
			if( m_TotalMoveFrame>0 )
			{
				m_CurMoveFrame++;
				var percent:Number = (1.0 * m_CurMoveFrame) / (m_TotalMoveFrame * 1.0);
				
				if ( m_CurMoveFrame >= m_TotalMoveFrame )
				{
					EndMoving(true);
				}
				else if ( m_CurMoveFrame > 0 && m_CurMoveFrame < m_TotalMoveFrame)
				{
					this.x = m_OrigX + (m_DesX - m_OrigX) * percent;				
					this.y = m_OrigY + (m_DesY - m_OrigY) * percent;			
				}
			}
		}
		
		public function MoveToByFrame(desx:int,desy:int,framenum:int):void
		{
			if ( !this.visible )
			{
				return ;
			}
			
			if( m_funcStartMove != null )
			{
				m_funcStartMove.call();
			}
			
			m_OrigX = this.x;
			m_OrigY = this.y;
			m_DesX = desx;
			m_DesY = desy;
			
			m_TotalMoveFrame = framenum;
			m_CurMoveFrame = 0;			
		}		
		public function MoveToByTime(desx:int,desy:int,ntime:Number):void
		{
			if( this.stage != null )
			{
				var nFrame:int = this.stage.frameRate * ntime;
				if( nFrame > 0 )
				{
					MoveToByFrame(desx,desy,nFrame);
				}
			}
		}		
		public function MoveToPointByTime(pt:Point,ntime:Number):void
		{
			if( this.stage != null )
			{
				var nFrame:int = this.stage.frameRate * ntime;
				if( nFrame > 0 )
				{
					MoveToByFrame(pt.x,pt.y,nFrame);
				}
			}
		}
	}
}

