package UILogic
{	
	public class View_GuanJunMatch extends ViewSprite
	{
		public var m_Idx:int;                         //指当前VIEW的序号从0开始算起
		
		public function View_GuanJunMatch()
		{
			super();
			
			m_Place = DeZhouDef.Place_GuanJunMatch;
		}
	}
}