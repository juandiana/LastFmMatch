package  
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Santiago Rosas
	 */
	public class MoverComponent extends LinearMoverComponent
	{
		private var displayObject:DisplayObject;		
		
		public function MoverComponent(displayObject:DisplayObject, pos:Point, speed:Point = null) 
		{
			this.displayObject = displayObject;			
			super(pos, speed);
			
			displayObject.x = pos.x;
			displayObject.y = pos.y;
		}
		
		
		override protected function mUpdate(aTime:Number):void 
		{
			displayObject.x = mGetX();
			displayObject.y = mGetY();
			super.mUpdate(aTime);
		}
		
		
		public function setDisplayObject(displayObject:DisplayObject):void
		{
			this.displayObject = displayObject;
			displayObject.x = mGetX();
			displayObject.y = mGetY();
		}

	}

}