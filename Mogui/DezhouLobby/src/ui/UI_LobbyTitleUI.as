/**Created by the Morn,do not modify.*/
package ui {
	import morn.core.components.*;
	public class UI_LobbyTitleUI extends View {
		protected var uiXML:XML =
			<View y="0">
			  <Image url="png.comp.Image_TitleBack" x="0" y="0" width="1000"/>
			  <Image url="png.comp.Image_TextBack" x="15" y="8" width="100" sizeGrid="10,10,10,10"/>
			  <Image url="png.comp.Image_TextBack" x="160" y="7" sizeGrid="10,10,10,10" width="6"/>
			  <Image url="png.comp.Image_TextBack" x="205" y="19"/>
			  <Image url="png.comp.Image_TitleMoney" x="5" y="5"/>
			  <Image url="png.comp.Image_TitleJiFen" x="150" y="5"/>
			</View>;
		public function UI_LobbyTitleUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}