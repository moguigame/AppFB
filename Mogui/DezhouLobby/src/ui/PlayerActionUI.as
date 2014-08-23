/**Created by the Morn,do not modify.*/
package ui {
	import morn.core.components.*;
	public class PlayerActionUI extends View {
		public var m_head:Image;
		public var m_btnTailInfo:Button;
		public var m_btnGift:Button;
		public var m_btnAddFriend:Button;
		public var m_tGameMoney:Label;
		public var m_tNickName:Label;
		public var m_tLevel:Label;
		protected var uiXML:XML =
			<View>
			  <Image url="png.comp.image_playeraction_back" x="0" y="0" width="245" height="140" sizeGrid="25,25,25,25"/>
			  <Image url="png.comp.Image_Back3" x="12" y="12" var="m_head" width="80" height="80" sizeGrid="10,10,10,10"/>
			  <Button skin="png.comp.button_action_tailinfo" x="101" y="64" toolTip="查看详情" var="m_btnTailInfo"/>
			  <Button skin="png.comp.button_action_sendgift" x="139" y="64" toolTip="赠送礼物" var="m_btnGift"/>
			  <Button skin="png.comp.button_action_addfriend" x="177" y="64" toolTip="添加好友" var="m_btnAddFriend"/>
			  <Label text="$12345" x="102" y="38" size="12" color="0xffffff" var="m_tGameMoney" font="Microsoft YaHei"/>
			  <Label text="我的名子叫赌圣" x="134" y="15" var="m_tNickName" font="Microsoft YaHei"/>
			  <Label text="LV16" x="102" y="15" var="m_tLevel" font="Microsoft YaHei"/>
			</View>;
		public function PlayerActionUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}