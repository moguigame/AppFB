/**Created by the Morn,do not modify.*/
package ui {
	import morn.core.components.*;
	public class TitleUI extends View {
		public var m_btnFullScreen:Button;
		public var m_btnChongZhi:Button;
		public var m_btnShangCheng:Button;
		public var m_tGameMoney:Label;
		public var m_tMoGuiMoney:Label;
		protected var uiXML:XML =
			<View>
			  <Image url="png.comp.Image_TitleBack" x="0" y="0" width="1000"/>
			  <Image url="png.comp.Image_TextBack" x="23" y="8" sizeGrid="10,10,10,10" width="175"/>
			  <Image url="png.comp.Image_TextBack" x="213" y="8" width="120" sizeGrid="10,10,10,10"/>
			  <Image url="png.comp.Image_TitleMoney" x="10" y="6" toolTip="游戏币"/>
			  <Image url="png.comp.Image_TitleJiFen" x="200" y="6" toolTip="红包"/>
			  <Button skin="png.comp.button_fullscreen" x="967" y="6" var="m_btnFullScreen"/>
			  <Button label="充值" skin="png.comp.button_yellow" x="353" y="6" width="56" labelFont="Microsoft YaHei" labelColors="401f0a" height="26" var="m_btnChongZhi"/>
			  <Button label="商城" skin="png.comp.button_yellow" x="428" y="6" width="56" labelFont="Microsoft YaHei" labelColors="401f0a" height="26" var="m_btnShangCheng"/>
			  <Label text="label" x="43" y="8" width="155" var="m_tGameMoney" align="left" bold="true" font="Microsoft YaHei" color="0xffff00" size="14" height="20"/>
			  <Label text="label" x="232" y="7" width="100" var="m_tMoGuiMoney" color="0xffff00" size="14" height="20" font="Microsoft YaHei"/>
			</View>;
		public function TitleUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}