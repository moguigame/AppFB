package PublicXY
{
	import MoGui.net.MsgData;
	
	public interface Public_XYInterFace
	{
		function Write(msgdata:MsgData):void;
		function Read(msgdata:MsgData):void;
	}
}