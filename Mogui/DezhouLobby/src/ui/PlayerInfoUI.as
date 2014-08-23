/**Created by the Morn,do not modify.*/
package ui {
	import morn.core.components.*;
	public class PlayerInfoUI extends View {
		public var m_tab:Tab;
		public var m_btnFriend:Button;
		public var m_tName:Label;
		public var m_tMoney:Label;
		public var m_viewstack:ViewStack;
		public var m_Info:Box;
		public var m_textNickName:Label;
		public var m_textPID:Label;
		public var m_textGameMoney:Label;
		public var m_tGameTimes:Label;
		public var m_tMaxMoney:Label;
		public var m_tMaxWin:Label;
		public var m_tJoinTime:Label;
		public var m_tMaxWinTime:Label;
		public var m_tMaxMoneyTime:Label;
		public var m_tBigPaiTime:Label;
		public var m_tWinPercent:Label;
		public var m_tPaiType:Label;
		public var m_Gift:Box;
		public var m_tabGift:Tab;
		public var m_btnCurGift:Button;
		public var m_btnPassGift:Button;
		public var m_viewGift:ViewStack;
		public var m_spCurGift:Panel;
		public var m_btnSetCurGift:Button;
		public var m_btnSellCurGift:Button;
		public var m_spPassGift:Panel;
		public var m_btnSellPassGift:Button;
		public var m_Friend:Box;
		public var m_btnSendGift:Button;
		public var m_btnClose:Button;
		protected var uiXML:XML =
			<View x="0">
			  <Image url="png.comp.image_box_bg1" x="0" y="0" sizeGrid="10,10,10,10" width="700" height="465"/>
			  <Tab x="25" y="185" var="m_tab">
			    <Button skin="png.comp.button_box_gift" y="55" name="item1"/>
			    <Button skin="png.comp.button_box_friend" y="110" name="item2" var="m_btnFriend"/>
			    <Button skin="png.comp.button_box_info" name="item0"/>
			  </Tab>
			  <Label text="魔鬼游戏师" x="28" y="122" color="0xffffff" width="100" height="19" align="center" var="m_tName"/>
			  <Label text="$1234567" x="28" y="145" color="0xff9900" width="100" align="center" var="m_tMoney"/>
			  <ViewStack x="142" y="1" var="m_viewstack">
			    <Box name="item0" var="m_Info">
			      <Image url="png.comp.image_box_bg2" sizeGrid="10,10,10,10" width="553" height="458"/>
			      <Label text="昵称：" x="183" y="20" font="Microsoft YaHei"/>
			      <Label text="数字帐号：" x="356" y="20" font="Microsoft YaHei"/>
			      <Label text="筹码：" x="183" y="58" font="Microsoft YaHei"/>
			      <Label text="等级：" x="183" y="96" font="Microsoft YaHei"/>
			      <Label text="最大手牌：" x="98" y="271" font="Microsoft YaHei"/>
			      <Label text="最大手牌：" x="183" y="137" font="Microsoft YaHei"/>
			      <Label text="胜率：" x="306" y="226" font="Microsoft YaHei"/>
			      <Label text="游戏局数：" x="98" y="226" font="Microsoft YaHei"/>
			      <Label text="最大筹码：" x="98" y="316" font="Microsoft YaHei"/>
			      <Label text="时间：" x="306" y="316" font="Microsoft YaHei"/>
			      <Label text="最多赢取筹码：" x="74" y="361" font="Microsoft YaHei"/>
			      <Label text="时间：" x="306" y="361" font="Microsoft YaHei"/>
			      <Label text="加入游戏时间：" x="74" y="404" font="Microsoft YaHei"/>
			      <Label text="昵称" x="219" y="20" width="120" var="m_textNickName" color="0xff" font="Microsoft YaHei"/>
			      <Label text="数字帐号：" x="418" y="20" width="100" var="m_textPID" color="0xff" font="Microsoft YaHei"/>
			      <Label text="游戏币数量" x="219" y="58" width="120" var="m_textGameMoney" color="0xff0000" font="Microsoft YaHei"/>
			      <Label text="时间：" x="306" y="271" font="Microsoft YaHei"/>
			      <Label text="游戏局数" x="159" y="226" font="Microsoft YaHei" var="m_tGameTimes" color="0xff"/>
			      <Label text="最大筹码数" x="159" y="316" font="Microsoft YaHei" var="m_tMaxMoney" color="0xff"/>
			      <Label text="最多赢取筹码数量" x="159" y="361" font="Microsoft YaHei" var="m_tMaxWin" color="0xff"/>
			      <Label text="加入游戏时间" x="159" y="404" font="Microsoft YaHei" var="m_tJoinTime" color="0xff"/>
			      <Label text="最多赢取时间" x="343" y="361" font="Microsoft YaHei" var="m_tMaxWinTime" color="0xff"/>
			      <Label text="最大筹码时间" x="343" y="316" font="Microsoft YaHei" var="m_tMaxMoneyTime" color="0xff"/>
			      <Label text="最大手牌时间" x="343" y="271" font="Microsoft YaHei" var="m_tBigPaiTime" color="0xff"/>
			      <Label text="胜率" x="343" y="226" font="Microsoft YaHei" var="m_tWinPercent" color="0xff"/>
			      <Label text="最大牌型" x="159" y="271" var="m_tPaiType" color="0xff" font="Microsoft YaHei"/>
			    </Box>
			    <Box x="5" y="5" name="item1" var="m_Gift">
			      <Image url="png.comp.image_box_gift" width="545" height="450" sizeGrid="10,50,10,60"/>
			      <Tab x="5" y="5" var="m_tabGift">
			        <Button skin="png.comp.button_tab_cur_gift" name="item0" var="m_btnCurGift"/>
			        <Button skin="png.comp.button_tab_last_gift" x="125" name="item1" var="m_btnPassGift"/>
			      </Tab>
			      <ViewStack x="0" y="46" var="m_viewGift">
			        <Panel width="545" height="400" name="item0" x="0" y="0" var="m_spCurGift">
			          <Button label="保存设置" skin="png.comp.button_box_yellow" sizeGrid="22,22,22,22" width="180" x="71" y="355" var="m_btnSetCurGift" labelColors="0xffffff,0xffffff,0xffffff,0xffffff" labelSize="14" labelFont="Microsoft YaHei"/>
			          <Button label="出售礼物" skin="png.comp.button_box_blue" x="291" width="180" sizeGrid="22,22,22,22" y="355" var="m_btnSellCurGift" labelColors="0xffffff,0xffffff,0xffffff,0xffffff" labelSize="14" labelFont="Microsoft YaHei"/>
			        </Panel>
			        <Panel x="0" name="item1" width="545" height="400" y="0" var="m_spPassGift">
			          <Button label="出售礼物" skin="png.comp.button_box_blue" sizeGrid="22,22,22,22" width="180" x="181" y="355" var="m_btnSellPassGift" labelColors="0xffffff,0xffffff,0xffffff,0xffffff" labelFont="Microsoft YaHei" labelSize="14"/>
			        </Panel>
			      </ViewStack>
			    </Box>
			    <Label x="60" y="20" width="0" height="0" text="00000"/>
			    <Box x="5" y="5" name="item2" var="m_Friend">
			      <Image url="png.comp.image_box_gift" width="545" height="450" sizeGrid="10,50,10,60"/>
			      <Label text="当前好友数：" x="21" y="17" size="14"/>
			      <Button label="赠送礼物" skin="png.comp.button_box_blue" x="177" y="403" sizeGrid="22,22,22,22" width="180" var="m_btnSendGift" labelBold="true" labelColors="0xffffff,0xffffff,0xffffff,0xffffff" labelFont="Microsoft YaHei" labelSize="14"/>
			    </Box>
			  </ViewStack>
			  <Button skin="png.comp.button_box_close" x="674" y="-11" var="m_btnClose"/>
			</View>;
		public function PlayerInfoUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}