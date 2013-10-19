package  
{
	/**
	 * ...
	 * @author 
	 */
	public class Color 
	{
		
		public var r:int;
		public var g:int;
		public var b:int;		
		
		public function Color(r:int, g:int, b:int) 
		{
			this.r = r;
			this.g = g;
			this.b = b;
		}

		
		public function isEqual(color:Color):Boolean
		{
			return r == color.r && g == color.g && b == color.b;
		}
		
	}

}