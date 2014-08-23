/**Created by the Morn,do not modify.*/
package ui {
	import morn.core.components.*;
	public class UI_BankUI extends View {
		public var m_tGameMoney:Label;
		public var m_tBankMoney:Label;
		public var m_tab:Tab;
		public var m_viewstack:ViewStack;
		public var m_boxIn:Box;
		public var m_textIn:TextInput;
		public var m_btnIn:Button;
		public var m_btnInAll:Button;
		public var m_boxOut:Box;
		public var m_textOut:TextInput;
		public var m_btnOut:Button;
		public var m_btnOutAll:Button;
		public var m_btnClose:Button;
		protected var uiXML:XML =
			<View width="430" height="300">
			  <Image url="png.comp.image_box_bg1" x="0" y="0" width="440" height="360" sizeGrid="10,10,10,10"/>
			  <Image url="png.comp.image_box_bg4" x="21" y="2"/>
			  <Image url="png.comp.image_box_bg2" x="5" y="55" sizeGrid="10,10,10,10" width="430" height="300"/>
			  <Label text="玩家的游戏币：" x="25" y="75" font="Microsoft YaHei"/>
			  <Label text="银行的游戏币：" x="25" y="100" font="Microsoft YaHei"/>
			  <Label text="$56789" x="125" y="75" var="m_tGameMoney"/>
			  <Label text="$123456789" x="125" y="100" var="m_tBankMoney"/>
			  <Label text="我的银行" x="0" y="14" bold="true" color="0xffffff" align="center" size="24" width="440" height="30"/>
			  <Tab x="20" y="144" var="m_tab">
			    <Button skin="png.comp.button_inbank" name="item0" width="200" height="40"/>
			    <Button skin="png.comp.button_outbank" x="200" name="item1" width="200" height="40"/>
			  </Tab>
			  <ViewStack x="21" y="208" var="m_viewstack">
			    <Box name="item0" var="m_boxIn">
			      <Label text="输入存款数量：" x="0" font="Microsoft YaHei"/>
			      <TextInput skin="png.comp.textinput" y="29" width="300" height="40" font="Microsoft YaHei" size="30" maxChars="16" restrict="0-9" var="m_textIn"/>
			      <Button label="确定存入" skin="png.comp.button_box_yellow" x="93" y="89" sizeGrid="22,22,22,22" width="200" labelFont="Microsoft YaHei" var="m_btnIn"/>
			      <Button label="全部金额" skin="png.comp.button_box_blue" x="305" y="25" sizeGrid="22,22,22,22" labelFont="Microsoft YaHei" width="100" var="m_btnInAll"/>
			    </Box>
			    <Box x="0" name="item1" y="0" var="m_boxOut">
			      <Label text="输入取款数量：" font="Microsoft YaHei"/>
			      <TextInput skin="png.comp.textinput" y="29" width="300" height="40" font="Microsoft YaHei" size="30" restrict="0-9" maxChars="16" var="m_textOut"/>
			      <Button label="确定取出" skin="png.comp.button_box_yellow" x="93" y="89" sizeGrid="22,22,22,22" width="200" labelFont="Microsoft YaHei" var="m_btnOut"/>
			      <Button label="全部金额" skin="png.comp.button_box_blue" x="305" y="25" sizeGrid="22,22,22,22" labelFont="Microsoft YaHei" width="100" var="m_btnOutAll"/>
			    </Box>
			  </ViewStack>
			  <Button skin="png.comp.button_box_close" x="419" y="-12" var="m_btnClose"/>
			</View>;
		public function UI_BankUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}