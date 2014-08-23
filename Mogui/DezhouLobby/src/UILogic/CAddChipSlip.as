package UILogic
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import L2C.S2C_Flag;
	
	import morn.core.components.Button;
	import morn.core.components.Slider;
	
	public class CAddChipSlip extends Sprite
	{
		public var m_spBack:Sprite;
		public var m_btnAdd:Button;
		public var m_btnReduce:Button;
		public var m_btnAllIn:SimpleButton;
		
		public var m_spSlider:Slider;
		public var m_nMinChip:Number;
		public var m_nMaxChip:Number;
		public var m_nCurChip:Number;
		
		public function CAddChipSlip()
		{
			super();
			
			m_nMinChip = 0;
			m_nMaxChip = 0;

			m_spSlider = new Slider("png.comp.hslider_1");
			m_spSlider.direction = Slider.HORIZONTAL;
			m_spSlider.showLabel = false;
			m_spSlider.height = 10;
			m_spSlider.width = 185;
			addChild(m_spSlider);
			m_spSlider.x = 22;
			m_spSlider.y = 11;
			
			m_spSlider.addEventListener(Event.CHANGE,OnSliderChange);
			
			m_btnReduce = new Button("png.comp.button_slider_minus");
			addChild(m_btnReduce);
			m_btnReduce.x = 1;
			m_btnReduce.y = 6;
			
			m_btnAdd = new Button("png.comp.button_slider_add");		
			addChild(m_btnAdd);
			m_btnAdd.x = 209;
			m_btnAdd.y = 6;
		}
		
		private function OnSliderChange(evt:Event):void
		{
			if( stage )
			{
				var msgFlag:S2C_Flag  = new S2C_Flag();
				msgFlag.m_Flag        = S2C_Flag.ChipSliderChange;
				msgFlag.m_Value       = m_spSlider.value;
				GlobleFunc.SendStageToClient(stage,msgFlag);
			}
		}
		
		public function SetChip(curChip:Number,minChip:Number,maxChip:Number):void
		{
			if(curChip<minChip || curChip>maxChip )
			{
				GlobleFunc.LogError("CAddChipSlip SetChip",curChip,minChip,maxChip );
			}
			else
			{
				m_spSlider.setSlider(minChip,maxChip,curChip);			
			}
		}
	}
}