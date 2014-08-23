package UILogic
{
	import flash.display.Sprite;
	
	import Data.Data_SNSPlayerInfo;
	
	import Game.Game_PlayerStateInfo;
	
	public class View_SNSPlayerInfo extends Sprite
	{
		public var m_arrayPlayerInfo:Array;
		public var m_ListSNSPlayerInfo:List_NSNPlayerInfo;
		
		public function View_SNSPlayerInfo()
		{
			super();
			
			m_arrayPlayerInfo = new Array();
			
			m_ListSNSPlayerInfo = new List_NSNPlayerInfo(7);
			addChild(m_ListSNSPlayerInfo);
			m_ListSNSPlayerInfo.y = 5;
		}
		
		public function GetPlayerInfo(PID:int):Data_SNSPlayerInfo
		{
			for(var i:int=0;i<m_arrayPlayerInfo.length;++i)
			{
				if( (m_arrayPlayerInfo[i] as Data_SNSPlayerInfo).m_PID == PID )
				{
					return m_arrayPlayerInfo[i];
				}
			}
			return null;
		}
		public function GetPlayerInfoIdx(PID:int):int
		{
			for(var i:int=0;i<m_arrayPlayerInfo.length;++i)
			{
				if( (m_arrayPlayerInfo[i] as Data_SNSPlayerInfo).m_PID == PID )
				{
					return i;
				}
			}
			return -1;
		}
		
		public function AddPlayerInfo(dataPI:Data_SNSPlayerInfo):void
		{
			var findPI:Data_SNSPlayerInfo = GetPlayerInfo(dataPI.m_PID);
			if( findPI != null )
			{
				findPI = dataPI;
			}
			else
			{
				m_arrayPlayerInfo.push(dataPI);
			}
		}
		public function RemovePlayerInfo(PID:int):void
		{
			var Idx:int = GetPlayerInfoIdx(PID);
			if( Idx != -1 )
			{
				m_arrayPlayerInfo.splice(Idx,1);
			}
		}
		public function UpdateAllPlayer():void
		{
			m_ListSNSPlayerInfo.dataSource = m_arrayPlayerInfo;
		}
		
		public function UpdatePlayerState(msgPSI:Game_PlayerStateInfo):void
		{
			var TempPI:Data_SNSPlayerInfo = GetPlayerInfo(msgPSI.m_PID);
			if( TempPI )
			{
				TempPI.m_RoomID       = msgPSI.m_RoomID;
				TempPI.m_TableID      = msgPSI.m_TableID;
				TempPI.m_SitID        = msgPSI.m_SitID;
				TempPI.m_PlayerState  = msgPSI.m_State;
				TempPI.m_strState     = msgPSI.m_strState;
				UpdateAllPlayer();				
			}
			else
			{
				GlobleFunc.LogError("View_SNSPlayerInfo UpdatePlayerState PID="+msgPSI.m_PID+" RoomID="+msgPSI.m_RoomID);
			}
		}
	}
}