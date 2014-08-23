package UILogic
{
	import flash.display.Sprite;
	
	import MoGui.display.CTimeSprite;
	
	public class CPaiTypeSprite extends CTimeSprite
	{
		public var m_nPaiType:int;
		public var m_spType:Sprite;
		
		public function CPaiTypeSprite()
		{
			super();
			
			m_nPaiType = 0;
			m_spType = null;
			
			SetPaiType(5);
		}
		
		public function SetPaiType(nType:int):void
		{
			if( m_nPaiType!=nType && nType>0 && nType<=10 )
			{
				m_nPaiType = nType;
				
				if( m_spType != null )
				{
					removeChild(m_spType);
				}			
				
				m_spType = GlobleData.S_pResGame.GetResSprite("PaiType_"+nType);
				addChild(m_spType);
			}
		}
	}
}