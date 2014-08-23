/**Created by the Morn,do not modify.*/
package ui {
	import morn.core.components.*;
	public class UI_TabUI extends View {
		protected var uiXML:XML =
			<View>
			  <Image url="jpg.comp.Image_lobbyback" x="36" y="24"/>
			</View>;
		public function UI_TabUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}