package MoGui.display
{
	import flash.display.BlendMode;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	public class CText extends CMoguiSprite
	{		
		private var m_textFiled:TextField;
		private var m_textFormat:TextFormat;
		
		private var m_bAutoCenter:Boolean = false;
		private var m_ptCenter:Point = new Point(0,0);
		
		public function CText(strFont:String="宋体",bBold:Boolean=false,nColor:Object=0xffffff,nSize:Object=12)
		{		
			this.blendMode = BlendMode.LAYER;
			
			m_textFiled = new TextField();
			m_textFormat = new TextFormat();
			
			m_textFormat.bold = bBold;
			m_textFormat.color = nColor;
			m_textFormat.size = nSize;
			m_textFormat.font = strFont;
			
			m_textFiled.border = false;
			m_textFiled.background = false;
			m_textFiled.autoSize = TextFieldAutoSize.LEFT;
			m_textFiled.selectable = false;
			m_textFiled.type = TextFieldType.DYNAMIC;
			
			addChild(m_textFiled);
		}
		
		public function GetWidth():int
		{
			return m_textFiled.textWidth;
		}
		
		public function GetHeight():int
		{
			return m_textFiled.textHeight;
		}
		
		public function SetCenterPoint(pt:Point):void
		{
			m_bAutoCenter = true;
			
			m_ptCenter.x = pt.x;
			m_ptCenter.y = pt.y;
			
			CenterByPoint(m_ptCenter);
		}
		
		public function SetCenterPointXY(cx:int, cy:int):void
		{
			m_bAutoCenter = true;
			
			m_ptCenter.x = cx;
			m_ptCenter.y = cy;
			
			CenterByPoint(m_ptCenter);
		}
		
		public function SetTextColor(color:Object):void
		{
			m_textFormat.color = color;
			UpDateText();
		}
		
		public function SetBold(bBlod:Boolean):void
		{
			m_textFormat.bold = bBlod;
			UpDateText();
		}
		
		public function SetFont(strFont:String):void
		{
			m_textFormat.font = strFont;
			UpDateText();
		}
		
		public function SetTextSize(size:int):void
		{
			m_textFormat.size = size;
			UpDateText();
		}
		
		public function SetTextAlign(str:String):void
		{
			m_textFormat.align = str;
			UpDateText();
		}
		
		public function SetHtmlText(str:String):void
		{
			m_textFiled.htmlText = str;
		}
		
		public function SetText(str:String):void
		{
			m_textFiled.text = str;
			UpDateText();
			
			if ( m_bAutoCenter )
			{
				CenterByPoint(m_ptCenter);
			}
		}
		public function set text(str:String):void
		{
			m_textFiled.text = str;
			UpDateText();
			
			if ( m_bAutoCenter )
			{
				CenterByPoint(m_ptCenter);
			}
		}
		
		public function GetText():String
		{
			return m_textFiled.text;
		}
		public function get text():String
		{
			return m_textFiled.text;
		}
		
		
		public function SetTextFormat(format:TextFormat):void
		{
			m_textFormat = format;
			UpDateText();
		}
		public function GetTextFormat():TextFormat
		{
			return m_textFormat;
		}
		
		public function UpDateText():void
		{
			m_textFiled.setTextFormat(m_textFormat);
		}
	}
}