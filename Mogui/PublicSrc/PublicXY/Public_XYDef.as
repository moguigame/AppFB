package PublicXY
{
	public class Public_XYDef
	{
		public static const MOGUI_FIRST_PUBLIC:int                = 0;		//公用协议起始编号
		public static const MOGUI_LAST_PUBLIC:int                 = 999;		//公用协议结束编号
		public static const MOGUI_FIRST_SERVER:int                = 1000;		//服务器之间通讯协议起始编号
		public static const MOGUI_LAST_SERVER:int                 = 9999;		//服务器之间通讯协议结束编号
		public static const MOGUI_FIRST_CLIENT:int                = 10000;	//服务器与客户端之间通讯协议起始编号
		public static const MOGUI_LAST_CLIENT:int                 = 19999;	//服务器与客户端之间通讯协议结束编号
		public static const MOGUI_FIRST_RESERVE:int               = 20000;	//保留
		
		
		public static const MOGUI_FIRST_CLIENT_LOBBY:int		    = MOGUI_FIRST_CLIENT;		//纯大厅通讯协议起始编号
		public static const MOGUI_LAST_CLIENT_LOBBY:int			= MOGUI_FIRST_CLIENT+999;	//纯大厅通讯协议结束编号
		public static const MOGUI_FIRST_CLIENT_GAMELOBBY:int	    = MOGUI_FIRST_CLIENT+1000;	//游戏大厅与服务器通讯协议起始编号
		public static const MOGUI_LAST_CLIENT_GAMELOBBY:int		= MOGUI_FIRST_CLIENT+1999;	//游戏大厅与服务器通讯协议结束编号
		public static const MOGUI_FIRST_CLIENT_GAMECLIENT:int	    = MOGUI_FIRST_CLIENT+2000;	//游戏客户端与服务器通讯协议起始编号
		public static const MOGUI_LAST_CLIENT_GAMECLIENT:int	    = MOGUI_FIRST_CLIENT+2999;	//游戏客户端与服务器通讯协议结束编号
		
		
		
		public function Public_XYDef()
		{
			trace("Public_XYDef Init...");
		}
	}
}