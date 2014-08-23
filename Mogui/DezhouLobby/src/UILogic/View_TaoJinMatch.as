package UILogic
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import Data.Data_TableInfo;
	import Data.Data_TablePlayerCount;
	import Game.Game_MatchTableState;	
	
	import morn.core.components.Button;
	
	public class View_TaoJinMatch extends ViewSprite
	{
		public var m_RoomID:int;
		
		public var m_Idx:int;                         //指当前VIEW的序号从0开始算起
		
		public var m_HaveTableInfo:int;
		
		public var m_spTitleBack:Sprite;
		
		public var m_btnID:Button;
		public var m_btnName:Button;
		public var m_btnState:Button;
		public var m_btnGameNum:Button;
		public var m_btnSeeNum:Button;
		public var m_btnTakeMoney:Button;
		public var m_btnTicket:Button;
		public var m_btnHongBao:Button;
		
		public var m_arrayTableInfo:Array;
		public var m_arrayShowTI:Array;
		public var m_listRoomTableInfo:List_MatchTableInfo;
		
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
		
		public function View_TaoJinMatch()
		{
			super();
			
			m_RoomID = 0;
			m_Place = DeZhouDef.Place_TaoJingMatch;
			
			m_HaveTableInfo = 0;
			
			var TempClass:Class;
			TempClass = GlobleData.S_pResLobby.GetResource("RoomTitleBG");
			m_spTitleBack = new TempClass();
			addChild(m_spTitleBack);
			m_spTitleBack.x = -2;
			m_spTitleBack.width = 728;
			m_spTitleBack.height = 24;
			
			m_btnID = new Button("png.comp.button_01","ID");
			this.addChild(m_btnID);
			m_btnID.x = 0;
			m_btnID.width = m_ArrayWidth[0];
			
			m_btnName = new Button("png.comp.button_01","房间名");
			this.addChild(m_btnName);			
			m_btnName.x = m_btnID.x + m_btnID.width;
			m_btnName.width = m_ArrayWidth[1];
			
			m_btnState = new Button("png.comp.button_01","比赛状态");
			this.addChild(m_btnState);			
			m_btnState.x = m_btnName.x + m_btnName.width;
			m_btnState.width = m_ArrayWidth[2];			
			
			m_btnGameNum = new Button("png.comp.button_01","游戏玩家");
			this.addChild(m_btnGameNum);			
			m_btnGameNum.x = m_btnState.x + m_btnState.width;
			m_btnGameNum.width = m_ArrayWidth[3];
			
			m_btnSeeNum = new Button("png.comp.button_01","旁观");
			this.addChild(m_btnSeeNum);			
			m_btnSeeNum.x = m_btnGameNum.x + m_btnGameNum.width;
			m_btnSeeNum.width = m_ArrayWidth[4];
			
			m_btnTakeMoney = new Button("png.comp.button_01","参赛带入");
			this.addChild(m_btnTakeMoney);			
			m_btnTakeMoney.x = m_btnSeeNum.x + m_btnSeeNum.width;
			m_btnTakeMoney.width = m_ArrayWidth[5];
			
			m_btnTicket = new Button("png.comp.button_01","服务费");
			this.addChild(m_btnTicket);			
			m_btnTicket.x = m_btnTakeMoney.x + m_btnTakeMoney.width;
			m_btnTicket.width = m_ArrayWidth[6];
			
			m_btnHongBao = new Button("png.comp.button_01","红包");
			this.addChild(m_btnHongBao);			
			m_btnHongBao.x = m_btnTicket.x + m_btnTicket.width;
			m_btnHongBao.width = m_ArrayWidth[7];
			
			var TempDP:DisplayObject;
			for(var i:uint;i<this.numChildren;i++)
			{
				TempDP = this.getChildAt(i);
				if( TempDP is Button )
				{
					(TempDP as Button).labelBold = true;
					(TempDP as Button).labelColors = "0xffffff,0xffffff,0xffffff,0xffffff";
					(TempDP as Button).btnLabel.alpha = 0.5;
				}
			}
			
			TempClass = GlobleData.S_pResLobby.GetResource("RoomTitleSeparator");
			var SeparatorArray:Array = new Array(7);
			for( i=0; i<7; i++ )
			{
				SeparatorArray[i] = new TempClass();
				addChild(SeparatorArray[i]);
				SeparatorArray[i].y = 1;
			}
			SeparatorArray[0].x = m_btnName.x;
			SeparatorArray[1].x = m_btnState.x;
			SeparatorArray[2].x = m_btnGameNum.x;
			SeparatorArray[3].x = m_btnSeeNum.x;
			SeparatorArray[4].x = m_btnTakeMoney.x;
			SeparatorArray[5].x = m_btnTicket.x;
			SeparatorArray[6].x = m_btnHongBao.x;
			
			m_arrayTableInfo = new Array();
			m_arrayShowTI = new Array();
			
			m_listRoomTableInfo = new List_MatchTableInfo(9);
			addChild(m_listRoomTableInfo);
			m_listRoomTableInfo.y = m_spTitleBack.height;	
		}
		
		public function GetTableInfo(tableid:int):Data_TableInfo
		{
			for(var i:int=0;i<m_arrayTableInfo.length;++i)
			{
				if( (m_arrayTableInfo[i] as Data_TableInfo).m_TableID == tableid )
				{
					return m_arrayTableInfo[i];
				}
			}
			return null;
		}
		
		public function AddTableInfo(dataTI:Data_TableInfo):void
		{
			var findTI:Data_TableInfo = GetTableInfo(dataTI.m_TableID);
			if( findTI != null )
			{
				findTI = dataTI;
			}
			else
			{
				m_arrayTableInfo.push(dataTI);
			}
		}
		public function SetShowFlag(tableid:int,showflag:int):void
		{
			var findTI:Data_TableInfo = GetTableInfo(tableid);
			if( findTI != null )
			{
				findTI.m_ShowFlag = showflag;
			}
			else
			{
				GlobleFunc.LogError("ShowTable",tableid,showflag);
			}
		}
		public function UpdateAllTable():void
		{
			m_arrayShowTI.length = 0;
			var TempTI:Data_TableInfo;
			var i:int;
			var j:int;
			for(i;i<m_arrayTableInfo.length;++i)
			{
				TempTI = m_arrayTableInfo[i] as Data_TableInfo;
				if( TempTI.m_ShowFlag == 0 )
				{
					continue;
				}
				
				TempTI.InitMatchRank();
				m_arrayShowTI.push(TempTI);
			}
			
			m_arrayShowTI.sortOn("m_MatchRank",Array.DESCENDING | Array.NUMERIC);			
			m_listRoomTableInfo.dataSource = m_arrayShowTI;
		}
		
		public function UpdateMatchState(msgState:Game_MatchTableState):void
		{
			var TempTI:Data_TableInfo = GetTableInfo(msgState.m_TableID);		
			if( m_RoomID==msgState.m_RoomID && TempTI!=null )
			{
				TempTI.m_MatchState = msgState.m_TableState;
				UpdateAllTable();
			}
		}
		
		public function UpdatePlayerCount(msgdata:Data_TablePlayerCount):void
		{
			var i:int;
			var TempTI:Data_TableInfo;
			var bFind:Boolean = false;
			for( i=0;i<m_arrayTableInfo.length;++i)
			{
				TempTI = m_arrayTableInfo[i] as Data_TableInfo;
				if( TempTI.m_RoomID==msgdata.m_RoomID && TempTI.m_TableID==msgdata.m_TableID )
				{
					bFind = true;
					TempTI.m_CurSitPlayerNumber = msgdata.m_SitPlayer;
					TempTI.m_CurStandPlayerNumber = msgdata.m_SeePlayer;
					break;
				}
			}
			if( !bFind ) GlobleFunc.LogError("UpdatePlayerCount m_arrayTableInfo",msgdata.m_RoomID,msgdata.m_TableID);
			
			bFind = false;
			for( i=0;i<m_arrayShowTI.length;++i)
			{
				TempTI = m_arrayShowTI[i] as Data_TableInfo;
				if( TempTI.m_RoomID==msgdata.m_RoomID && TempTI.m_TableID==msgdata.m_TableID )
				{
					bFind = true;
					TempTI.m_CurSitPlayerNumber = msgdata.m_SitPlayer;
					TempTI.m_CurStandPlayerNumber = msgdata.m_SeePlayer;
					break;
				}
			}
			
			if( bFind )
			{
				m_listRoomTableInfo.dataSource = m_arrayShowTI;
			}		
		}		
	}
}