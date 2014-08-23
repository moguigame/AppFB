package MoGui.display
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class CMoguiSprite extends Sprite
	{
		public var m_funcEnterFrame:Function;
		public var m_funEndMotion:Function;
		
		public function CMoguiSprite()
		{
			super();
			
			m_funEndMotion = null;
			m_funcEnterFrame = null;
			this.addEventListener(Event.ENTER_FRAME,OnEnterFrame);
		}
		public function OnEnterFrame(evt:Event):void
		{
			if( m_funcEnterFrame != null )
			{
				m_funcEnterFrame.call();
			}
		}
		public function EndMotion(bAuto:Boolean):void
		{
			if( m_funEndMotion != null )
			{
				m_funEndMotion.call(bAuto);
			}			
		}
		
		public function GetCenterPt():Point
		{
			var pt:Point = new Point();
			pt.x = x + this.width;
			pt.y = y + this.height;
			return pt;
		}
		public function CenterByPoint(pt:Point):void
		{
			this.x = pt.x - this.width / 2;
			this.y = pt.y - this.height / 2;
		}		
		public function CenterXByX(px:int):void
		{
			this.x = px - this.width / 2;
		}
		public function CenterYByY(py:int):void
		{
			this.y = py - this.height / 2;
		}
		public function CenterXByRect(rt:Rectangle):void
		{
			this.x = (rt.left + rt.right - this.width) / 2;
		}
		public function CenterYByRect(rt:Rectangle):void
		{
			this.y = (rt.top + rt.bottom - this.height) / 2;
		}
		public function CenterByRect(rt:Rectangle):void
		{
			CenterXByRect(rt);
			CenterYByRect(rt);
		}
		public function SetPoint(pt:Point):void
		{
			this.x = pt.x;
			this.y = pt.y;
		}
		
		public function get right():Number
		{
			return this.x + this.width;
		}
		public function set right(r:Number):void
		{
			this.x = r - this.width;
		}
		public function get bottom():Number
		{
			return this.y + this.height;
		}
		public function set bottom(b:Number):void
		{
			this.y = b - this.height;
		}
		public function get left():Number
		{
			return this.x;
		}
		public function set left(l:Number):void
		{
			this.x = l;
		}
		public function get top():Number
		{
			return this.y;
		}
		public function set top(t:Number):void
		{
			this.y = t;
		}
		
		//这个没有处理比这个RECT还大的情况
		public function SetInRect(rt:Rectangle):void
		{
			if ( this.x < rt.x )
			{
				this.x = rt.x;
			}
			if ( this.y < rt.y )
			{
				this.y = rt.y;
			}
			if ( right > rt.right )
			{
				this.right = rt.right;
			}
			if ( this.bottom > rt.bottom )
			{
				this.bottom = rt.bottom;
			}
		}
		public function GetRect():Rectangle
		{
			return new Rectangle(left, top, width, height);
		}
		
		public function TransforWithExternalPoint(regPiont:Point, angleDegrees:Number = 0, sx:Number = 1, sy:Number = 1):void
		{
			var m:Matrix = this.transform.matrix;
			m.tx -= regPiont.x;
			m.ty -= regPiont.y;
			if (angleDegrees % 360 != 0)
			{
				m.rotate(angleDegrees*(Math.PI/180));
			}
			if (sx != 1 || sy != 1)
			{
				m.scale(sx,sy);
			}
			m.tx += regPiont.x;
			m.ty += regPiont.y;
			this.transform.matrix = m;
		}
		
		//内部旋转在多次重复后会有位移变化
		public function TransforWithInternalPoint(regPiont:Point, angleDegrees:Number,sx:Number = 1, sy:Number = 1):void
		{
			var m:Matrix = this.transform.matrix;
			regPiont = m.transformPoint(regPiont);
			m.tx -= regPiont.x;
			m.ty -= regPiont.y;
			if (angleDegrees % 360 != 0)
			{
				m.rotate(angleDegrees*(Math.PI/180));
			}
			if (sx != 1 || sy != 1) 
			{
				//m.scale(sx,sy);
			}
			m.tx += regPiont.x;
			m.ty += regPiont.y;
			this.transform.matrix = m;
		}
	}
}