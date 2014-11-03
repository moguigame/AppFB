package Data
{
	import Game.Game_PlayerBaseInfo;
	import Game.msgPlayerGiftInfo;

	public class Data_PlayerInfo
	{
		public var m_AID:int;
		public var m_PID:int;
		
		public var m_NickName:String;
		public var m_HeadPicURL:String;
		public var m_HomePageURL:String;
		public var m_City:String;
		public var m_Sex:int;
		public var m_Age:int;
		
		//玩家游戏信息
		public var m_nGameMoney:Number;
		public var m_nMoguiMoney:int;
		public var m_nOpenBank:int;
		public var m_nBankMoney:Number;
		public var m_nMatchJF:int;
		
		public var m_nJF:Number;
		public var m_nEP:Number;
		
		public var m_nWinTimes:int;
		public var m_nLossTimes:int;
		public var m_nGameTime:int;
		
		public var m_MaxPai:Data_MaxPai;
		public var m_MaxPaiTime:uint;
		public var m_MaxMoney:Number;
		public var m_MaxMoneyTime:uint;
		public var m_MaxWin:Number;
		public var m_MaxWinTime:uint;
		
		public var m_JoinTime:uint;
		public var m_arrayWinRecord:Vector.<int>;
		public var m_arrayHonor:Vector.<int>;
		
		public var m_arrayCurGift:Vector.<msgPlayerGiftInfo>;
		public var m_arrayPassGift:Vector.<msgPlayerGiftInfo>;
		public var m_arrayFriendInfo:Vector.<Data_FriendInfo>;
		
		//玩家状态信息
		public var m_RoomID:int;
		public var m_TableID:int;
		public var m_SitID:int;
		public var m_PlayerState:int;
		
		public var m_GameLevel:int;
		public var m_VipLevel:int;
		public var m_FriendCount:int;
		public var m_GiftID:int;
		
		//自选的
		public var m_AutoRoomID:int;
		public var m_AutoTableID:int;
		
		public function Data_PlayerInfo()
		{			
			Init();
		}
		
		public function Init():void
		{
			m_AID = 0;
			m_PID = 0;
			
			m_NickName = "";
			m_HeadPicURL = "";
			m_HomePageURL = "";
			m_City = "";
			
			m_Sex = 0;
			m_Age = 0;
			
			m_nGameMoney = 0;
			m_nMoguiMoney = 0;
			m_nOpenBank = 0;
			m_nBankMoney = 0;
			m_nMatchJF = 0;
			
			m_nJF = 0;
			m_nEP = 0;
			m_nWinTimes = 0;
			m_nLossTimes = 0;
			m_nGameTime = 0;
			
			m_MaxPai = new Data_MaxPai();
			m_MaxPaiTime = 0;
			m_MaxMoney = 0;
			m_MaxMoneyTime = 0;
			m_MaxWin = 0;
			m_MaxWinTime = 0;
			
			m_JoinTime = 0;
			m_arrayWinRecord = new Vector.<int>();
			m_arrayHonor = new Vector.<int>();
			
			m_arrayCurGift = new Vector.<msgPlayerGiftInfo>();
			m_arrayPassGift = new Vector.<msgPlayerGiftInfo>();			
			m_arrayFriendInfo = new Vector.<Data_FriendInfo>();
			
			m_RoomID = 0;
			m_TableID = 0;
			m_SitID = 0;
			m_PlayerState = 0;
			
			m_GameLevel = 0;
			m_VipLevel = 0;
			m_FriendCount = 0;
			m_GiftID = 0;
			
			m_AutoRoomID = 0;
			m_AutoTableID = 0;
		}
		
		public function Copy(srcData:Data_PlayerInfo):void
		{
			m_AID = srcData.m_AID;
			m_PID = srcData.m_PID;
			
			m_NickName = srcData.m_NickName;
			m_HeadPicURL = srcData.m_HeadPicURL;
			m_HomePageURL = srcData.m_HomePageURL;
			m_City = srcData.m_City;
			m_Sex = srcData.m_Sex;
			m_Age = srcData.m_Age;			
			
			m_nGameMoney = srcData.m_nGameMoney;
			m_nMoguiMoney = srcData.m_nMoguiMoney;
			m_nOpenBank = srcData.m_nOpenBank;
			m_nBankMoney = srcData.m_nBankMoney;
			m_nMatchJF = srcData.m_nMatchJF;
			
			m_nJF = srcData.m_nJF;
			m_nEP = srcData.m_nEP;
			m_nWinTimes = srcData.m_nWinTimes;
			m_nLossTimes = srcData.m_nLossTimes;
			m_nGameTime = srcData.m_nGameTime;
			
			m_MaxPai.Copy(srcData.m_MaxPai);
			m_MaxPaiTime = srcData.m_MaxPaiTime;
			m_MaxMoney = srcData.m_MaxMoney;
			m_MaxMoneyTime = srcData.m_MaxMoneyTime;
			m_MaxWin = srcData.m_MaxWin;
			m_MaxWinTime = srcData.m_MaxWinTime;
			
			m_JoinTime = srcData.m_JoinTime;		
			
			var i:int = 0;
			m_arrayWinRecord.length = srcData.m_arrayWinRecord.length;
			for(i=0;i<srcData.m_arrayWinRecord.length;++i){
				m_arrayWinRecord[i] = srcData.m_arrayWinRecord[i];
			}			
			m_arrayHonor.length = srcData.m_arrayHonor.length;
			for(i=0;i<srcData.m_arrayHonor.length;++i){
				m_arrayHonor[i] = srcData.m_arrayHonor[i];
			}
			
			m_arrayCurGift.length = srcData.m_arrayCurGift.length;
			for(i=0;i<srcData.m_arrayCurGift.length;++i){
				m_arrayCurGift[i] = srcData.m_arrayCurGift[i];
			}
			m_arrayPassGift.length = srcData.m_arrayPassGift.length;
			for(i=0;i<srcData.m_arrayPassGift.length;++i){
				m_arrayPassGift[i] = srcData.m_arrayPassGift[i];
			}
			m_arrayFriendInfo.length = srcData.m_arrayFriendInfo.length;
			for(i=0;i<srcData.m_arrayFriendInfo.length;++i){
				m_arrayFriendInfo[i] = srcData.m_arrayFriendInfo[i];
			}
			
			m_RoomID = srcData.m_RoomID;
			m_TableID = srcData.m_TableID;
			m_SitID = srcData.m_SitID;
			m_PlayerState = srcData.m_PlayerState;
			
			m_GameLevel = srcData.m_GameLevel;
			m_VipLevel = srcData.m_VipLevel;
			m_FriendCount = srcData.m_FriendCount;
			
			m_AutoRoomID = srcData.m_AutoRoomID;
			m_AutoTableID = srcData.m_AutoTableID;
		}
		
		public function SetPlayerBaseInfo(srcData:Game_PlayerBaseInfo):void
		{
			if( m_PID==srcData.m_PID )
			{
				m_nGameMoney    = srcData.m_nGameMoney;
				m_PlayerState   = srcData.m_PlayerState;
				m_GameLevel     = srcData.m_GameLevel;
				
				m_NickName      = srcData.m_NickName;
				m_HeadPicURL    = srcData.m_HeadPicURL;
			}
			else
			{
				GlobleFunc.LogError("SetPlayerBaseInfo",m_AID,srcData.m_AID,m_PID,srcData.m_PID);				
			}
		}
		
		public function SetHonorInfo(srcHonor:Vector.<int>):void
		{
			m_arrayHonor.length = srcHonor.length;
			for(var i:int=0;i<srcHonor.length;++i)
			{
				m_arrayHonor[i] = srcHonor[i];
			}
		}
		
		public function DeleteGiftInfo(Idx:int,nFlag:int=0):void
		{
			//if( nFlag == DeZhouDef.CurGift )
			{
				while(true)
				{
					var nFindCurIdx:int = 0;
					var bFindCur:Boolean = false;
					for(var i:int=0;i<m_arrayCurGift.length;++i )
					{
						if( m_arrayCurGift[i].m_GiftIdx == Idx )
						{
							bFindCur = true;
							nFindCurIdx = i;
							break;
						}
					}
					if( bFindCur == false )
						break;
					else
					{
						m_arrayCurGift.splice(nFindCurIdx,1);
					}
				}
			}
			//else if( nFlag == DeZhouDef.PassGift )
			{
				while(true)
				{
					var nFindPassIdx:int = 0; 
					var bFindPass:Boolean = false;
					for(var j:int=0;j<m_arrayPassGift.length;++j )
					{
						if( m_arrayPassGift[j].m_GiftIdx == Idx )
						{
							bFindPass = true;
							nFindPassIdx = j;
							break;
						}
					}
					if( bFindPass == false )
						break;
					else
					{
						m_arrayPassGift.splice(nFindPassIdx,1);
					}
				}
			}
		}
		public function AddGiftInfo(msgGI:msgPlayerGiftInfo,nFlag:int):void
		{
			if( nFlag == DeZhouDef.CurGift )
			{
				var bFindCur:Boolean = false;
				for(var i:int=0;i<m_arrayCurGift.length;++i)
				{
					if( m_arrayCurGift[i].m_GiftIdx == msgGI.m_GiftIdx )
					{
						bFindCur = true;
						break;
					}
				}
				if( bFindCur == false )
				{
					m_arrayCurGift.push(msgGI);
				}
			}
			else if( nFlag == DeZhouDef.PassGift )
			{
				var bFindPass:Boolean = false;
				for(var j:int=0;j<m_arrayPassGift.length;++j)
				{
					if( m_arrayPassGift[j].m_GiftIdx == msgGI.m_GiftIdx )
					{
						bFindPass = true;
						break;
					}
				}
				if( bFindPass == false )
				{
					m_arrayPassGift.push(msgGI);
				}
			}
		}
		
		public function AddFrindInfo(msgFI:Data_FriendInfo):void
		{
			var bFind:Boolean = false;
			for(var i:int=0;i<m_arrayFriendInfo.length;++i)	{
				if( m_arrayFriendInfo[i].m_PID == msgFI.m_PID )	{
					bFind = true;
					break;
				}
			}
			if( bFind == false ){
				m_arrayFriendInfo.push(msgFI);
			}
		}
		public function DeleteFriendInfo(PID:int):void
		{
			while(true){
				var nFindIdx:int = 0;
				var bFind:Boolean = false;
				for(var i:int=0;i<m_arrayFriendInfo.length;++i ){
					if( m_arrayFriendInfo[i].m_PID == PID ){
						bFind = true;
						nFindIdx = i;
						break;
					}
				}
				if( bFind == false )
					break;
				else{
					m_arrayFriendInfo.splice(nFindIdx,1);
				}
			}
		}
		public function HaveTailInfo():Boolean{
			return (m_MaxMoney+m_MaxWin) > 0;
		}
		public function HaveGift():Boolean{
			return (m_arrayCurGift.length + m_arrayPassGift.length) > 0;
		}		
	}
}