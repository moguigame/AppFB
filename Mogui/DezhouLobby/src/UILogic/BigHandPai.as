package UILogic
{	
	import flash.geom.Point;
	
	import MoGui.display.CMoveSprite;
	
	public class BigHandPai extends CMoveSprite
	{
		public var m_ClientSit:int;
		public var m_HandPai:Vector.<int>;
		public var m_spHandPai:Vector.<PokerPai>;
		
		public function BigHandPai()
		{
			super();
			
			m_ClientSit = 0;
			
			m_HandPai = new Vector.<int>(2);
			m_HandPai[0] = m_HandPai[1] = 0;
			
			m_spHandPai = new Vector.<PokerPai>(2);
			m_spHandPai[0] = new PokerPai(40,50);
			m_spHandPai[1] = new PokerPai(40,50);
			
			addChild(m_spHandPai[0]);
			addChild(m_spHandPai[1]);
			
			m_spHandPai[1].x = 40;
		}
		
		public function Init():void
		{
			m_HandPai[0] = m_HandPai[1] = 0;			
		}
		public function InitResult():void
		{
			m_spHandPai[0].y = 0;
			m_spHandPai[0].SetMask(false);
			
			m_spHandPai[1].y = 0;
			m_spHandPai[1].SetMask(false);
		}
		public function ShowResult(arrayPai:Vector.<int>):void
		{
			InitResult();
			
			if( GlobleFunc.IsPaiMian(m_HandPai[0]) && GlobleFunc.IsPaiMian(m_HandPai[1]) )
			{
				for(var i:int=0;i<5;i++)
				{
					var nPai:int = arrayPai[i];
					if( GlobleFunc.IsPaiMian(nPai) )
					{
						if( m_HandPai[0] == nPai )
						{
							m_spHandPai[0].SetMask(true);
							m_spHandPai[0].MoveToPointByTime(new Point(m_spHandPai[0].x,-10),0.6);
						}
						else if( m_HandPai[1] == nPai )
						{
							m_spHandPai[1].SetMask(true);
							m_spHandPai[1].MoveToPointByTime(new Point(m_spHandPai[1].x,-10),0.6);
						}
					}					
				}
			}
		}
		public function SetHandPai(lPai:int,rPai:int):void
		{
			if( GlobleFunc.IsPaiMian(lPai) && GlobleFunc.IsPaiMian(rPai) )
			{
				m_HandPai[0] = lPai;
				m_HandPai[1] = rPai;
				m_spHandPai[0].SetPai(lPai);
				m_spHandPai[1].SetPai(rPai);
			}
			else
			{
				GlobleFunc.LogError("BigHandPai SetHandPai ClientSit="+m_ClientSit,lPai,rPai);
			}
		}
	}
}