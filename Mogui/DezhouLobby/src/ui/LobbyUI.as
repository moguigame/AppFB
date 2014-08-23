/**Created by the Morn,do not modify.*/
package ui {
	import morn.core.components.*;
	public class LobbyUI extends View {
		protected var uiXML:XML =
			<View y="1">
			  <Image url="png.comp.RoomInfo_Back1" x="16" y="42" width="700" height="500" sizeGrid="10,10,10,10"/>
			  <Image url="png.comp.RoomInfo_Back2" x="17" y="43" sizeGrid="10,10,10,10" width="698" height="420"/>
			</View>;
		public function LobbyUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}