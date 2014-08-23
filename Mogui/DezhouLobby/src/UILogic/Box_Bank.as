package UILogic
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import Game.Game_RespChangeBank;
	
	import L2C.S2L_Flag;
	
	import ui.UI_BankUI;
	
	public class Box_Bank extends UI_BankUI
	{
		public var m_BankMoney:Number;
		public var m_GameMoney:Number;
		
		private var m_TiShi:TimeShowTishi;
		private var m_TimeMask:TimeMask;
		
		public function Box_Bank()
		{
			super();
			
			m_tab.addEventListener(Event.SELECT,OnTabSelect);
			m_tab.selectedIndex = 0;
			
			m_btnOutAll.addEventListener(MouseEvent.CLICK,OnBtnOutAll);
			m_btnInAll.addEventListener(MouseEvent.CLICK,OnBtnInAll);
			m_btnIn.addEventListener(MouseEvent.CLICK,OnBtnIn);
			m_btnOut.addEventListener(MouseEvent.CLICK,OnBtnOut);
			
			m_btnClose.addEventListener(MouseEvent.CLICK,OnBtnClose);
			
			m_TiShi = new TimeShowTishi();
			addChild(m_TiShi);
			m_TiShi.m_tTishi.SetText("");
			m_TiShi.m_tTishi.SetTextSize(14);
			m_TiShi.m_tTishi.SetBold(true);
			m_TiShi.m_tTishi.SetTextColor(0xff0000);
			m_TiShi.x = 150;
			m_TiShi.y = 208;
			
			m_TimeMask = new TimeMask(440,360);
			addChild(m_TimeMask);
			m_TimeMask.m_mask.alpha = 0.2;
			m_TimeMask.visible = false;
		}
		
		public function Show(gamemoney:Number,bankmoney:Number):void
		{
			m_GameMoney = gamemoney;
			m_BankMoney = bankmoney;
			
			m_tGameMoney.text = String(m_GameMoney);
			m_tBankMoney.text = String(m_BankMoney);
			
			m_textOut.text = "";
			m_textIn.text  = "";
		}
		public function OnTime(nTime:int):void
		{
			m_TiShi.OnTime(nTime);
			m_TimeMask.OnTime(nTime);
		}
		
		private function OnTabSelect(evt:Event):void
		{
			m_viewstack.selectedIndex = m_tab.selectedIndex;
		}
		
		private function OnBtnOutAll(evt:MouseEvent):void
		{
			m_textOut.text = String(m_BankMoney);
		}
		private function OnBtnInAll(evt:MouseEvent):void
		{
			m_textIn.text = String(m_GameMoney);
		}
		private function OnBtnIn(evt:MouseEvent):void
		{
			var InMoney:Number = Number(m_textIn.text);
			if( InMoney>m_GameMoney || InMoney<=0 )
			{
				if( InMoney<=0  )          m_TiShi.m_tTishi.SetText("存款数额必须大于0");
				if( InMoney>m_GameMoney  ) m_TiShi.m_tTishi.SetText("存款数额必须小于身上的游戏币");
				
				m_TiShi.ShowTime(3000);
			}
			else
			{
				addChild(m_TimeMask);
				m_TimeMask.ShowTime(1200);
				
				var msgFlag:S2L_Flag = new S2L_Flag();
				msgFlag.m_Flag       = S2L_Flag.Bank_In;
				msgFlag.m_Value      = InMoney;
				GlobleFunc.SendStageToLobby(stage,msgFlag);
			}
		}
		private function OnBtnOut(evt:MouseEvent):void
		{
			var OutMoney:Number = Number(m_textOut.text);
			if( OutMoney>m_BankMoney || OutMoney<=0 )
			{
				if( OutMoney<=0  )          m_TiShi.m_tTishi.SetText("取款数额必须大于0");
				if( OutMoney>m_BankMoney  ) m_TiShi.m_tTishi.SetText("取款数额必须小于银行的游戏币");
				
				m_TiShi.ShowTime(3000);
			}
			else
			{
				addChild(m_TimeMask);
				m_TimeMask.ShowTime(1200);
				
				var msgFlag:S2L_Flag = new S2L_Flag();
				msgFlag.m_Flag       = S2L_Flag.Bank_Out;
				msgFlag.m_Value      = OutMoney;
				GlobleFunc.SendStageToLobby(stage,msgFlag);
			}
		}
		private function OnBtnClose(evt:MouseEvent):void
		{
			var msgFlag:S2L_Flag = new S2L_Flag();
			msgFlag.m_Flag       = S2L_Flag.Bank_Close;
			GlobleFunc.SendStageToLobby(stage,msgFlag);
		}
		
		public function OnBankChange(msgCB:Game_RespChangeBank):void
		{
			if( msgCB.m_Flag == Game_RespChangeBank.SUCCESS 
				&& msgCB.m_nGameMoney+msgCB.m_nBankMoney==m_GameMoney+m_BankMoney )
			{
				if( msgCB.m_nGameMoney > m_GameMoney )
				{
					m_TiShi.m_tTishi.SetText("取款 "+String(msgCB.m_nChangeMoney)+" 成功");
					m_TiShi.ShowTime(3000);
					
					m_textOut.text = "";
				}
				else
				{
					m_TiShi.m_tTishi.SetText("存款 "+String(msgCB.m_nChangeMoney)+" 成功");
					m_TiShi.ShowTime(3000);
					
					m_textIn.text  = "";
				}
				
				m_GameMoney = msgCB.m_nGameMoney;
				m_BankMoney = msgCB.m_nBankMoney;
				
				m_tGameMoney.text = String(m_GameMoney);
				m_tBankMoney.text = String(m_BankMoney);
			}
			else
			{
				
			}
		}
	}
}