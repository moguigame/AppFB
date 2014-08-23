package UILogic
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	
	import Data.Data_ShowChipBoard;
	
	import L2C.S2C_AddChipInfo;
	
	import MoGui.display.CRectangle;
	
	public class COperatorBoard extends Sprite
	{
		public static const MaxChipNumber:int          = 7;
		public static const DiffTime:int               = 2000;
		
		public var m_btnKanPai:CBtnOperator;
		public var m_btnGiveUp:CBtnOperator;
		public var m_btnFollow:CBtnOperator;
		public var m_btnAdd:CBtnOperator;
		public var m_btnAllIn:CBtnOperator;
		public var m_spChipSlip:CAddChipSlip;
		
		public var m_nLastOperateTime:int;
		public var m_nBigBlind:int;
		public var m_nGameMoney:Number;
		public var m_btnArrayChipSprite:Vector.<CChipSprite>;
		public function COperatorBoard()
		{
			super();
			
			m_nBigBlind = 0;
			m_nLastOperateTime = 0;
			
			var TempBack:CRectangle = new CRectangle();
			TempBack.width = 500;
			TempBack.height = 120;
			//addChild(TempBack);
			TempBack.alpha = 0.15;
			
			m_btnArrayChipSprite = new Vector.<CChipSprite>(MaxChipNumber);
			for(var i:int=0;i<MaxChipNumber;++i)
			{
				m_btnArrayChipSprite[i] = new CChipSprite();				
				addChild(m_btnArrayChipSprite[i]);
				m_btnArrayChipSprite[i].buttonMode = true;				
				
				m_btnArrayChipSprite[i].x = 42*i + 120;
				m_btnArrayChipSprite[i].y = 0;				
			}
			
			m_btnKanPai = new CBtnOperator("看         牌","button_chip_blue","icon_Follow");
			addChild(m_btnKanPai);
			m_btnKanPai.m_tLabel.x = 40;
			m_btnKanPai.m_tLabel.y = 5;
			
			m_btnFollow = new CBtnOperator("跟注","button_chip_blue","icon_Follow");
			addChild(m_btnFollow);
			m_btnFollow.m_tLabel.x = 40;
			m_btnFollow.m_tLabel.y = 5;
			
			m_btnGiveUp = new CBtnOperator("弃         牌","button_chip_gray","icon_giveup");
			addChild(m_btnGiveUp);
			m_btnGiveUp.m_tLabel.x = 40;
			m_btnGiveUp.m_tLabel.y = 5;
			
			m_btnAdd = new CBtnOperator("加注","button_chip_blue","icon+add");
			addChild(m_btnAdd);
			m_btnAdd.m_tLabel.x = 40;
			m_btnAdd.m_tLabel.y = 5;			
			
			m_btnAllIn = new CBtnOperator("全下","button_chip_red","icon_allin");
			addChild(m_btnAllIn);
			m_btnAllIn.m_tLabel.x = 40;
			m_btnAllIn.m_tLabel.y = 5;			
			
			m_spChipSlip = new CAddChipSlip();
			addChild(m_spChipSlip);			
			
			m_btnKanPai.x = 20;
			m_btnKanPai.y = 35;			
			m_btnFollow.x = m_btnKanPai.x;
			m_btnFollow.y = m_btnKanPai.y;
			
			m_btnAdd.x = 20;
			m_btnAdd.y = 73;
			m_btnAllIn.x = m_btnAdd.x;
			m_btnAllIn.y = m_btnAdd.y;
			
			m_btnGiveUp.x = 260;
			m_btnGiveUp.y = 35;
			
			m_spChipSlip.x = 260;
			m_spChipSlip.y = 72;
			
			m_btnKanPai.addEventListener(MouseEvent.CLICK,OnKanPai);
			m_btnFollow.addEventListener(MouseEvent.CLICK,OnFollow);
			m_btnAdd.addEventListener(MouseEvent.CLICK,OnAddChip);
			m_btnAllIn.addEventListener(MouseEvent.CLICK,OnAllIn);
			m_btnGiveUp.addEventListener(MouseEvent.CLICK,OnGiveUp);
		}
		
		private function OnKanPai(evt:MouseEvent):void
		{
			if( m_btnKanPai.visible )
			{
				var CurTime:int = getTimer();
				if( CurTime - m_nLastOperateTime >= DiffTime )
				{
					m_nLastOperateTime = CurTime;
					
					var msgAC:S2C_AddChipInfo = new S2C_AddChipInfo();
					msgAC.m_ChipAction        = DeZhouDef.ACTION_KanPai;
					msgAC.m_ChipValue         = 0;
					GlobleFunc.SendStageToClient(stage,msgAC);
				}
			}
		}
		private function OnFollow(evt:MouseEvent):void
		{
			if( m_btnFollow.visible )
			{
				var CurTime:int = getTimer();
				if( CurTime - m_nLastOperateTime >= DiffTime )
				{
					m_nLastOperateTime = CurTime;
					
					var msgAC:S2C_AddChipInfo = new S2C_AddChipInfo();
					msgAC.m_ChipAction        = DeZhouDef.ACTION_Follow;
					msgAC.m_ChipValue         = m_btnFollow.m_nMoney;
					GlobleFunc.SendStageToClient(stage,msgAC);
				}
			}
		}
		private function OnAddChip(evt:MouseEvent):void
		{
			if( m_btnAdd.visible )
			{
				var CurTime:int = getTimer();
				if( CurTime - m_nLastOperateTime >= DiffTime )
				{
					m_nLastOperateTime = CurTime;
					
					var msgAC:S2C_AddChipInfo = new S2C_AddChipInfo();
					msgAC.m_ChipAction        = DeZhouDef.ACTION_AddChip;
					msgAC.m_ChipValue         = m_btnAdd.m_nMoney;
					GlobleFunc.SendStageToClient(stage,msgAC);
				}
			}
		}
		private function OnAllIn(evt:MouseEvent):void
		{
			if( m_btnAllIn.visible )
			{
				var CurTime:int = getTimer();
				if( CurTime - m_nLastOperateTime >= DiffTime )
				{
					m_nLastOperateTime = CurTime;
					
					var msgAC:S2C_AddChipInfo = new S2C_AddChipInfo();
					msgAC.m_ChipAction        = DeZhouDef.ACTION_AllIn;
					msgAC.m_ChipValue         = m_btnAllIn.m_nMoney;
					GlobleFunc.SendStageToClient(stage,msgAC);
				}
			}
		}
		private function OnGiveUp(evt:MouseEvent):void
		{
			if( m_btnGiveUp.visible )
			{
				var CurTime:int = getTimer();
				if( CurTime - m_nLastOperateTime >= DiffTime )
				{
					m_nLastOperateTime = CurTime;
					
					var msgAC:S2C_AddChipInfo = new S2C_AddChipInfo();
					msgAC.m_ChipAction        = DeZhouDef.ACTION_GiveUp;
					msgAC.m_ChipValue         = 0;
					GlobleFunc.SendStageToClient(stage,msgAC);
				}
			}
		}
		
		public function OnChipSprite(nValue:Number):void
		{
			if( m_btnAdd.visible )
			{
				if( nValue > m_btnAdd.m_nMoney )
				{
					if( nValue < m_nGameMoney )m_btnAdd.SetMoney(nValue);
					else m_btnAdd.SetMoney(m_nGameMoney);
				}
				else
				{
					if( m_btnAdd.m_nMoney+nValue < m_nGameMoney )m_btnAdd.SetMoney(m_btnAdd.m_nMoney+nValue);
					else m_btnAdd.SetMoney(m_nGameMoney);					
				}
			}
		}
		
		public function OnSliderChange(nValue:Number):void
		{
			if( m_btnAdd.visible )
			{
				if( nValue < m_nGameMoney )
				{
					m_btnAdd.SetMoney(nValue);
				}				
			}
		}
		
		public function SetBigBlind(nBlind:int):void
		{
			if( m_nBigBlind != nBlind )
			{
				m_nBigBlind = nBlind;
				
				var i:int = 0;
				for( i=0;i<MaxChipNumber;++i )
				{
					m_btnArrayChipSprite[i].visible = false;
				}
				
				var StartIdx:int = -1;				
				for( i=GlobleData.S_ArrayChip.length-1;i>=0;i--)
				{
					if( GlobleData.S_ArrayChip[i] >= m_nBigBlind*2 )
					{
						StartIdx = i;
						break;
					}
				}
				
				if( StartIdx >= 0 )
				{
					var ChipIdx:int = 0;
					for(;StartIdx>=0;StartIdx--)
					{
						m_btnArrayChipSprite[ChipIdx].visible = true;
						m_btnArrayChipSprite[ChipIdx].InitChip(GlobleData.S_ArrayChip[StartIdx]);
						
						ChipIdx++;
						if( ChipIdx >= MaxChipNumber )
						{
							break;
						}
					}
				}
			}
		}
		
		public function HideAllBtn():void
		{
			m_btnKanPai.visible  = false;
			m_btnGiveUp.visible  = false;
			m_btnFollow.visible  = false;
			m_btnAdd.visible     = false;
			m_btnAllIn.visible   = false;
			m_spChipSlip.visible = false;
		}
		
		public function Hide():void
		{
			this.visible = false;
			m_nLastOperateTime = 0;
		}
		
		public function Show(dataSCB:Data_ShowChipBoard):void
		{
			this.visible = true;
			
			if( dataSCB.m_TableMoney == 0 )
			{
				GlobleFunc.LogError("COperatorBoard Show TableMoney=0");
			}			
			if( dataSCB.m_nBigBlind <= 0 )
			{
				GlobleFunc.LogError("COperatorBoard Show m_nBigBlind="+dataSCB.m_nBigBlind);
			}
			
			SetBigBlind(dataSCB.m_nBigBlind);
			HideAllBtn();
			
			var myGameMoney:Number     = dataSCB.m_ChipMoney + dataSCB.m_TableMoney;
			var TempAddChip:Number     = dataSCB.m_MaxChipOnTable + dataSCB.m_MinAddChip;
			var nMaxChipOnTable:Number = dataSCB.m_MaxChipOnTable;
			var nChipMoney:Number      = dataSCB.m_ChipMoney;
			
			m_nGameMoney = myGameMoney;
			
			var bShowSlider:Boolean = false;			
			if( nMaxChipOnTable > 0 )
			{
				if( nMaxChipOnTable == nChipMoney )
				{
					m_btnAdd.SetLabel("跟注");
					m_btnKanPai.visible = true;
					m_btnGiveUp.visible = true;
					
					if( TempAddChip >= myGameMoney )
					{
						m_btnAllIn.visible = true;
						m_btnAllIn.SetMoney(myGameMoney);
					}
					else
					{
						m_btnAdd.visible = true;
						m_btnAdd.SetMoney(TempAddChip);
						
						bShowSlider = true;
					}
				}
				else
				{
					if( nMaxChipOnTable >= myGameMoney )
					{
						m_btnAllIn.visible = true;
						m_btnGiveUp.visible = true;
						m_btnAllIn.SetMoney(myGameMoney);
					}
					else if( TempAddChip >= myGameMoney )
					{
						m_btnAllIn.visible = true;
						m_btnGiveUp.visible = true;
						
						m_btnAllIn.SetMoney(myGameMoney);
						
						if( myGameMoney > dataSCB.m_MinAddChip )
						{
							m_btnFollow.visible = true;	
							m_btnFollow.SetMoney(nMaxChipOnTable);
						}						
					}
					else
					{
						m_btnGiveUp.visible = true;
						
						m_btnFollow.visible = true;	
						m_btnFollow.SetMoney(nMaxChipOnTable);
						
						m_btnAdd.visible = true;
						m_btnAdd.SetMoney(TempAddChip);
						
						bShowSlider = true;						
					}
				}
			}
			else
			{
				m_btnAdd.SetLabel("下注");
				m_btnKanPai.visible = true;
				m_btnFollow.visible = false;
				
				m_btnGiveUp.visible = true;
				
				if( dataSCB.m_MinAddChip >= myGameMoney )
				{
					m_btnAllIn.visible = true;
					m_btnAdd.SetMoney(dataSCB.m_MinAddChip);
				}
				else
				{
					m_btnAllIn.visible = false;
					m_btnAdd.visible = true;
					m_btnAdd.SetMoney(TempAddChip);
					
					bShowSlider = true;					
				}
			}
			
			if( bShowSlider )
			{
				m_spChipSlip.visible = true;
				m_spChipSlip.SetChip(TempAddChip,TempAddChip,myGameMoney);				
				m_spChipSlip.m_spSlider.tick = Math.min(m_nBigBlind,Math.ceil( (myGameMoney-TempAddChip)/10 ));
			}			
		}			
	}
}