package UILogic
{
	import flash.display.Sprite;
	
	import L2C.S2C_MoveMinPai;
	
	import MoGui.display.CMoveSprite;
	
	public class MinHandPai extends CMoveSprite
	{
		public var m_StartSit:int;                       //起始或者终止位置-1表示发牌区，0-8表示各个玩家区
		public var m_EndSit:int;
		public var m_Idx:int;
		
		public function MinHandPai()
		{
			super();
			
			var TempClass:Class = GlobleData.S_MapPaiClass.get(55);
			var TempPai:Sprite = new TempClass();
			this.addChild(TempPai);
			
			this.m_funcEndMove = OnEndMoving;
		}
		
		public function OnEndMoving():void
		{
			if( stage != null )
			{
				var msgMMP:S2C_MoveMinPai = new S2C_MoveMinPai();
				msgMMP.m_StartSit     = m_StartSit;
				msgMMP.m_EndSit       = m_EndSit;
				msgMMP.m_Idx          = m_Idx;
				GlobleFunc.SendStageToClient(stage,msgMMP);
			}
		}
	}
}