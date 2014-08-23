package MoGui.net
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import MoGui.utils.CFunction;

	public class MsgData
	{
		public static const s_CharSet:String     = "GB2312";
		
		private static const  DATA_FLAG_0:int        = 0;
		private static const  DATA_FLAG_CHAR:int     = 1;
		private static const  DATA_FLAG_SHORT:int    = 2;
		private static const  DATA_FLAG_INT:int      = 3;
		private static const  DATA_FLAG_LONGLONG:int = 4;
		
		private static const  INT8_MIN:int           = -0x80;
		private static const  INT16_MIN:int          = -0x8000;
		private static const  INT32_MIN:int          = -0x80000000;
		
		private static const  INT8_MAX:int           = 0x7f;
		private static const  INT16_MAX:int          = 0x7fff;
		private static const  INT32_MAX:int          = 0x7fffffff;		
		
		public var m_msgID:int;
		public var m_msgLen:int;
		public var m_dataArray:ByteArray;
		
		public function MsgData()
		{
			m_msgID = 0;
			m_msgLen = 0;
			
			m_dataArray = new ByteArray();
			m_dataArray.endian = Endian.LITTLE_ENDIAN;
		}
		public function Init():void
		{
			m_msgID = 0;
			m_msgLen = 0;
			m_dataArray.position = 0;
		}
		public function ResetDataPosition():void
		{
			m_dataArray.position = 0;
		}
		
		public function GetMsg(msgBA:ByteArray,nAvailByte:int):Boolean
		{			
			var retSuccess:Boolean = false;
			var nOldPosition:int = msgBA.position;
			
			if( nAvailByte >= 3 )
			{
				m_msgLen = 	msgBA.readUnsignedByte();
				nAvailByte -= 1;
				if( m_msgLen == 255 )
				{
					m_msgLen = msgBA.readUnsignedShort();
					nAvailByte -= 2;
				}
				if( m_msgLen >= 0 && nAvailByte >= m_msgLen+2 )
				{
					m_msgID = msgBA.readUnsignedShort();
					if ( m_msgLen > 0 )
					{
						msgBA.readBytes(m_dataArray,0,m_msgLen);
					}
					retSuccess = true;
				}
			}
			if( !retSuccess )
			{
				msgBA.position = nOldPosition;
			}
			
			return retSuccess;
		}
		
		public function WriteBytes(srcBytes:ByteArray,nlen:int):void
		{
			m_dataArray.writeBytes(srcBytes,srcBytes.position,nlen);
		}
		public function ReadBytes(desBytes:ByteArray,nlen:int):void
		{
			m_dataArray.readBytes(desBytes,desBytes.position,nlen);
		}
		
		
		public function WriteString(srcStr:String):void
		{
			var nStrLen:int = CFunction.GetRealStrLength(srcStr,s_CharSet);
			if( nStrLen < 255 )
			{
				m_dataArray.writeByte(nStrLen);
				m_dataArray.writeMultiByte(srcStr,s_CharSet);
			}
			else if( nStrLen >= 255 )
			{
				m_dataArray.writeByte(255);
				m_dataArray.writeShort(nStrLen);
				m_dataArray.writeMultiByte(srcStr,s_CharSet);
			}
			else
			{
				m_dataArray.writeByte(0);
			}
		}
		public function ReadString():String
		{
			var retStr:String = "";
			var nStrLen:uint = m_dataArray.readUnsignedByte();
			if( nStrLen>0 && nStrLen<255 )
			{
				retStr = m_dataArray.readMultiByte(nStrLen,s_CharSet);
			}
			else if( nStrLen >= 255 )
			{
				nStrLen = m_dataArray.readUnsignedShort();
				retStr = m_dataArray.readMultiByte(nStrLen,s_CharSet);
			}
			return retStr;
		}
		
		
		public function WriteByte(srcInt:int):void
		{
			m_dataArray.writeByte(srcInt);
		}
		public function ReadByte():int
		{
			return m_dataArray.readByte();
		}
		public function ReadUnsignedByte():int
		{
			return m_dataArray.readUnsignedByte();
		}
		
		
		public function WriteShort(srcInt:int):void
		{
			m_dataArray.writeShort(srcInt);
		}
		public function ReadShort():int
		{
			return m_dataArray.readShort();
		}
		public function ReadUnsignedShort():int
		{
			return m_dataArray.readUnsignedShort();
		}
		
		
		public function WriteInt(srcInt:int):void
		{
			m_dataArray.writeInt(srcInt);
		}
		public function ReadInt():int
		{
			return m_dataArray.readInt();
		}
		public function WriteUnsignedInt(srcUint:uint):void
		{
			m_dataArray.writeUnsignedInt(srcUint);
		}
		public function ReadUnsignedInt():uint
		{
			return m_dataArray.readUnsignedInt();
		}		
		
		public function WriteInt64(srcNumber:Number):void
		{
			var ChuShu:Number = Number(4)*(1<<30);
			var HighInt:int   = int(srcNumber/ChuShu);
			var LowInt:uint   = srcNumber - HighInt*ChuShu;
			
			m_dataArray.writeUnsignedInt(LowInt);
			m_dataArray.writeInt(HighInt);			
		}
		public function ReadInt64():Number
		{
			var ChuShu:Number = Number(4)*(1<<30);
			
			var LowInt:Number    = m_dataArray.readUnsignedInt();
			var HighInt:Number   = m_dataArray.readInt();			
			var retNumber:Number = HighInt*ChuShu + LowInt;
			
			return retNumber;
		}		
		
		public function WriteBigNumber(srcNumber:Number):void
		{
			if( srcNumber == 0 )
			{
				m_dataArray.writeByte(0);
			}
			else if( srcNumber>=INT8_MIN && srcNumber<=INT8_MAX )
			{
				m_dataArray.writeByte(DATA_FLAG_CHAR);
				m_dataArray.writeByte(int(srcNumber));
			}
			else if( srcNumber>=INT16_MIN && srcNumber<=INT16_MAX )
			{
				m_dataArray.writeByte(DATA_FLAG_SHORT);
				m_dataArray.writeShort(int(srcNumber));
			}
			else if( srcNumber>=INT32_MIN && srcNumber<=INT32_MAX )
			{
				m_dataArray.writeByte(DATA_FLAG_INT);
				m_dataArray.writeInt(int(srcNumber));
			}
			else
			{
				m_dataArray.writeByte(DATA_FLAG_LONGLONG);
				WriteInt64(srcNumber);
			}
		}
		public function ReadBigNumber():Number
		{
			var retNumber:Number = 0;
			var nFlag:int = m_dataArray.readByte();
			switch( nFlag )
			{
				case DATA_FLAG_0:
				{
				}
				break;
				case DATA_FLAG_CHAR:
				{
					retNumber = m_dataArray.readByte();
				}
				break;
				case DATA_FLAG_SHORT:
				{
					retNumber = m_dataArray.readShort();
				}
				break;
				case DATA_FLAG_INT:
				{
					retNumber = m_dataArray.readInt();
				}
				break;
				case DATA_FLAG_LONGLONG:
				{
					retNumber = ReadInt64();
				}
				break;
				default:
				{
					trace("ReadBigNumber Error Error ????????? ");
				}
			}
			
			return retNumber;			
		}
	}
}