package UILogic
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	import Game.msgPlayerGiftInfo;
	
	import MoGui.display.CText;
	
	import morn.core.components.Clip;
	import morn.core.components.Component;
	
	public class Item_PlayerGift extends Component
	{
		public var m_spBack:Clip;
		public var m_mcGift:MovieClip;
		
		public var m_GiftID:int;
		public var m_GiftIdx:int;
		
		public var m_tNickName:CText
		public var m_tPrice:CText;
		public var m_tActionTime:CText;
		
		public function Item_PlayerGift()
		{
			super();
			
			m_GiftID = 0;
			m_GiftIdx = 0;
			m_spBack = new Clip("png.comp.clip_giftback",1,3);
			addChild(m_spBack);
			
			m_mcGift = null;
			
			m_tPrice = new CText("黑体",false,0xff6100,14);
			addChild(m_tPrice);
			m_tNickName = new CText("黑体",false,0x292929,14);
			addChild(m_tNickName);
			m_tActionTime = new CText("黑体",false,0x666666,12);
			addChild(m_tActionTime);
			
			m_tPrice.SetCenterPoint(new Point(60,100));
			m_tNickName.SetCenterPoint(new Point(60,120));
			m_tActionTime.SetCenterPoint(new Point(60,140));
		}
		
		public function Update(PGI:msgPlayerGiftInfo):void
		{
			if( m_GiftID != PGI.m_GiftID ){
				var TempClass:Class;
				TempClass = GlobleData.S_pResLobby.GetResource("Gift_"+String(PGI.m_GiftID));
				if( m_mcGift && m_mcGift.parent ){
					this.removeChild(m_mcGift);
				}
				m_mcGift = new TempClass();
				addChild(m_mcGift);
				m_mcGift.x = 18;
				m_mcGift.y = 12;
			}
			m_GiftID = PGI.m_GiftID;
			m_GiftIdx = PGI.m_GiftIdx;
			
			m_tPrice.SetText("$"+String(PGI.m_Price));
			m_tNickName.SetText(PGI.m_NickName+" 赠");
			
			var CurDate:Date = new Date();
			var ActionDate:Date = new Date(PGI.m_ActionTime*Number(1000));
			if( CurDate.getUTCFullYear() == ActionDate.getUTCFullYear()
			    && CurDate.month == ActionDate.month
			    && CurDate.date == ActionDate.date ){
				m_tActionTime.SetText(GlobleFunc.GetTime_XXYYZZ(PGI.m_ActionTime));
				//m_tActionTime.SetText(String(ActionDate.hours)+":"+String(ActionDate.minutes)+":"+String(ActionDate.seconds));
			}
			else{
				m_tActionTime.SetText(GlobleFunc.GetDate_XXYYZZ(PGI.m_ActionTime));
				//m_tActionTime.SetText(String(ActionDate.getUTCFullYear())+"."+String(ActionDate.month)+"."+String(ActionDate.date));
			}			
		}
	}
}

