package MoGui.controls
{
	import fl.controls.TextArea;
	import fl.events.ComponentEvent;
	import fl.motion.Color;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextFormat;
	import fl.controls.ScrollPolicy;
	import flash.utils.getTimer;
	
	public class CLogText extends TextArea
	{		
		var m_strEnd:String = new String();
		var m_StartTime:Number;
		
		public function CLogText()
		{
			this.alpha = 1;			
			this.editable = false;
			
			var i:int;
			for ( i = 0; i < 26; i++ )
				m_strEnd += String.fromCharCode( 97 + i );
	
			for ( i = 0; i < 26; i++ )
				m_strEnd += String.fromCharCode( 65 + i );
	
			for ( i = 0; i < 10; i++ )
				m_strEnd += String.fromCharCode( 48 + i );
			
			m_strEnd += "\\";
			m_strEnd += "\/";
			m_strEnd += "_";
			m_strEnd += ".";
			m_strEnd += ":";
			
			m_StartTime = getTimer();
		}		
		
		public function AddStr( str:String,bShowTime:Boolean=false ):void
		{
			if ( bShowTime )
			{				
				str = String( getTimer() - m_StartTime )+":" + str;
			}
			
			this.htmlText += "<font size='12'>" + GetHtmlStr(str) + "</font>";		
			this.verticalScrollPosition = this.textHeight;
		}
		
		public function GetHtmlStr(src:String):String
		{			
			var strRet:String = "";
			
			if (src == null || src == "")
			{
				return strRet;
			}
			
			src += " ";
			
			var strStart1:RegExp = /www\./i;
			var strStart2:RegExp = /http:\/\//i;  //忽略大小写
			
			var position:int = 0;var k:int = 0;
			var TempLen:int = src.length;
			var StrTemp:String = "";
			
			var pos1 = src.search(strStart1);
			var pos2 = src.search(strStart2);
			
			if ( pos1 > -1 && pos2 > -1)
				position = Math.min(pos1,pos2);
			else
				position = Math.max(pos1,pos2);
			
			if (position != -1 )
			{
				strRet += "<font color='#B3DAAD' >"
				strRet += src.slice(0, position);
				strRet += "</font>"
				
			    strRet +=  "<font color='#0000ff' >";
			    strRet +=  "<a href='";
			
				k = -1;
				for (var i = position; i < TempLen; i++ )
				{
					if ( IsEndChar(src.charAt(i)) )
					{
						k = i;
						break;
					}
				}
				if ( k != -1  )
				{
					StrTemp = src.slice(position, k);
					StrTemp.toLowerCase();
					
					if ( src.charAt(position) == "w" || src.charAt(position) == "W")
					{
						strRet += "http://";
					}
					
					strRet += StrTemp;		
					strRet +=  "'>";
				
					strRet +=  StrTemp;
					strRet +=  "</a></font>";
					
				    var strTemp:String = src.slice(k, TempLen);
				    if(strTemp.length > 1)	
					  strRet += GetHtmlStr(strTemp);
				}
				else
				{
					strRet += src.slice(position, TempLen);
				}
			}
			else
			{
				 strRet += "<font color='#B3DAAD' >"
				 strRet += src;
				 strRet += "</font>"
			}
			
			return strRet
		}
		
		public function IsEndChar(ch:String):Boolean
		{
			return (m_strEnd.indexOf(ch) == -1);
		}
		
		public function Init():void
		{
			htmlText = "";
			textField.text = "";
			m_StartTime = getTimer();
		}
	}
}

/*
myText += "<p>You can use the <b> tag to create <b>bold</b> text.</p>";
myText += "<p>You can use the <i> tag to create <i>italic</i> text.</p>";
myText += "<p>You can use the <u> tag to create <u>underlined</a> text.</p>";
myText += "<p>You can use the <a> tag to create <a href='http://www.adobe.com'>links to other sites</a>.</p>";
myText += "<p>You can use the <br> tag to create<br>new lines of text<br>whenever you want.</p>";
myText += "<p>You can use the <font> tag to specificy different font <font color='#FF0000'>colors</font>, <font size='16'>sizes</font>, or <font face='Times New Roman'>faces</font>.</p>";
myText += "<p>You can use the <img> tag to load images or SWF files:<br><img src='http://www.helpexamples.com/flash/images/logo.png'>.</p>";
*/