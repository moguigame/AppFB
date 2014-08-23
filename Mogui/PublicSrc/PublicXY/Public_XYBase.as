package PublicXY
{
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;
	
	import MoGui.net.MsgData;
	
	public class Public_XYBase implements Public_XYInterFace
	{
		protected var m_strClassName:String;
		
		public function Public_XYBase()
		{
			m_strClassName = "";
			var tempArray:Array = getQualifiedClassName(this).split("::");
			if ( tempArray.length > 0 )
			{
				m_strClassName = tempArray[tempArray.length - 1];
			}
			//trace(m_strClassName + " Init...");
		}
		
		public function Write(msgdata:MsgData):void
		{
			trace(m_strClassName + " Write Error ????");
		}
		public function Read(msgdata:MsgData):void
		{
			trace(m_strClassName + " Read Error ????");
		}
		
		public function GetClassName():String
		{
			return m_strClassName;
		}
		
		public function DescPrint():void
		{
			//var tempXML:XML = describeType(this);
			//trace(tempXML.variable);
		}
	}
}