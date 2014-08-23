/**Created by the Morn,do not modify.*/
package ui {
	import morn.core.components.*;
	public class ShopUI extends View {
		public var m_tabGift:Tab;
		public var m_btnAll:Button;
		public var m_btnFood:Button;
		public var m_btnShiPing:Button;
		public var m_btnZiChan:Button;
		public var m_btnClose:Button;
		public var m_tCurTime:Label;
		public var m_tLastTime:Label;
		public var m_btnBuySelf:Button;
		public var m_btnSendAllPlayer:Button;
		public var m_btnSendPlayer:Button;
		public var m_btnSendFriend:Button;
		public var m_tName:Label;
		public var m_tBack:Label;
		protected var uiXML:XML =
			<View>
			  <Image url="png.comp.image_shop_back" x="0" y="0" width="703" sizeGrid="20,20,20,20"/>
			  <Image url="png.comp.image_shop_back2" x="4" y="3" width="492" sizeGrid="20,70,20,20" height="462"/>
			  <Tab x="50" y="13" var="m_tabGift">
			    <Button label="全部" skin="png.comp.button_shop tab" labelBold="true" var="m_btnAll" name="item0" labelColors="0x593000,0x593000,0xffffff,0x593000"/>
			    <Button label="食品" skin="png.comp.button_shop tab" x="103" labelBold="true" var="m_btnFood" name="item1" labelColors="0x593000,0x593000,0xffffff,0x593000"/>
			    <Button label="饰品" skin="png.comp.button_shop tab" x="206" labelBold="true" var="m_btnShiPing" name="item2" labelColors="0x593000,0x593000,0xffffff,0x593000"/>
			    <Button label="资产" skin="png.comp.button_shop tab" x="309" labelBold="true" var="m_btnZiChan" name="item3" labelColors="0x593000,0x593000,0xffffff,0x593000"/>
			  </Tab>
			  <Button skin="png.comp.button_box_close" x="679" y="-15" var="m_btnClose"/>
			  <Label x="600" y="146" align="left" width="100" height="19" var="m_tCurTime" color="0xffffff" font="Microsoft YaHei"/>
			  <Label x="600" y="172" align="left" width="100" var="m_tLastTime" color="0xffffff" font="Microsoft YaHei"/>
			  <Button label="自已购买" skin="png.comp.button_green" x="520" y="300" width="160" sizeGrid="6,6,6,6" var="m_btnBuySelf" labelColors="0xffffff,0xffffff,0xffffff,0xffffff" labelFont="Microsoft YaHei" labelBold="true" labelSize="14"/>
			  <Button label="赚送全桌" skin="png.comp.button_green" x="520" y="360" width="160" labelFont="Microsoft YaHei" labelBold="true" labelColors="0xffffff,0xffffff,0xffffff,0xffffff" labelSize="14" var="m_btnSendAllPlayer"/>
			  <Button label="赠送玩家" skin="png.comp.button_green" x="537" y="253" width="160" labelFont="Microsoft YaHei" labelBold="true" labelColors="0xffffff,0xffffff,0xffffff,0xffffff" labelSize="14" var="m_btnSendPlayer"/>
			  <Button label="赠送好友" skin="png.comp.button_green" x="534" y="254" width="160" labelColors="0xffffff,0xffffff,0xffffff,0xffffff" labelFont="Microsoft YaHei" labelBold="true" labelSize="14" var="m_btnSendFriend"/>
			  <Label text="使用有限期：" x="521" y="146" color="0xffffff" font="Microsoft YaHei"/>
			  <Label text="保存有效期：" x="521" y="172" color="0xffffff" font="Microsoft YaHei"/>
			  <Label text="名称：" x="557" y="122" color="0xffffff" font="Microsoft YaHei"/>
			  <Label x="600" y="122" width="100" color="0xffffff" font="Microsoft YaHei" var="m_tName"/>
			  <Label text="系统回收：" x="533" y="194" color="0xffffff" font="Microsoft YaHei"/>
			  <Label x="600" y="194" width="100" color="0xffffff" font="Microsoft YaHei" var="m_tBack"/>
			</View>;
		public function ShopUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}