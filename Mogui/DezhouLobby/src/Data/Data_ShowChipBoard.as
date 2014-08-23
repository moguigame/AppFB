package Data
{
	public class Data_ShowChipBoard
	{
		public var m_MaxChipOnTable:Number;
		public var m_MinAddChip:Number;
		public var m_TopCanChip:Number;
		
		public var m_ChipMoney:Number;
		public var m_TableMoney:Number;
		
		public var m_nBigBlind:int;
		
		public function Data_ShowChipBoard()
		{
			m_MaxChipOnTable = 0;
			m_MinAddChip = 0;
			m_TopCanChip = 0;
			
			m_ChipMoney = 0;
			m_TableMoney = 0;
			
			m_nBigBlind = 0;
		}
	}
}