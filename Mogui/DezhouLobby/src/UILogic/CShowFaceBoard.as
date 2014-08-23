package UILogic
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import L2C.C2P_Flag;
	import L2C.S2C_Flag;
	
	import MoGui.display.CText;
	import MoGui.net.MsgData;
	
	import Data.Data_FaceInfo;
	
	import events.ChildToParent;
	
	public class CShowFaceBoard extends Sprite
	{
		public var m_OutTime:int;
		
		private var m_spBack:Sprite;
		private var m_arrayFaceID:Vector.<int>;
		private var m_arrayFaceSprite:Vector.<CFaceSprite>;
		private var m_arrayFaceInfo:Vector.<Data_FaceInfo>;
		
		private var m_tFaceName:CText;
		
		public function CShowFaceBoard()
		{
			super();
			
			m_OutTime = 0;
			
			m_spBack = null;
			m_arrayFaceID = new Vector.<int>(20);
			m_arrayFaceSprite = new Vector.<CFaceSprite>(20);
			m_arrayFaceInfo = new Vector.<Data_FaceInfo>();
			
			var TempClass:Class;
			
			TempClass = GlobleData.S_pResGame.GetResource("FacePanelBG");
			m_spBack = new TempClass();
			addChild(m_spBack);	
			
			m_tFaceName = new CText();
			addChild(m_tFaceName);
			m_tFaceName.SetTextSize(16);
			m_tFaceName.SetCenterPoint(new Point(100,195));
			
			for(var i:int=0;i<20;i++)
			{
				var TempFaceID:int = i+1;
				m_arrayFaceSprite[i] = new CFaceSprite(true);
				var TempFS:CFaceSprite = m_arrayFaceSprite[i];
				TempFS.SetFace(TempFaceID);
				addChild(TempFS);
				TempFS.x = 10 + (i%5)*38;
				TempFS.y = 40 + Math.floor(i/5)*36;				
				
				TempFS.addEventListener(MouseEvent.CLICK,OnFaceClick);
				TempFS.addEventListener(ChildToParent.EVENT_ID,OnChildToParent);
			}
			
			this.addEventListener(MouseEvent.ROLL_OUT,OnMouseOut);
		}
		
		public function InitFaceInfo(arrayInfo:Vector.<Data_FaceInfo>):void
		{
			for(var i:int=0;i<arrayInfo.length;++i)
			{
				var dataFI:Data_FaceInfo = new Data_FaceInfo();
				dataFI.m_FaceID       = arrayInfo[i].m_FaceID;
				dataFI.m_FaceName     = arrayInfo[i].m_FaceName;
				m_arrayFaceInfo.push(dataFI);
			}
		}
		public function GetFaceName(nFaceID:int):String
		{
			var strRet:String = "";
			for(var i:int=0;i<m_arrayFaceInfo.length;++i)
			{
				if( nFaceID == m_arrayFaceInfo[i].m_FaceID )
				{
					strRet = m_arrayFaceInfo[i].m_FaceName;
					break;
				}
			}
			return strRet;
		}
		
		public function OnChildToParent(evt:ChildToParent):void
		{
			var msgData:MsgData = evt.m_msgData;
			msgData.ResetDataPosition();
			switch(msgData.m_msgID)
			{
				case C2P_Flag.ID:
				{
					OnFaceOver(msgData);
				}
				default:
			}
		}
		public function OnFaceOver(msgData:MsgData):void
		{
			var msgFlag:C2P_Flag = new C2P_Flag();
			msgFlag.Read(msgData);
			
			m_tFaceName.text = "表情：" + GetFaceName(int(msgFlag.m_Value));
		}
		public function OnMouseOut(evt:MouseEvent):void
		{
			for(var i:int=0;i<20;i++)
			{
				if( m_arrayFaceSprite[i].m_FrameIdx == 2 )
				{
					m_arrayFaceSprite[i].SetFrame(1);
				}
			}
			m_tFaceName.text = "";
		}		
		public function OnFaceClick(evt:MouseEvent):void
		{
			var TempFS:CFaceSprite = evt.currentTarget as CFaceSprite;
			
			var msgFlag:S2C_Flag = new S2C_Flag();
			msgFlag.m_Flag        = S2C_Flag.ShowFace;
			msgFlag.m_Value       = TempFS.m_FaceID;
			GlobleFunc.SendStageToClient(stage,msgFlag);
			
			this.visible = false;
		}
	}
}