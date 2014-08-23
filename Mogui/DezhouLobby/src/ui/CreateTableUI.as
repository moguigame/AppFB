/**Created by the Morn,do not modify.*/
package ui {
	import morn.core.components.*;
	public class CreateTableUI extends View {
		public var m_btnClose:Button;
		public var m_combBlind:ComboBox;
		public var m_combTime:ComboBox;
		public var m_btnCreateTableOK:Button;
		public var m_textPW:TextInput;
		public var m_CheckPW:CheckBox;
		public var m_textFee:Label;
		protected var uiXML:XML =
			<View y="0">
			  <Image url="png.comp.image_box_bg1" x="0" y="0" sizeGrid="10,10,10,10" width="460" height="440"/>
			  <Image url="png.comp.image_box_bg4" x="30" y="2"/>
			  <Image url="png.comp.image_box_bg2" x="3" y="61" width="453" height="375" sizeGrid="10,10,10,10"/>
			  <Label text="创建游戏房间" x="0" y="12" font="Microsoft YaHei" size="30" align="center" width="460" height="40" color="0xffffff"/>
			  <Label text="房间名称：" x="17" y="86" width="80"/>
			  <Label text="半面书生的房间" x="98" y="79" width="260" height="30" size="24" font="Arial" align="center"/>
			  <Button skin="png.comp.button_box_close" x="434" y="-14" var="m_btnClose"/>
			  <ComboBox labels="label1,label2" skin="png.comp.combobox" x="90" y="136.5" width="200" var="m_combBlind" itemSize="6" sizeGrid="40,10,60,10"/>
			  <Label text="盲注大小：" x="17" y="138.5"/>
			  <Label text="游戏时间：" x="17" y="185.5"/>
			  <ComboBox labels="label1,label2" skin="png.comp.combobox" x="90" y="183.5" width="200" var="m_combTime" itemSize="6" sizeGrid="40,10,60,10"/>
			  <Button label="确定" skin="png.comp.button_box_yellow" x="126.5" y="379" labelBold="true" sizeGrid="22,22,22,22" width="200" var="m_btnCreateTableOK"/>
			  <Label text="房间密码：" x="17" y="226"/>
			  <Label text="设置房间持续存在的时间" x="300" y="184"/>
			  <Label text="设置房间游戏盲注大小" x="301" y="137"/>
			  <TextInput skin="png.comp.textinput" x="170" y="224" width="120" var="m_textPW" maxChars="6"/>
			  <Label text="1-6位数字" x="300" y="225"/>
			  <CheckBox label="使用密码" skin="png.comp.checkbox" x="89" y="228" var="m_CheckPW"/>
			  <Label text="创建费用：" x="15" y="273"/>
			  <Label x="88" y="273" width="120" color="0xff0000" var="m_textFee" size="16" height="20"/>
			  <Label text="根据盲注和持续时间计算" x="298" y="273"/>
			</View>;
		public function CreateTableUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}