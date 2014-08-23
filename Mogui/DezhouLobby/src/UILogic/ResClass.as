package UILogic
{
	import flash.display.Sprite;
	
	import MoGui.display.CMoveSprite;
	import MoGui.net.CLoadResource;
	
	public class ResClass extends CMoveSprite
	{
		public var m_spRes:Sprite;
		
		public function ResClass()
		{
			super();
		}
		
		public function InitRes(pRes:CLoadResource,strClass:String):void
		{
			var TempClass:Class = pRes.GetResource(strClass);
			m_spRes = new TempClass();
			addChild(m_spRes);
		}
	}
}