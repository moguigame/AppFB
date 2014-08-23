package UILogic
{	
	public class View_JingBiaoMatch extends ViewSprite
	{
		public var m_Idx:int;                         //指当前VIEW的序号从0开始算起
		
		
		public function View_JingBiaoMatch()
		{
			super();
			
			m_Place = DeZhouDef.Place_JingBiaoMatch;
		}
	}
}