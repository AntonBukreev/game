package utils
{
	public class M
	{
		public function M()
		{
		}
		
		public static function pow(i:Number):Number
		{
			return i*i;
		}
		public static function randomSign():int
		{
			var i:Number = Math.random()-0.5; 
			if(i>0) return 1;
			return -1;
		}
	}
}