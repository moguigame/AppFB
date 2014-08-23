package UILogic
{
	//import MoGui.display.CMoguiSprite;
	//import flash.text.TextFormat;
	
	import MoGui.display.CText;
	
	public class CMoneyNumber extends CText
	{
		private var m_bMotion:Boolean;
		private var m_desNumber:Number;
		private var m_oriNumber:Number;
		private var m_TotalMoneyFrame:int;            //移动总帧数
		private var m_CurMoneyFrame:int;              //当前帧数
		
		private var m_Head:String;
		private var m_MoneyNumber:Number;
		public function CMoneyNumber()
		{
			super();
			
			m_Head = "";
			m_bMotion = false;
			
			m_desNumber = 0;
			m_oriNumber = 0;
			m_TotalMoneyFrame = 0;
			m_CurMoneyFrame = 0;
			
			m_MoneyNumber = 0;
			m_funcEnterFrame = OnChangeNumberFrame;
		}
		
		public function SetHead(str:String):void
		{
			m_Head = str;
		}
		public function EndMoneyChange():void
		{			
			if( m_bMotion )
			{
				m_bMotion = false;
				SetMoney(m_desNumber);
			}
			
			m_desNumber = 0;
			m_oriNumber = 0;
			
			m_TotalMoneyFrame = 0;
			m_CurMoneyFrame = 0;
		}
		public function SetMoney(nMoney:Number,bMotion:Boolean=false):void
		{
			m_bMotion = bMotion;
			if( !bMotion )
			{
				m_desNumber = 0;
				m_oriNumber = 0;
				
				m_TotalMoneyFrame = 0;
				m_CurMoneyFrame = 0;
			}
			m_MoneyNumber = nMoney;
			this.text = m_Head + GlobleFunc.MoneyToString(nMoney);
		}
		public function ChangeMoneyTo(nToNumber:Number,nTime:Number):void
		{
			if( !m_bMotion )
			{
				m_bMotion = true;
				
				m_TotalMoneyFrame = this.stage.frameRate * nTime;
				m_CurMoneyFrame = 0;
				
				m_oriNumber = m_MoneyNumber;
				m_desNumber = nToNumber;
			}
			else
			{
				m_desNumber = nToNumber;
			}
		}
		public function OnChangeNumberFrame():void
		{
			if( m_bMotion && m_TotalMoneyFrame>0 )
			{
				m_CurMoneyFrame++;				
				if ( m_CurMoneyFrame >= m_TotalMoneyFrame )
				{
					EndMoneyChange();
				}
				else if ( m_CurMoneyFrame > 0 && m_CurMoneyFrame < m_TotalMoneyFrame )
				{
					var percent:Number = (1.0 * m_CurMoneyFrame) / (m_TotalMoneyFrame * 1.0);
					var curNumber:Number = m_oriNumber + (m_desNumber-m_oriNumber)*percent;
					SetMoney(Math.floor(curNumber),true);
				}
			}
		}
	}
}