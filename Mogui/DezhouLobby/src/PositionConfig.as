package
{
	//这里主要是放种有关位置尺寸的配置的
	
	public class PositionConfig
	{
		public static const s_LobbyWidth:int                       = 1000;
		public static const s_LobbyHeight:int                      = 620;
		
		public static const s_TitleHeight:int                      = 40;
		
		public static const s_GameWidth:int                        = 1000;
		public static const s_GameHeight:int                       = s_LobbyHeight - 	s_TitleHeight;
		
		public function PositionConfig()
		{
			
		}
	}
}