package UILogic
{
	import flash.display.DisplayObject;
	//import flash.display.MovieClip;
	import flash.geom.Point;
	
	import Data.Data_TableInfo;
	
	import MoGui.display.CText;
	
	import morn.core.components.Clip;
	import morn.core.components.Component;
	import morn.core.components.Image;
	
	public class RoomTableInfoItem extends Component
	{
		public var m_spBack:Clip;
		
		public var m_tID:CText;
		public var m_tTableName:CText;
		public var m_tMangZhu:CText;
		public var m_tGamePlayerNum:CText;
		public var m_tSeePlayerNum:CText;
		public var m_tMinMaxTake:CText;
		public var m_tMarks:CText;
		public var m_spPlayerNum:RoomPlayerProgress;
		
		public var m_ArrayWidth:Array = 
			[
				50,
				100,
				135,
				155,
				50,
				120,
				100
			];
		public var m_ptArray:Vector.<Point>;
		
		public function RoomTableInfoItem()
		{
			super();
			
			var i:uint;
			m_ptArray = new Vector.<Point>(7);

			for(i=0;i<7;++i)
			{
				m_ptArray[i] = new Point();
				if(i == 0)
				{
					m_ptArray[i].x = 0;
					m_ptArray[i].y = 17;
				}
				else
				{
					m_ptArray[i].x = m_ptArray[i-1].x + m_ArrayWidth[i-1];
					m_ptArray[i].y = m_ptArray[0].y;
				}
			}
			
			m_spBack = new Clip("png.comp.clip_listbar",1,3);
			addChild(m_spBack);
			m_spBack.width = 710;
			m_spBack.height = 33;
			
			m_tID = new CText();
			addChild(m_tID);
			m_tID.SetCenterPoint(new Point(m_ptArray[0].x+m_ArrayWidth[0]/2,m_ptArray[0].y));
			
			m_tTableName = new CText();
			addChild(m_tTableName);			
			m_tTableName.SetCenterPoint(new Point(m_ptArray[1].x+m_ArrayWidth[1]/2,m_ptArray[1].y));
			
			m_tMangZhu = new CText();
			addChild(m_tMangZhu);			
			m_tMangZhu.SetCenterPoint(new Point(m_ptArray[2].x+m_ArrayWidth[2]/2,m_ptArray[2].y));
			
			m_tGamePlayerNum = new CText();
			addChild(m_tGamePlayerNum);
			m_tGamePlayerNum.x = m_ptArray[3].x + 5;
			m_tGamePlayerNum.y = 7;
			
			m_spPlayerNum = new RoomPlayerProgress();
			addChild(m_spPlayerNum);
			m_spPlayerNum.x = m_ptArray[3].x + 27;
			m_spPlayerNum.y = 4;
			
			m_tSeePlayerNum = new CText();
			addChild(m_tSeePlayerNum);
			m_tSeePlayerNum.SetCenterPoint(new Point(m_ptArray[4].x+m_ArrayWidth[4]/2,m_ptArray[4].y));
			
			m_tMinMaxTake = new CText();
			addChild(m_tMinMaxTake);
			m_tMinMaxTake.SetCenterPoint(new Point(m_ptArray[5].x+m_ArrayWidth[5]/2,m_ptArray[5].y));
			
			m_tMarks = new CText();
			addChild(m_tMarks);
			m_tMarks.SetCenterPoint(new Point(m_ptArray[6].x+m_ArrayWidth[6]/2,m_ptArray[6].y));
			
			var TempDP:DisplayObject;
			for(i=0;i<this.numChildren;i++)
			{
				TempDP = this.getChildAt(i);
				if( TempDP is CText )
				{
					var TempT:CText = TempDP as CText;
					TempT.SetTextColor(0xffffff);
					TempT.SetFont("宋体");
					TempT.SetTextSize(12);
					TempT.SetBold(false);
					TempT.y     = 7;
				}
			}
		}		
		public function SetSize(nW:Number,nH:Number):void
		{
			m_spBack.width = nW;
			m_spBack.height = nH;
		}
		public function UpdateTableInfo(TI:Data_TableInfo):void
		{
			m_tID.text = String(TI.m_TableID);
			m_tTableName.text = TI.m_TableName;
			m_tMangZhu.text = String(TI.m_SmallBlind)+"/"+String(TI.m_BigBlind);
			m_tGamePlayerNum.text = String(TI.m_CurSitPlayerNumber)+"/"+String(TI.m_MaxSitPlayerNumber);
			m_spPlayerNum.SetProgress(TI.m_MaxSitPlayerNumber,TI.m_CurSitPlayerNumber);
			m_tSeePlayerNum.text = String(TI.m_CurStandPlayerNumber);			
			m_tMinMaxTake.text = String(TI.m_MinTake)+"--"+String(TI.m_MaxTake)+"倍";
			m_tMarks.text = String(TI.m_strMark);
			
		}
	}
}