package UILogic
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class SpriteTablePai extends Sprite
	{
		public var m_arrayPai:Vector.<int>;
		public var m_spArrayPai:Vector.<PokerPai>;
		
		public function SpriteTablePai()
		{
			super();
			
			m_arrayPai = new Vector.<int>(5);
			m_spArrayPai = new Vector.<PokerPai>(5);
			
			for(var i:int=0;i<5;i++)
			{
				m_arrayPai[i] = 0;
				m_spArrayPai[i] = new PokerPai(50,62);
				m_spArrayPai[i].x = i*55;
				addChild(m_spArrayPai[i]);
			}
		}
		
		public function Init():void
		{
			for(var i:int=0;i<5;i++)
			{
				m_arrayPai[i] = 0;
				m_spArrayPai[i].visible = false;
			}
		}
		
		public function InitResult():void
		{
			for(var i:int=0;i<5;i++)
			{
				m_spArrayPai[i].y = 0;
				m_spArrayPai[i].SetMask(false);
			}
		}
		
		public function ShowResult(arrayPai:Vector.<int>):void
		{
			InitResult();
			
			for(var i:int=0;i<5;i++)
			{
				var nPai:int = arrayPai[i];
				if( GlobleFunc.IsPaiMian(nPai) )
				{
					for(var j:int=0;j<5;j++)
					{
						if( m_arrayPai[j] == nPai )
						{
							var OriX:int = m_spArrayPai[j].x;
							m_spArrayPai[j].SetMask(true);
							m_spArrayPai[j].MoveToPointByTime(new Point(OriX,-10),0.6);
							break;
						}
					}
				}				
			}
		}
		
		public function SetTablePai(arrayPai:Vector.<int>,bFanPai:Boolean=true):void
		{
			for(var i:int=0;i<5;++i)
			{
				if( GlobleFunc.IsPaiMian(arrayPai[i]) )
				{
					m_spArrayPai[i].visible = true;
					if( m_arrayPai[i]==0 && arrayPai[i]>0 && bFanPai )
					{
						m_arrayPai[i] = arrayPai[i];
						m_spArrayPai[i].SetPai(55);
						
						m_spArrayPai[i].FanPaiByTime(m_arrayPai[i],0.15);
					}
					else
					{	m_arrayPai[i] = arrayPai[i];
						m_spArrayPai[i].SetPai(arrayPai[i]);
					}
				}				
			}
		}
	}
}