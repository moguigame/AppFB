package com.xiaonei.flash
{ 
	import flash.events.*;
	import flash.net.*;
	import flash.utils.*;
	
    import com.adobe.crypto.*;
	import com.evt.SendObjectEvent;
    
    public class XiaoneiRestClient extends EventDispatcher 
    { 
        private var m_RestServer:String = "http://api.xiaonei.com/restserver.do"; 
        private var m_RestSecurityServer:String = "https://api.xiaonei.com/restserver.do";
		
        private var m_ApiKey:String;
        private var m_ApiPwd:String;
        private var m_Session_key:String;
        private var m_BaseReqStr:String;
		
		private var n_fCallBack:Function;
		public  var LogFuc:Function;
        
        public function XiaoneiRestClient(apikey:String, apipwd:String, sessionkey:String,fuc:Function) 
        { 
            this.m_ApiKey = apikey;
            this.m_ApiPwd = apipwd;
            this.m_Session_key = sessionkey;
			this.n_fCallBack = fuc;
			
            this.m_BaseReqStr = "v=1.0&api_key=" + m_ApiKey + "&session_key=" + m_Session_key;
        } 
        
        private function sendRequest(reqstr:String):void
        {
			trace("sendRequest...\n");
			trace(reqstr);
			var variables:URLVariables = new URLVariables(reqstr);
			var request:URLRequest = new URLRequest();
			request.url = this.m_RestServer;
			request.method = URLRequestMethod.POST;
			request.data = variables;
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.VARIABLES;
			loader.addEventListener(Event.COMPLETE, n_fCallBack);
			try
			{
				loader.load(request);
			}
			catch (error:Error)
			{
				trace("Unable to load URL");
			}
        }
		
		function CompleteHandler(event:Event):void
		{
			trace( decodeURI( String(event.target.data) ));
		}
        
        private function CreateReqStr(origStr:String):String
        {			
			var strRet:String;
			
            var t:Date = new Date();
            var temp:String = this.m_BaseReqStr + "&call_id=" + t.getTime().toString() + origStr;			
			trace(temp);
			
            var params:Array = temp.split("&");
            params.sort();			
            trace(params);
			
            var reqStr:String = params.join("");
			trace(reqStr);
			
			reqStr += m_ApiPwd;
            reqStr = "&sig=" + MD5.hash(reqStr);
			strRet = temp + reqStr;
			
			trace(strRet);
            return strRet;
        }
        
		//获取一个应用当天可以发送的通知的配额。
		public function Admin_GetAllocation():void
		{
			var req:String = CreateReqStr("&method=xiaonei.admin.getAllocation");
			this.sendRequest(req);
		}
		
		//auth.createToken 
		//auth.getSession
		
		//connect.getUnconnectedFriendsCount
		//connect.registerUsers 
		//connect.unregisterUsers
		//feed.publishTemplatizedAction 
		//friends.areFriends 

		//得到当前登录用户的好友列表，得到的只是含有好友uid的列表。
		public function Friends_Get():void
		{			
			var req:String = CreateReqStr("&method=xiaonei.friends.get");
            this.sendRequest(req); 
		}
		
		//得到当前登录用户的好友列表。 
        public function Friends_GetFriends():void
        {			
            var req:String = CreateReqStr("&method=xiaonei.friends.getFriends"); 
            this.sendRequest(req); 
        } 
        
		//返回已经添加了一个应用的好友的用户Id列表，此接口只返回全部好友中的数据
		public function Friends_GetAppUsers():void
        {			
            var req:String = CreateReqStr("&method=xiaonei.friends.getAppUsers");
            this.sendRequest(req); 
        }
		
		//返回App好友的ID列表。App好友是指某个用户安装了同一应用的好友。
		public function Friends_GetAppFriends():void
        { 
            var req:String = CreateReqStr("&method=xiaonei.friends.getAppFriends");
            this.sendRequest(req); 
        }
		
		public function Invitations_GetOsInfo(inviteids:String):void
        { 
            var req:String = CreateReqStr("&method=xiaonei.invitations.getOsInfo&invite_ids="+inviteids);
            this.sendRequest(req); 
        }		
		
		public function Invitations_GetUserOsInviteCnt(uids:String):void
        { 
            var req:String = CreateReqStr("&method=xiaonei.invitations.getUserOsInviteCnt&uids="+uids);
            this.sendRequest(req); 
        }		
		
		//给当前登录者的好友或也安装了同样应用的用户发通知。
		public function Notifications_Send(uids:String,notify:String):void
		{
			var req:String = CreateReqStr("&method=xiaonei.Notifications.send&to_ids="+uids+"&notification="+notify);
            this.sendRequest(req);
		}
		
		//查询某个用户在一个应用中一次消费是否完成。此接口传入一个有效的参数：订单号(order_id)。
		public function Pay_IsCompleted(PayId:String):void
		{
			var req:String = CreateReqStr("&method=xiaonei.users.getLoggedInUser&order_id"+PayId);
            this.sendRequest(req);
		}
		
		public function Pay_RegOrder(PayId:String,amount:String,desc:String):void
		{
			var req:String = CreateReqStr("&method=xiaonei.users.getLoggedInUser&order_id"+PayId+"&amount="+amount+"&desc="+desc);
            this.sendRequest(req);
		}
		
		//pay4Test.isCompleted 
		//pay4Test.regOrder
		//profile.getXNML 
		//profile.setXNML

		//得到用户信息
        public function Users_GetInfo(uids:String, fields:String):void
        {
            var req:String = CreateReqStr("&method=xiaonei.users.getInfo&uids="+uids+"&fields="+fields);
            this.sendRequest(req);
        }
		
		//得到当前session的用户ID
		public function Users_GetLoggedInUser():void
		{
			var req:String = CreateReqStr("&method=xiaonei.users.getLoggedInUser");
            this.sendRequest(req);
		}
		
		//检查用户是否允许了一个扩展应用许可(如email的接收许可) 
		public function Users_HasAppPermission(uids:String,extperm:String):void
		{
			var req:String = CreateReqStr("&method=xiaonei.users.hasAppPermission&uid="+uids+"&ext_perm="+String(extperm));
            this.sendRequest(req);
		}

		//判断用户是否已对App授权 
		public function Users_IsAppUser(uids:String):void
		{
			var req:String = CreateReqStr("&method=xiaonei.users.isAppUser&uid="+uids);
            this.sendRequest(req);
		}
    } 
}
