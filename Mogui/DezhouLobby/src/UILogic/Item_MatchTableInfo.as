package UILogic
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	import Data.Data_TableInfo;
	
	import MoGui.display.CRoundRect;
	import MoGui.display.CText;
	
	import morn.core.components.Clip;
	import morn.core.components.Component;
	
	public class Item_MatchTableInfo extends Component
	{
		public var m_spBack:Clip;
		
		public var m_tID:CText;
		public var m_tTableName:CText;
		public var m_tMatchState:CText;
		public var m_tGamePlayerNum:CText;
		public var m_tSeePlayerNum:CText;
		public var m_tTakeMoney:CText;
		public var m_tTickMoney:CText;
		public var m_tHongBao:CText;
		public var m_spPlayerNum:RoomPlayerProgress;
		
		public var m_spMask:CRoundRect;
		
		public var m_ArrayWidth:Array = 
			[
				50,
				100,
				95,
				140,
				50,
				105,
				75,
				95
			];
		public var m_ptArray:Vector.<Point>;
		
		public function Item_MatchTableInfo()
		{
			super();
			
			var i:uint;
			m_ptArray = new Vector.<Point>(8);
			
			for(i=0;i<8;++i)
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
			
			m_tMatchState = new CText();
			addChild(m_tMatchState);			
			m_tMatchState.SetCenterPoint(new Point(m_ptArray[2].x+m_ArrayWidth[2]/2,m_ptArray[2].y));
			
			m_tGamePlayerNum = new CText();
			addChild(m_tGamePlayerNum);
			m_tGamePlayerNum.x = m_ptArray[3].x + 5;
			m_tGamePlayerNum.y = 10;
			
			m_spPlayerNum = new RoomPlayerProgress();
			addChild(m_spPlayerNum);
			m_spPlayerNum.x = m_ptArray[3].x + 27;
			m_spPlayerNum.y = 12;
			
			m_tSeePlayerNum = new CText();
			addChild(m_tSeePlayerNum);
			m_tSeePlayerNum.SetCenterPoint(new Point(m_ptArray[4].x+m_ArrayWidth[4]/2,m_ptArray[4].y));
			
			m_tTakeMoney = new CText();
			addChild(m_tTakeMoney);
			m_tTakeMoney.SetCenterPoint(new Point(m_ptArray[5].x+m_ArrayWidth[5]/2,m_ptArray[5].y));
			
			m_tTickMoney = new CText();
			addChild(m_tTickMoney);
			m_tTickMoney.SetCenterPoint(new Point(m_ptArray[6].x+m_ArrayWidth[6]/2,m_ptArray[6].y));
			
			m_tHongBao = new CText();
			addChild(m_tHongBao);
			m_tHongBao.SetCenterPoint(new Point(m_ptArray[7].x+m_ArrayWidth[7]/2,m_ptArray[7].y));
			
//			var TempDP:DisplayObject;
//			for(i=0;i<this.numChildren;i++)
//			{
//				TempDP = this.getChildAt(i);
//				if( TempDP is CText )
//				{
//					var TempT:CText = TempDP as CText;
//					TempT.SetTextColor(0xffffff);
//					TempT.SetFont("宋体");
//					TempT.SetTextSize(12);
//					TempT.SetBold(false);
//					TempT.y     = 7;
//				}
//			}
			
			m_spMask = new CRoundRect();
			m_spMask.Draw(0x000000,710,33,5,5);
			addChild(m_spMask);
			m_spMask.alpha = 0.15;
		}
		
		public function UpdateTableInfo(TI:Data_TableInfo):void
		{
			m_tID.text = String(TI.m_TableID);
			m_tTableName.text = TI.m_TableName;
			if( TI.m_MatchState == DeZhouDef.MatchTable_ST_None )
			{
				m_tMatchState.text = "错误";
				m_spMask.visible = false;
			}
			else if( TI.m_MatchState == DeZhouDef.MatchTable_ST_WaitSign )
			{
				m_tMatchState.SetTextColor(0x71fc01);
				m_tMatchState.text = "准备比赛";
				m_spMask.visible = false;
			}
			else if( TI.m_MatchState == DeZhouDef.MatchTable_ST_Matching )
			{
				m_tMatchState.SetTextColor(0xffc600);
				m_tMatchState.text = "比赛中";
				m_spMask.visible = true;
			}
			else if( TI.m_MatchState == DeZhouDef.MatchTable_ST_MatchOver )
			{
				m_tMatchState.text = "比赛结束";
				m_spMask.visible = true;
			}
			
			m_tGamePlayerNum.text = String(TI.m_CurSitPlayerNumber)+"/"+String(TI.m_MaxSitPlayerNumber);
			m_spPlayerNum.SetProgress(TI.m_MaxSitPlayerNumber,TI.m_CurSitPlayerNumber);
			m_tSeePlayerNum.text = String(TI.m_CurStandPlayerNumber);
			m_tTakeMoney.text = String(TI.m_MatchTakeMoney);			
			m_tTickMoney.text = String(TI.m_Ticket);
			m_tHongBao.text   = String(TI.m_HongBao);			
		}
	}
}