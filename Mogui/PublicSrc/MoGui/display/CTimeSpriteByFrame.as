package MoGui.display
{
	import flash.events.Event;
	import flash.utils.getTimer;

	public class CTimeSpriteByFrame extends CMoveSprite
	{
		public var m_StartTime:int;
		public var m_LastTime:int;
		
		public var m_funPreShow:Function;
		public var m_funEndShow:Function;
		
		public function CTimeSpriteByFrame()
		{
			super();
			
			m_StartTime = 0;
			m_LastTime = 0;
			
			m_funPreShow = null;
			m_funEndShow = null;
			
			this.addEventListener(Event.ENTER_FRAME,OnEnterFrame);
		}
		
		private function OnEnterFrame(evt:Event):void
		{
			if( m_StartTime>0 && m_LastTime>0 && getTimer()>=(m_StartTime+m_LastTime) )
			{
				this.visible = false;
				
				if( m_funEndShow )
				{
					m_funEndShow.call();
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
	}
}