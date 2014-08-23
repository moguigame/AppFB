/**Created by the Morn,do not modify.*/
package ui {
	import morn.core.components.*;
	public class UI_RoomTableInfoUI extends View {
		public var m_list:List;
		protected var uiXML:XML =
			<View name="label" width="600">
			  <List x="28" y="11" repeatX="1" repeatY="6" spaceX="1" spaceY="1" var="m_list">
			    <VScrollBar skin="png.comp.vscroll" x="112" name="scrollBar" y="8" height="200"/>
			    <Box y="8" name="render" x="0">
			      <Clip url="png.other.clip_selectBox" clipX="1" clipY="2" name="selectBox" height="20" width="100" y="1"/>
			      <Label text="ID" x="18" align="center" name="label"/>
			    </Box>
			  </List>
			</View>;
		public function UI_RoomTableInfoUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}