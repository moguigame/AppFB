/**Created by the Morn,do not modify.*/
package ui {
	import morn.core.components.*;
	public class UI_PlayerInfoBoardUI extends View {
		public var m_tPlayerNickName:Label;
		protected var uiXML:XML =
			<View>
			  <Label text="这里显示玩家的NAME" x="62" y="1" width="120" var="m_tPlayerNickName"/>
			</View>;
		public function UI_PlayerInfoBoardUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}