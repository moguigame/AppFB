package
{
	import com.hurlant.crypto.symmetric.AESKey;
	import com.hurlant.crypto.symmetric.CFBMode;
	import com.hurlant.crypto.symmetric.NullPad;
	import com.hurlant.util.Hex;
	
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import MoGui.net.MsgData;
	import MoGui.net.MsgDataEvent;
	
	import PublicXY.Public_XYBase;
	
	public class CGameSocket extends EventDispatcher
	{
		protected var m_Socket:Socket;
		
		protected var m_RecvByteArray:ByteArray;
		
		protected var m_LogicByteArray:ByteArray;
		protected var m_LogicByteNumber:uint;
		
		protected var m_CanUsed:Boolean;                     //是否可用	
		protected var m_bCrypt:Boolean;                      //记录是否需要加解密
		protected var m_cbfCrypt:CFBMode;
		
		protected var m_SocketName:String;
		
		public    var m_RecvMsgByte:int;
		public    var m_RecvMsgPacket:int;
		public    var m_SendMsgByte:int;
		public    var m_SendMsgPacket:int;
		
		public function CGameSocket()
		{
			trace("CGameSocket Init...");
			
			super();			
			
			m_Socket = new Socket();
			m_Socket.endian = Endian.LITTLE_ENDIAN;
			
			m_RecvByteArray = new ByteArray();
			m_RecvByteArray.endian = Endian.LITTLE_ENDIAN;
			
			m_LogicByteNumber = 0;
			m_LogicByteArray = new ByteArray();
			m_LogicByteArray.endian = Endian.LITTLE_ENDIAN;
			
			var TempArray:Array = [0xF3,0x62,0x12,0x05,0x13,0xE3,0x89,0xFF,0x23,0x11,0xD7,0x36,0x01,0x23,0x10,0x07,0x05,0xA2,0x10,0x00,0x7A,0xCC,0x02,0x3C,0x39,0x01,0xDA,0x2E,0xCB,0x12,0x44,0x8B];
			var TempBA:ByteArray = new ByteArray();
			for(var i:int=0;i<TempArray.length;i++)
			{
				TempBA.writeByte(TempArray[i]);
			}
			TempBA.position = 0;
			InitCrypt(TempBA);
			
			Init();
			
			m_Socket.addEventListener(Event.CONNECT,onConnect);
			m_Socket.addEventListener(Event.CLOSE,onClose);
			m_Socket.addEventListener(ProgressEvent.SOCKET_DATA,onData);
			m_Socket.addEventListener(ErrorEvent.ERROR,onError);
			m_Socket.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
			m_Socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
		}
		
		public function Init():void
		{
			m_LogicByteNumber = 0;
			m_RecvByteArray.length = 0;
			m_LogicByteArray.length = 0;
			m_CanUsed = false;
			
			m_RecvMsgByte = 0;
			m_RecvMsgPacket = 0;
			m_SendMsgByte = 0;
			m_SendMsgPacket = 0;
		}
		public function InitCrypt(key:ByteArray):void
		{
			m_bCrypt = true;
			m_cbfCrypt = null;
			m_cbfCrypt = new CFBMode(new AESKey(key), new NullPad);
			m_cbfCrypt.IV = Hex.toArray("15FF010034AB4CD355FEA122084F1307");
		}		
		
		public function Connect(strIP:String,nPort:int):void
		{
			if( m_Socket && !m_Socket.connected )
			{
				m_Socket.connect(strIP,nPort);
			}
			else
			{
				trace("Connect Error ??? " + m_Socket.connected);
			}
		}
		
		protected function onConnect(evt:Event):void
		{
			trace("connect success ");
			dispatchEvent(evt);
		}
		protected function onClose(evt:Event):void
		{
			trace("socket close ");
			Init();
			dispatchEvent(evt);
		}
		protected function onData(evt:Event):void
		{
			var nRecvBytes:int = m_Socket.bytesAvailable;
			//trace("onData Recvbyte",nRecvBytes);
			
			m_RecvByteArray.position = 0;
			m_Socket.readBytes(m_RecvByteArray);
			m_RecvByteArray.position = 0;
			
			m_LogicByteArray.position = m_LogicByteNumber;
			m_LogicByteArray.writeBytes(m_RecvByteArray,0,nRecvBytes);
			m_LogicByteNumber = m_LogicByteArray.position;
			m_LogicByteArray.position = 0;
			
			while( m_LogicByteNumber > 0 )
			{
				var eventMsgData:MsgDataEvent = new MsgDataEvent();	
				if( eventMsgData.m_msgData.GetMsg(m_LogicByteArray,m_LogicByteNumber) )
				{
					var nFinishSize:int = 3 + eventMsgData.m_msgData.m_msgLen;
					if( eventMsgData.m_msgData.m_msgLen >= 255 )
					{
						nFinishSize += 2;
					}
					m_LogicByteNumber -= nFinishSize;
					
					m_RecvMsgByte += nFinishSize;
					m_RecvMsgPacket++;
					
					if(m_bCrypt)
					{
						eventMsgData.m_msgData.m_dataArray.position = 0;
						//m_cbfCrypt.decrypt(eventMsgData.m_msgData.m_dataArray);
						//trace("de "+eventMsgData.m_msgData.m_dataArray.position);
					}
					
					dispatchEvent(eventMsgData);
				}
				else
				{
					var StartPos:int = m_LogicByteArray.position;
					m_LogicByteArray.position = 0;
					m_LogicByteArray.writeBytes(m_LogicByteArray,StartPos,m_LogicByteNumber);					
					
					break;
				}
			}
			
			//Logger.log("包余下数据为：",m_LogicByteNumber);
			//trace("包余下数据为：",m_LogicByteNumber);
		}
		protected function onError(evt:Event):void
		{
			//trace("onError ");
			dispatchEvent(evt);
		}
		protected function onIOError(evt:Event):void
		{
			//trace("onIOError ");
			dispatchEvent(evt);
		}
		protected function onSecurityError(evt:Event):void
		{
			//trace("onSecurityError ");
			dispatchEvent(evt);
		}
		
		public function DisPatchMsg(obXY:Public_XYBase):void
		{
			var evtMsgData:MsgDataEvent = new MsgDataEvent();
			var TempMsgData:MsgData = new MsgData();
			obXY.Write(TempMsgData);
			TempMsgData.ResetDataPosition();
			evtMsgData.m_msgData = TempMsgData;
			this.dispatchEvent(evtMsgData);
		}		
		public function SendMsg(obXY:Public_XYBase,bShowLog:Boolean=true):void
		{			
			if ( !m_Socket.connected )
			{
				GlobleFunc.LogError("SendMsg Can't Connected ",m_Socket.connected);
				return ;
			}
			
			var msgdata:MsgData = new MsgData();
			obXY.Write(msgdata);
			msgdata.m_msgLen = msgdata.m_dataArray.position;
			
			m_SendMsgPacket++;
			m_SendMsgByte += msgdata.m_msgLen+3;
			
			if( msgdata.m_msgLen < 255 )
			{
				m_Socket.writeByte(msgdata.m_msgLen);
			}
			else
			{
				m_SendMsgByte += 2;
				
				m_Socket.writeByte(255);
				m_Socket.writeShort(msgdata.m_msgLen);
			}
			m_Socket.writeShort(msgdata.m_msgID);
			if( msgdata.m_msgLen > 0 )
			{
				if(m_bCrypt)
				{
					//m_cbfCrypt.encrypt(msgdata.m_dataArray);
					//trace("En "+msgdata.m_dataArray.position);					
				}
				msgdata.m_dataArray.position = 0;
				m_Socket.writeBytes(msgdata.m_dataArray,0,msgdata.m_msgLen);
			}
			m_Socket.flush();
			
			if( bShowLog )
			{
				trace(new Date().toLocaleTimeString(),"Socket SendMsg "+obXY.GetClassName()+" MsgID="+msgdata.m_msgID+" MsgLen="+msgdata.m_msgLen+" --------------------------------------" );
			}
			
			Logger.log(new Date().toLocaleTimeString(),"Socket SendMsg "+obXY.GetClassName()+" MsgID="+msgdata.m_msgID+" MsgLen="+msgdata.m_msgLen+" ----" );
		}
		
		public function CloseSocket():void
		{
			if( m_Socket && m_Socket.connected )
			{
				m_Socket.close();
			}
		}
		
		public function GetCanUsed():Boolean
		{
			return m_CanUsed;
		}
		public function SetCanUsed(bcanused:Boolean):void
		{
			m_CanUsed = bcanused;
		}
		public function GetCrypt():Boolean
		{
			return m_bCrypt;
		}
		public function SetCrypt(crypt:Boolean):void
		{
			m_bCrypt = crypt;
		}
		public function PrintRecvSend():void
		{
			trace("RecvSendData RecvByte="+m_RecvMsgByte+" RecvPacket="+m_RecvMsgPacket+
				" SendByte="+m_SendMsgByte+" SendPacket="+m_SendMsgPacket );
		}
	}
}

