package UILogic
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import Data.Data_ShowPreChipBoard;
	
	import MoGui.display.CRectangle;
	
	public class CPreOperateBoard extends Sprite
	{
		public static const  Action_KanPai:int           = 1;
		public static const  Action_KanOrPass:int        = 2;
		public static const  Action_FollowAny:int        = 3;
		public static const  Action_Follow:int           = 4;
		
		public var m_btnKanPai:CBtnPreOpreator;
		public var m_btnKanOrPass:CBtnPreOpreator;
		public var m_btnFollowAny:CBtnPreOpreator;
		public var m_btnFollowChip:CBtnPreOpreator;
		
		public var m_Action:int;
		public var m_nMoney:Number;
		
		public function CPreOperateBoard()
		{
			super();
			
			m_Action = 0;
			m_nMoney = 0;
			
			var TempBack:CRectangle = new CRectangle();
			TempBack.width = 500;
			TempBack.height = 120;
			//addChild(TempBack);
			TempBack.alpha = 0.15;
			
			m_btnKanPai = new CBtnPreOpreator("自 动 看 牌","button_chip_gray");
			addChild(m_btnKanPai);
			m_btnKanPai.x = 15;
			m_btnKanPai.y = 30;
			
			m_btnKanOrPass = new CBtnPreOpreator("看牌或弃牌","button_chip_gray");
			addChild(m_btnKanOrPass);
			m_btnKanOrPass.x = 260;
			m_btnKanOrPass.y = 30;
			
			m_btnFollowAny = new CBtnPreOpreator("跟 任 何 注","button_chip_gray");
			addChild(m_btnFollowAny);
			m_btnFollowAny.x = 15;
			m_btnFollowAny.y = 70;
			
			m_btnFollowChip = new CBtnPreOpreator("跟注","button_chip_gray");
			addChild(m_btnFollowChip);
			m_btnFollowChip.x = 260;
			m_btnFollowChip.y = 70;
			m_btnFollowChip.m_tLabel.SetCenterPoint(new Point(80, 15));
			m_btnFollowChip.m_tMoney.SetCenterPoint(new Point(160,15));			
			m_btnFollowChip.SetLabel("跟注");
			
			m_btnKanPai.addEventListener(MouseEvent.CLICK,OnKanPaiClick);
			//m_btnKanPai.m_clipCheck.addEventListener(MouseEvent.CLICK,OnKanPaiClick);
			
			m_btnKanOrPass.addEventListener(MouseEvent.CLICK,OnKanOrPassClick);
			//m_btnKanOrPass.m_clipCheck.addEventListener(MouseEvent.CLICK,OnKanOrPassClick);
			
			m_btnFollowAny.addEventListener(MouseEvent.CLICK,OnFollowAnyClick);
			//m_btnFollowAny.m_clipCheck.addEventListener(MouseEvent.CLICK,OnFollowAnyClick);
			
			m_btnFollowChip.addEventListener(MouseEvent.CLICK,OnFollowChipClick);
			//m_btnFollowChip.m_clipCheck.addEventListener(MouseEvent.CLICK,OnFollowChipClick);
			
			UnselectAll();
		}
		
		public function IsSelect():Boolean
		{
			return m_Action != 0;
		}
		public function OnKanPaiClick(evt:MouseEvent):void
		{
			UnselectAll();
			
			if( m_Action == Action_KanPai )
			{
				m_Action = 0;
			}
			else
			{
				m_btnKanPai.SetSelect(true);
				m_Action = Action_KanPai;				
			}
			m_nMoney = 0;
		}
		public function OnKanOrPassClick(evt:MouseEvent):void
		{
			UnselectAll();
			
			if( m_Action == Action_KanOrPass )
			{
				m_Action = 0;
			}
			else
			{
				m_btnKanOrPass.SetSelect(true);
				m_Action = Action_KanOrPass;		
			}
			m_nMoney = 0;
		}
		public function OnFollowAnyClick(evt:MouseEvent):void
		{
			UnselectAll();
			
			if( m_Action == Action_FollowAny )
			{
				m_Action = 0;
			}
			else
			{
				m_btnFollowAny.SetSelect(true);
				m_Action = Action_FollowAny;
			}
			m_nMoney = 0;
		}
		public function OnFollowChipClick(evt:MouseEvent):void
		{
			UnselectAll();
			
			if( m_Action == Action_Follow )
			{
				m_Action = 0;
				m_nMoney = 0;
			}
			else
			{
				m_btnFollowChip.SetSelect(true);
				m_Action = Action_Follow;
				m_nMoney = m_btnFollowChip.GetMoney();
			}			
		}
		
		private function UnselectAll():void
		{
			m_btnKanPai.SetSelect(false);
			m_btnKanOrPass.SetSelect(false);
			m_btnFollowAny.SetSelect(false);
			m_btnFollowChip.SetSelect(false);
		}
		public function Hide():void
		{
			this.visible = false;
			
			m_Action = 0;
			m_nMoney = 0;
		}
		public function Show(dataSPCB:Data_ShowPreChipBoard):void
		{
			this.visible = true;
			
			UnselectAll();
			
			var nGameMonry:Number = dataSPCB.m_ChipMoney + dataSPCB.m_TableMoney;
			if( dataSPCB.m_MaxChipOnTable>dataSPCB.m_ChipMoney
				|| (dataSPCB.m_MaxChipOnTable>0 && dataSPCB.m_ChipMoney==0) )
			{
				m_btnKanPai.visible = false;
			}		
			
			if( m_Action == Action_KanPai )
			{
				m_btnKanPai.SetSelect(true);
				if( dataSPCB.m_MaxChipOnTable>dataSPCB.m_ChipMoney
					|| (dataSPCB.m_MaxChipOnTable>0 && dataSPCB.m_ChipMoney==0) )
				{
					m_btnKanPai.visible = false;
					m_btnKanPai.SetSelect(false);
					
					m_Action = 0;
					m_nMoney = 0;
				}
			}
			else if( m_Action == Action_KanOrPass )
			{
				m_btnKanOrPass.SetSelect(true);
			}
			else if( m_Action == Action_FollowAny )
			{
				m_btnFollowAny.SetSelect(true);
			}
			else if( m_Action == Action_Follow )
			{
				m_btnFollowChip.SetSelect(true);
				
				var nSelectMoney:Number = m_btnFollowChip.GetMoney();				
				if( dataSPCB.m_MaxChipOnTable>nSelectMoney	&& nSelectMoney<nGameMonry )
				{
					m_Action = 0;
					m_nMoney = 0;
					m_btnFollowChip.SetSelect(false);
				}	
			}
			
			if( dataSPCB.m_MaxChipOnTable > 0 )
			{
				m_btnFollowChip.SetMoney(Math.min(dataSPCB.m_MaxChipOnTable,nGameMonry));				
			}
			else
			{
				m_btnFollowChip.SetMoney(Math.min(dataSPCB.m_nBigBlind,nGameMonry));
			}
		}
	}
}