package UILogic
{	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class CTurnLight extends Sprite
	{
		private var m_spTurnLight:Sprite;
		private var m_OrigRotation:int;          //出发地及目标地坐标
		private var m_DesRotation:int;
		
		private var m_Moving:Boolean;
		private var m_EndMove:Boolean;           //是否结束动画
		
		private var m_TotalFrame:int;            //移动总帧数
		private var m_CurFrame:int;              //当前帧数
		private var m_TurnRotation:int;		
		
		public function CTurnLight()
		{
			super();
			
			m_EndMove = false;
			m_TotalFrame = 0;
			m_CurFrame = 0;
			m_TurnRotation = 0;
			
			m_spTurnLight = GlobleData.S_pResGame.GetResSprite("TurnLight");
			addChild(m_spTurnLight);
		}
		
		public function EndMoving():void
		{
			if( m_TotalFrame>0 )
			{
				this.rotation = m_DesRotation;				
				
				m_TotalFrame = 0;
				m_CurFrame = 0;				
				this.removeEventListener(Event.ENTER_FRAME, OnMoveSpriteEnterFrame);
			}
		}
		
		private function MoveToByFrame(desRotation:int,framenum:int):void
		{
			if ( !this.visible )
			{
				return ;
			}
			
			m_OrigRotation = rotation;
			m_DesRotation  = desRotation;
			
			var TempShun:int = (m_DesRotation+360-m_OrigRotation)%360;
			var TempFan:int =  ( m_OrigRotation+360-m_DesRotation)%360;
			if( TempFan <= 120 )
			{
				m_TurnRotation = -TempFan;
			}
			else
			{
				m_TurnRotation = TempShun;
			}		
			
			m_TotalFrame = framenum;
			m_CurFrame = 0;
			this.addEventListener(Event.ENTER_FRAME,OnMoveSpriteEnterFrame);
		}
		
		public function MoveToByTime(desRotation:int,ntime:Number):void
		{
			if( this.stage != null )
			{
				var nFrame:int = this.stage.frameRate * ntime;
				if( nFrame > 0 )
				{
					MoveToByFrame(desRotation,nFrame);
				}
				else
				{
					this.rotation = desRotation;
				}
			}
		}
		
		private function OnMoveSpriteEnterFrame(evt:Event):void
		{
			if( m_TotalFrame>0 )
			{
				m_CurFrame++;
				var percent:Number = (1.0 * m_CurFrame) / (m_TotalFrame * 1.0);
				
				if ( m_CurFrame >= m_TotalFrame )
				{
					EndMoving();
				}
				else if ( m_CurFrame > 0 && m_CurFrame < m_TotalFrame)
				{					
					this.rotation = (m_OrigRotation + m_TurnRotation * percent)%360;
				}
			}			
		}
	}
}