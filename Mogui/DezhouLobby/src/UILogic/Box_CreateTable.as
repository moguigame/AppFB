package UILogic
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import Game.Game_ReqCreateTable;
	
	import L2C.S2L_Flag;
	
	import ui.CreateTableUI;
	
	public class Box_CreateTable extends CreateTableUI
	{
		public var m_GameMoney:Number;
		
		public var m_arrayTime:Array;
		public var m_arrayBlind:Array;	
		
		public var m_nFee:int;        //创建房间所需要的费用
		public var m_bUsePW:Boolean;  //是否使用密码
		public var m_TableTime:int;   //以小时记
		public var m_Blind:int;       //盲注大小
		
		public var m_TiShi:TimeShowTishi;
		public var m_TimeMask:TimeMask;
		
		public function Box_CreateTable()
		{
			super();
			
			m_GameMoney = 0;
			
			m_arrayBlind = new Array(200,500,1000,2000,5000,10000,20000,50000,100000);
			m_arrayTime = new Array(4,6,8,12,16,24);
			
			m_combBlind.labels = "100/200,250/500,500/1000,1000/2000,2500/5000,5000/10000,10000/20000,25000/50000,50000/100000";
			m_combTime.labels  = "4小时,6小时,8小时,12小时,16小时,24小时";
			
			m_bUsePW = false;
			m_TableTime = 12;
			m_Blind = 2000;
			m_nFee = 0;
			
			//m_combBlind.selectedIndex = 3;
			//m_combTime.selectedIndex  = 3;
			m_CheckPW.selected = false;
			m_textPW.editable = false;
			m_textPW.text = "";
			m_textPW.restrict="0123456789";
			
			m_TiShi = new TimeShowTishi();
			addChild(m_TiShi);
			m_TiShi.x = 0;
			m_TiShi.y = 320;
			m_TiShi.m_tTishi.SetCenterPoint(new Point(230,0));
			m_TiShi.m_tTishi.SetText("");
			m_TiShi.m_tTishi.SetTextSize(16);
			m_TiShi.m_tTishi.SetBold(true);
			m_TiShi.m_tTishi.SetTextColor(0xff0000);
			
			
			m_TimeMask = new TimeMask(460,440);
			addChild(m_TimeMask);
			m_TimeMask.m_mask.alpha = 0.2;
			m_TimeMask.visible = false;
			
			m_btnClose.addEventListener(MouseEvent.CLICK,OnBtnClose);
			m_combTime.addEventListener(Event.SELECT,OnTimeSelect);
			m_combBlind.addEventListener(Event.SELECT,OnBlindSelect);
			m_CheckPW.addEventListener(MouseEvent.CLICK,OnPWCheck);
			m_btnCreateTableOK.addEventListener(MouseEvent.CLICK,OnBtnCreateTable);
			
			UpdateFee();
		}
		
		public function OnTime(nTime:int):void
		{
			m_TiShi.OnTime(nTime);
			m_TimeMask.OnTime(nTime);
		}
		
		private function OnBtnCreateTable(evt:MouseEvent):void
		{
			if( m_nFee == 0 )
			{
				UpdateFee();
			}
			if( m_GameMoney >= m_nFee )
			{
				addChild(m_TimeMask);
				m_TimeMask.ShowTime(1500);
				
				var msgCT:Game_ReqCreateTable = new Game_ReqCreateTable();
				msgCT.m_nBigBlind = m_arrayBlind[m_combBlind.selectedIndex];
				msgCT.m_nLastTime = m_arrayTime[m_combTime.selectedIndex];				
				msgCT.m_nMinTake = 100;
				msgCT.m_nMaxTake = 1000;
				GlobleFunc.SendStageToLobby(stage,msgCT);
				
			}
			else
			{
				m_TiShi.m_tTishi.SetText("你的游戏币不够创当前房间");
				m_TiShi.ShowTime(3000);
			}
		}
		private function UpdateFee():void
		{
			var nTime:int   = m_arrayTime[m_combTime.selectedIndex];
			var nBliend:int = m_arrayBlind[m_combBlind.selectedIndex];
			m_nFee = GlobleData.s_OneHourBlind * nBliend * nTime;
			m_nFee = Math.max(m_nFee,GlobleData.s_MinPay);
			m_nFee = Math.min(m_nFee,GlobleData.s_MaxPay);
			m_textFee.text = String(m_nFee);
		}
		private function OnBtnClose(evt:MouseEvent):void
		{
			var msgFlag:S2L_Flag = new S2L_Flag();
			msgFlag.m_Flag       = S2L_Flag.CreateTable_Close;
			GlobleFunc.SendStageToLobby(stage,msgFlag);
		}	
		private function OnTimeSelect(evt:Event):void
		{
			UpdateFee();
		}
		private function OnBlindSelect(evt:Event):void
		{
			UpdateFee();
		}
		private function OnPWCheck(evt:MouseEvent):void
		{
			trace(m_CheckPW.selected);
			if( m_CheckPW.selected )
			{
				m_textPW.editable = true;
				m_textPW.text = "";
			}
			else
			{
				m_textPW.editable = false;
				m_textPW.text = "";
			}
		}
	}
}