package UILogic
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import L2C.C2P_Flag;
	
	import MoGui.display.CTimeSprite;
	
	public class CFaceSprite extends CTimeSprite
	{
		public var m_mcFace:MovieClip;
		public var m_FaceID:int;
		
		public var m_FrameIdx:int;
		public var m_SmallBoard:Boolean;     //是否是在选择框里面的
		
		public function CFaceSprite(bBoard:Boolean)
		{
			super();
			
			m_FaceID = 0;
			m_mcFace = null;
			
			m_FrameIdx = 1;
			m_SmallBoard = bBoard;
			
			this.addEventListener(MouseEvent.ROLL_OVER,OnMouseOver);
			this.addEventListener(MouseEvent.ROLL_OUT,OnMouseOut);
		}
		
		public function SetFrame(nFrame:int):void
		{
			if( nFrame>0 && nFrame<=2 )
			{
				m_FrameIdx = nFrame;
				m_mcFace.gotoAndStop(nFrame);
			}
		}		
		private function OnMouseOver(evt:MouseEvent):void
		{
			if( m_SmallBoard )
			{
				if( m_FrameIdx != 2 )
				{
					SetFrame(2);
				}				
				
				var msgC2P:C2P_Flag = new C2P_Flag();
				msgC2P.m_Flag     = C2P_Flag.FaceOver;
				msgC2P.m_Value    = m_FaceID;
				GlobleFunc.SendChildToParent(this,msgC2P);
			}
		}
		private function OnMouseOut(evt:MouseEvent):void
		{
			if( m_SmallBoard )
			{
				SetFrame(1);				
			}
		}
		public function SetFace(nFaceID:int):void
		{
			if(nFaceID>0 && nFaceID!=m_FaceID )
			{
				m_FaceID = nFaceID;
				if( m_mcFace != null )
				{
					this.removeChild(m_mcFace);
					m_mcFace = null;
				}
				
				var TempClass:Class;
				TempClass = GlobleData.S_pResGame.GetResource("FaceIcon_"+nFaceID);
				m_mcFace = new TempClass();
				addChild(m_mcFace);
				
				if( m_SmallBoard )
				{
					m_mcFace.scaleX = 0.8;
					m_mcFace.scaleY = 0.8;
				}
				else
				{
					m_mcFace.scaleX = 2.0;
					m_mcFace.scaleY = 2.0;
				}
				
				SetFrame(1);
			}
		}
		
		public function ShowFace(nFaceID:int,nTime:Number):void
		{
			SetFace(nFaceID);
			SetFrame(2);			
			ShowTime(nTime);
		}
	}
}