package L2C
{
	public class LC_XieYiID
	{
		//大厅单向发向客户端的消息
		public static const LobbyToClientStart:int                = 0;
		public static const XYID_L2C_TableInfo:int                = LobbyToClientStart + 1;
		
		//客户端单向发向大厅的消息
		public static const ClientToLobbyStart:int                = 1000;
		
		//大厅客户端双向发送消息
		public static const LobbyClientStart:int                  = 2000;
		public static const XYID_LC_Flag:int                      = LobbyClientStart + 1;
		
		//舞台中转发向客户端的消息
		public static const StageToClientStart:int                = 3000;
		public static const XYID_S2C_ClickSitDownButton:int       = StageToClientStart + 1;
		public static const XYID_S2C_MoveMoney:int                = StageToClientStart + 2;
		public static const XYID_S2C_MoveMinPai:int               = StageToClientStart + 3;
		public static const XYID_S2C_FanPai:int                   = StageToClientStart + 4;
		public static const XYID_S2C_Flag:int                     = StageToClientStart + 5;
		public static const XYID_S2C_AddChipInfo:int              = StageToClientStart + 6;
		public static const XYID_S2C_TableChat:int                = StageToClientStart + 7;
		
		//舞台中转发向大厅的消息
		public static const StageToLobbyStart:int                 = 4000;
		public static const XYID_S2L_Flag:int                     = StageToLobbyStart + 1;
		public static const XYID_S2L_ClickTable:int               = StageToLobbyStart + 2;
		public static const XYID_S2L_DoubleClickTable:int         = StageToLobbyStart + 3;
		public static const XYID_S2L_ClickLobbyButton:int         = StageToLobbyStart + 4;
		
		//子对象向父对象发消息
		public static const ChildToParentStart:int                = 10000;
		public static const XYID_C2P_Flag:int                     = ChildToParentStart + 1;
		
		public function LC_XieYiID()
		{
		}
	}
}