package UILogic
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import L2C.S2C_MoveMoney;
	
	import MoGui.display.CMoveSprite;
	import MoGui.display.CRoundRect;
	import MoGui.display.CText;
	
	public class CMoneyMotion extends CMoveSprite
	{
		public static const Flag_AddChip:int           = 1;
		public static const Flag_ChipToPool:int        = 2;
		public static const Flag_Divide:int            = 3;
		public static const Flag_Send:int              = 4;
		
		public var m_Money:Number;                  //当前表示的筹码数
		public var m_spArrayChip:Array;             //具体的筹码组
		public var m_TextMoney:CText;
		public var m_spTextBack:CRoundRect;
		
		public var m_MoneyFlag:int;                 //钱的性质，比如分钱，比如下注
		public var m_ServerStartSitID:int;          //指的是服务器对应的SITID
		public var m_ServerEndSitID:int;            //结束的坐位号
		public var m_ClientStartSit:int;
		public var m_ClientEndSit:int;
		
		public function CMoneyMotion()
		{
			super();
			
			m_funcEndMove = OnEndMoving;			
			
			m_MoneyFlag = 0;
			m_ServerStartSitID = 0;
			m_ServerEndSitID = 0;
			m_ClientStartSit = 0;
			m_ClientEndSit = 0;
			
			m_Money = 0;
			m_spArrayChip = new Array();
			
			m_spTextBack = new CRoundRect();
			addChild(m_spTextBack);
			
			m_TextMoney = new CText("_sans",false,0xffffff,14);			
			addChild(m_TextMoney);
			//m_TextMoney.x = 5;
			//m_TextMoney.y = 26;
		}
		
		public function OnEndMoving():void
		{
			if( stage != null )
			{				
				var msgMM:S2C_MoveMoney = new S2C_MoveMoney();
				msgMM.m_MoneyFlag         = m_MoneyFlag;
				msgMM.m_ServerStartSitID  = m_ServerStartSitID;
				msgMM.m_ServerEndSitID    = m_ServerEndSitID;
				msgMM.m_ClientStartSit    = m_ClientStartSit;
				msgMM.m_ClientEndSit      = m_ClientEndSit;
				
				GlobleFunc.SendStageToClient(stage,msgMM);
			}
		}
		
		public function get Money():Number
		{
			return m_Money;
		}
		public function set Money(nMoney:Number):void
		{
			if( nMoney >= 0 && nMoney != m_Money )
			{
				var i:int=0;
				var k:int=0;
				
				m_Money = nMoney;
				
				m_TextMoney.text =  GlobleFunc.MoneyToString(m_Money);
				var TextWidth:int = m_TextMoney.GetWidth();
				m_spTextBack.Draw(0x034333,TextWidth+14,18,20,20);
				
				for(i=0;i<m_spArrayChip.length;++i)
				{					
					this.removeChild(m_spArrayChip[i]);
				}
				m_spArrayChip.length = 0;				
				
				var TempChipArray:Vector.<ChipData> = GetMoneyArray();
				for(i=0;i<TempChipArray.length;++i)
				{
					var TempChipData:ChipData = TempChipArray[i];
					var TempClass:Class = GlobleData.S_MapMoneyClass.get(TempChipData.m_ChipMoney);
					for(k=0;k<TempChipData.m_ChipCount;++k)
					{
						var TempChip:Sprite = new TempClass();
						addChild(TempChip);
						m_spArrayChip.push(TempChip);
					}
				}
				
				var ChipX:int = 0;
				var ChipY:int = 0;
				var OneHeap:int = Math.ceil(m_spArrayChip.length/2.0);
				if(OneHeap<5)OneHeap=5;
				//if(OneHeap>10)OneHeap=10;
				for(i=0;i<m_spArrayChip.length;++i)
				{
					ChipX = Math.floor(i/OneHeap)*27;
					ChipY = -(i%OneHeap)*3;
					
					m_spArrayChip[i].x = ChipX;
					m_spArrayChip[i].y = ChipY;
				}
				
				var HeapCount:int = m_spArrayChip.length>OneHeap?2:1;
				var TempPt:Point = new Point();
				TempPt.x = HeapCount*14;
				TempPt.y = 35;
				m_TextMoney.CenterByPoint(TempPt);
				m_spTextBack.CenterByPoint(TempPt);
			}
			else
			{
				if( nMoney < 0 )
				{
					GlobleFunc.LogError("CMoneyMotion Money="+nMoney);
				}
			}
		}
		
		public function GetMoneyArray():Vector.<ChipData>
		{
			var retArray:Vector.<ChipData> = new Vector.<ChipData>();
			var TempMoney:Number = m_Money;
			if( TempMoney > 0 )
			{
				for(var i:int=0;i<GlobleData.S_ArrayChip.length;++i)
				{
					var TempChipData:ChipData = new ChipData();
					TempChipData.m_ChipMoney = GlobleData.S_ArrayChip[i];
					
					while( TempMoney >= TempChipData.m_ChipMoney )
					{
						TempMoney -= TempChipData.m_ChipMoney;
						TempChipData.m_ChipCount += 1;
					}
					if( TempChipData.m_ChipCount > 0 )
					{
						retArray.push(TempChipData);
					}
					if( TempMoney == 0 )
					{
						break;
					}
				}
			}
			retArray.reverse();
			return retArray;			
		}
	}
}