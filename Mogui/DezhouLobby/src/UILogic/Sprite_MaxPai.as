package UILogic
{
	import flash.display.Sprite;
	
	public class Sprite_MaxPai extends Sprite
	{
		public var m_arrayPai:Vector.<int>;
		public var m_spArrayPai:Vector.<PokerPai>;
		
		public function Sprite_MaxPai()
		{
			super();
			
			m_arrayPai = new Vector.<int>(5);
			m_spArrayPai = new Vector.<PokerPai>(5);
			
			for(var i:int=0;i<5;i++)
			{
				m_arrayPai[i] = 0;
				m_spArrayPai[i] = new PokerPai(25,31);
				m_spArrayPai[i].x = i*30;
				addChild(m_spArrayPai[i]);
			}
		}
		
		public function ShowMaxPai(arrayPai:Vector.<int>):void
		{			
			for(var i:int=0;i<5;i++){				
				if( GlobleFunc.IsPaiMian(arrayPai[i]) ){
					m_spArrayPai[i].SetPai(arrayPai[i]);				
				}
			}
		}
	}
}