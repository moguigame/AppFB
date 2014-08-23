package UILogic
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import L2C.S2C_Flag;
	
	public class CChipSprite extends Sprite
	{
		private var m_spChip:Sprite;
		private var m_nChip:Number;
		
		public function CChipSprite()
		{
			super();
			m_spChip = null;
		}
		
		public function GetChip():Number
		{
			return m_nChip;
		}
		public function InitChip(nChip:Number):void
		{
			var Idx:int = -1;
			for(var i:int=0;i<GlobleData.S_ArrayChip.length;++i)
			{
				if( GlobleData.S_ArrayChip[i] == nChip )
				{
					Idx = i;
					break;
				}
			}
			if( Idx >= 0 )
			{
				m_nChip = nChip;
				
				if( m_spChip != null )
				{
					removeChild(m_spChip);
				}
				
				var TempClass:Class = GlobleData.S_MapMoneyClass.get(m_nChip);
				m_spChip = new TempClass();
				addChild(m_spChip);
				m_spChip.addEventListener(MouseEvent.CLICK,OnChipClick);
			}
			else
			{
				GlobleFunc.LogError("CChipSprite Init nChip="+nChip);
			}
		}
		public function OnChipClick(evt:MouseEvent):void
		{
			if( stage )
			{				
				var msgFlag:S2C_Flag = new S2C_Flag();
				msgFlag.m_Flag       = S2C_Flag.ChipSpriteClick;
				msgFlag.m_Value      = m_nChip;
				GlobleFunc.SendStageToClient(stage,msgFlag);
			}
		}
	}
}