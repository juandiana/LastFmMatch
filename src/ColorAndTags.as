package  
{
	/**
	 * ...
	 * @author 
	 */
	public class ColorAndTags 
	{
		private var color:Color;
		public var tags:Vector.<String>;		
		
		public function ColorAndTags(color:Color, tags:Vector.<String>)
		{
			this.color = color;
			this.tags = tags;
		}

		
		public function containsTag(aTag:String):Boolean 
		{
			for each (var tag:String in tags) {
				if (tag.toLowerCase() == aTag.toLowerCase()) {
					return true;
				}
			}
			return false;
		}
		
		
		public function getColor():Color
		{
			return color;
		}
		
	}

}