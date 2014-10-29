package UILogic
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import Data.Data_PlayerInfo;
	
	import Game.msgPlayerGiftInfo;
	
	import L2C.S2L_Flag;
	
	import MoGui.display.CLoadImage;
	import MoGui.display.CText;
	
	import ui.PlayerInfoUI;
	
	public class Box_PlayerInfo extends PlayerInfoUI
	{
		public static var s_Info:int       = 0;
		public static var s_Gift:int       = 1;
		public static var s_Friend:int     = 2;
		
		public static var BTN_CLOSE:int       = 1;
		public static var BTN_SENDGIFT:int    = 2;
		public static var BNT_SELLGIFT:int    = 3;
		
		public var m_SamllHead:CLoadImage;
		public var m_BigHead:CLoadImage;
		public var m_mcGift:MovieClip;
		
		public var m_spMaxPai:Sprite_MaxPai;
		
		public var m_CurPID:int;
		public var m_InfoData:Data_PlayerInfo;
		
		public var m_arrayCurGift:Array
		public var m_arrayPassGift:Array;
		public var m_arrayFriend:Array;
		
		public var m_tFriendCount:CText;
		public var m_ListFI:List_FriendInfo;
		
		public var m_ListCurGift:List_PlayerGift;
		public var m_ListPassGift:List_PlayerGift;
		
		public function Box_PlayerInfo()
		{
			super();
			
			m_CurPID = 0;
			
			m_SamllHead = new CLoadImage(100,100);
			addChild(m_SamllHead);
			m_SamllHead.x = 30;
			m_SamllHead.y = 20;
			m_SamllHead.SetPic("http://tp3.sinaimg.cn/1652809182/180/5596779795/1");
			
			m_BigHead = new CLoadImage(160,160);
			m_Info.addChild(m_BigHead);
			m_BigHead.x = 15;
			m_BigHead.y = 15;
			m_BigHead.SetPic("http://tp3.sinaimg.cn/1652809182/180/5596779795/1");
			
			m_spMaxPai = new Sprite_MaxPai();
			m_Info.addChild(m_spMaxPai);
			m_spMaxPai.x = 270;
			m_spMaxPai.y = 150;
			
			m_InfoData = new Data_PlayerInfo();
			
			m_arrayCurGift = new Array();
			m_arrayPassGift = new Array();
			m_arrayFriend = new Array();
			
			m_ListFI = new List_FriendInfo(4,2);
			m_Friend.addChild(m_ListFI);
			m_ListFI.x = 2;
			m_ListFI.y = 42;
			m_tFriendCount = new CText("黑体",true,0x0061ba,14);
			m_Friend.addChild(m_tFriendCount);
			m_tFriendCount.x = 105;
			m_tFriendCount.y = 18;
			
			m_ListCurGift = new List_PlayerGift(4,2);
			m_spCurGift.addChild(m_ListCurGift);
			m_ListCurGift.x = 2;
			m_ListCurGift.y = 2;
			m_ListPassGift = new List_PlayerGift(4,2);
			m_spPassGift.addChild(m_ListPassGift);
			m_ListPassGift.x = 2;
			m_ListPassGift.y = 2;
			
			m_tab.addEventListener(Event.SELECT,OnTabSelect);
			m_tab.selectedIndex = 0;
			
			m_tabGift.addEventListener(Event.SELECT,OnTabGiftSelect);
			m_tabGift.selectedIndex = 0;
			
			m_btnClose.addEventListener(MouseEvent.CLICK,OnBtnClose);
			
			m_btnSendGift.addEventListener(MouseEvent.CLICK,OnSendGift);
			m_btnSellCurGift.addEventListener(MouseEvent.CLICK,OnSellCurGift);			
			m_btnSellPassGift.addEventListener(MouseEvent.CLICK,OnSellPassGift);
		}
		
		private function OnSendGift(evt:MouseEvent):void
		{
			if( m_CurPID == GlobleData.s_MyPID
				&& m_tab.selectedIndex == s_Friend
			    && m_ListFI.selectedIndex>=0 && m_ListFI.selectedIndex<m_arrayFriend.length ){
				
				var nRecvPID:int = m_arrayFriend[m_ListFI.selectedIndex].m_PID;
				if( nRecvPID > 0 ){
					var msgFlag:S2L_Flag = new S2L_Flag();
					msgFlag.m_Flag     = S2L_Flag.PlayerInfo;
					msgFlag.m_Value    = BTN_SENDGIFT;
					msgFlag.m_msgString = String(nRecvPID);
					GlobleFunc.SendStageToLobby(stage,msgFlag);
				}
			}
		}
		
		private function OnSellCurGift(evt:MouseEvent):void{
			if( m_CurPID == GlobleData.s_MyPID
				&& m_tab.selectedIndex == s_Gift
				&& m_ListCurGift.selectedIndex>=0 && m_ListCurGift.selectedIndex<m_arrayCurGift.length ){				
				var nGiftIdx:int = m_arrayCurGift[m_ListCurGift.selectedIndex].m_GiftIdx;
				if( nGiftIdx > 0 ){
					var msgFlag:S2L_Flag = new S2L_Flag();
					msgFlag.m_Flag     = S2L_Flag.PlayerInfo;
					msgFlag.m_Value    = BNT_SELLGIFT;
					msgFlag.m_msgString = String(nGiftIdx);
					GlobleFunc.SendStageToLobby(stage,msgFlag);
				}
			}			
		}
		private function OnSellPassGift(evt:MouseEvent):void{
			if( m_CurPID == GlobleData.s_MyPID
				&& m_tab.selectedIndex == s_Gift
				&& m_ListPassGift.selectedIndex>=0 && m_ListPassGift.selectedIndex<m_arrayPassGift.length ){				
				var nGiftIdx:int = m_arrayPassGift[m_ListPassGift.selectedIndex].m_GiftIdx;
				if( nGiftIdx > 0 ){
					var msgFlag:S2L_Flag = new S2L_Flag();
					msgFlag.m_Flag     = S2L_Flag.PlayerInfo;
					msgFlag.m_Value    = BNT_SELLGIFT;
					msgFlag.m_msgString = String(nGiftIdx);
					GlobleFunc.SendStageToLobby(stage,msgFlag);
				}
			}			
		}
		
		public function Show(InfoData:Data_PlayerInfo):void
		{
			m_CurPID = InfoData.m_PID;
			//m_InfoData.Copy(InfoData);
			m_InfoData = InfoData;
			
			if( m_CurPID != GlobleData.s_MyPID ){
				m_btnFriend.visible = false;
				m_btnPassGift.visible = false;
			}
			
			m_SamllHead.SetPic(InfoData.m_HeadPicURL);	
			m_BigHead.SetPic(InfoData.m_HeadPicURL);
			if( InfoData.m_GiftID ){
				
			}
			
			m_spMaxPai.ShowMaxPai(InfoData.m_MaxPai.m_arrayPai);
			m_tPaiType.text = GlobleData.S_ArrayPaiType[InfoData.m_MaxPai.m_PaiType];
			
			m_tName.text           = InfoData.m_NickName;
			m_tMoney.text          = "$"+String(InfoData.m_nGameMoney);
			
			m_textNickName.text    = InfoData.m_NickName;
			m_textPID.text         = String(InfoData.m_PID);
			m_textGameMoney.text   = "$"+String(InfoData.m_nGameMoney);
			
			var nTotalTimes:int   = Math.max(InfoData.m_nWinTimes+InfoData.m_nLossTimes,1);
			m_tGameTimes.text      = "赢 "+String(InfoData.m_nWinTimes)+" / 输 "+String(InfoData.m_nLossTimes);
			m_tWinPercent.text     = String( int((InfoData.m_nWinTimes*Number(10000.0))/nTotalTimes)/Number(100.0))+"%";
			
			m_tMaxMoney.text       = "$"+String(InfoData.m_MaxMoney);
			m_tMaxWin.text         = "$"+String(InfoData.m_MaxWin);
			
			m_tBigPaiTime.text     = GlobleFunc.GetDate(InfoData.m_MaxPaiTime);
			m_tMaxMoneyTime.text   = GlobleFunc.GetDate(InfoData.m_MaxMoneyTime);
			m_tMaxWinTime.text     = GlobleFunc.GetDate(InfoData.m_MaxWinTime);
			m_tJoinTime.text       = GlobleFunc.GetDate(InfoData.m_JoinTime);
		}
		public function UpdataFriend():void
		{
			m_arrayFriend.splice(0,m_arrayFriend.length);
			for(var i:int=0;i<m_InfoData.m_arrayFriendInfo.length;++i){
				m_arrayFriend.push(m_InfoData.m_arrayFriendInfo[i]);
			}
			m_ListFI.dataSource = m_arrayFriend;
			m_tFriendCount.SetText(String(m_arrayFriend.length));			
		}
		public function UpdateCurGift():void
		{
			m_arrayCurGift.splice(0,m_arrayCurGift.length);
			for(var i:int=0;i<m_InfoData.m_arrayCurGift.length;++i){
				var TempData:msgPlayerGiftInfo = new msgPlayerGiftInfo();
				TempData.Copy(m_InfoData.m_arrayCurGift[i]);
				m_arrayCurGift.push(TempData);
			}
			m_arrayCurGift.sortOn("m_GiftIdx",Array.NUMERIC | Array.DESCENDING);
			m_ListCurGift.dataSource = m_arrayCurGift;
		}
		public function UpdatePassGift():void
		{
			m_arrayPassGift.splice(0,m_arrayPassGift.length);
			for(var i:int=0;i<m_InfoData.m_arrayPassGift.length;++i){
				var TempData:msgPlayerGiftInfo = new msgPlayerGiftInfo();
				TempData.Copy(m_InfoData.m_arrayPassGift[i]);
				m_arrayPassGift.push(TempData);
			}
			m_arrayPassGift.sortOn("m_GiftIdx",Array.NUMERIC | Array.DESCENDING);
			m_ListPassGift.dataSource = m_arrayPassGift;
		}
		
		private function OnTabSelect(evt:Event):void
		{
			m_viewstack.selectedIndex = m_tab.selectedIndex;
			
			if( m_tab.selectedIndex == s_Info ){
			}
			else if( m_tab.selectedIndex == s_Gift ){
			}
			else if( m_tab.selectedIndex == s_Friend ){
				UpdataFriend();
			}
			else{
			}
		}
		private function OnTabGiftSelect(evt:Event):void
		{
			m_viewGift.selectedIndex = m_tabGift.selectedIndex;
		}
		private function OnBtnClose(evt:MouseEvent):void
		{
			var msgFlag:S2L_Flag = new S2L_Flag();
			msgFlag.m_Flag       = S2L_Flag.PlayerInfo;
			msgFlag.m_Value      = BTN_CLOSE;
			GlobleFunc.SendStageToLobby(stage,msgFlag);
		}
	}
}