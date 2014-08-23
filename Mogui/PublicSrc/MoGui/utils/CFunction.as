package MoGui.utils
{
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	
	public class CFunction
	{
		public function CFunction()
		{
		}
		
		static public function GetCrossRect(rt1:Rectangle,rt2:Rectangle):Rectangle
		{
			var retRect:Rectangle = new Rectangle();
			
			retRect.x = rt1.left > rt2.left?rt1.left:rt2.left;
			retRect.y = rt1.top > rt2.top?rt1.top:rt2.top;
			retRect.width = (rt1.right < rt2.right?rt1.right:rt2.right) - retRect.x;
			retRect.height = (rt1.bottom < rt2.bottom?rt1.bottom:rt2.bottom) - retRect.y;
			
			return retRect;
		}
		
		//len指的是字节数，比如汉定占两字节
		static public function GetPartStr(str:String, len:int):String
		{
			var retStr:String;
			var TempStr:String;
			
			if ( GetRealStrLength(str) <= len )
			{
				retStr = str;
			}
			else
			{
				var i:int;
				var k:int = str.length;
				for (i = len/2; i <= str.length; i++ )
				{
					TempStr = str.slice(0, i);
					if ( GetRealStrLength(TempStr) > len )
					{
						k = i - 1;
						break;
					}
				}				
				retStr = str.slice(0,k);
			}
			
			return retStr;
		}
		
		static public function GetRealStrLength(str:String,type:String="gb2312"):int
		{
			var retArray:ByteArray = new ByteArray();
			
			if( str.length > 0 )
			{
				retArray.writeMultiByte(str, type);
				return retArray.position;
			}
			else
			{
				return 0;
			}
		}
		
		static public function PrintByteArray(BA:ByteArray,strSlice:String=" "):void
		{
			var OldPosition:int = BA.position;			
			BA.position = 0;
			
			var strRet:String = "";
			var nLength:int = BA.length;
			while( nLength > 0 )
			{
				strRet += (BA.readByte() + strSlice);
				nLength--;
			}
			trace(strRet);
			
			BA.position = OldPosition;
		}
		
		static public function GetStringValue(strRule:String,strKey:String,strSplit:String=";"):String
		{
			var strRet:String = "";
			strRule = strRule.toLowerCase();
			strKey = strKey.toLowerCase();
			
			var TempArray:Array = strRule.split(strSplit);
			for(var i:int=0;i<TempArray.length;++i)
			{
				var KeyValueArray:Array = TempArray[i].split("=");
				if( KeyValueArray.length == 2 )
				{
					if( KeyValueArray[0] == strKey )
					{
						strRet = KeyValueArray[1];
					}
				}
			}
			return strRet;
		}
		
		static public function CopyArray(srcArray:Array,desArray:Array):void
		{
			for(var i:int=0;i<srcArray.length;++i)
			{
				desArray.push(srcArray[i]);
			}
		}
	}
}