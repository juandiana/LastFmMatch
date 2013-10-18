package  {	
	
	import flash.events.Event
	import flash.geom.Point
	
	
	public class AbstractMoverComponent extends Manager {
		
		/**
		 * Dispatched when the position of the Mover is changed.
		 */
		public static const EVENT_POSITION_CHANGED:String = "EVENT_POSITION_CHANGED"
			
		private var pPos:Point		
		private var pRotation:Number		
		private var pParent:AbstractMoverComponent		
		private var pScale:Number
		
		public function AbstractMoverComponent(aPos:Point, 
			aRotation:Number = 0, aScale:Number = 1) {
			pPos = aPos.clone()
			pRotation = aRotation
			pScale = aScale
		}
		
		
		public function mSetParent(aParent:AbstractMoverComponent):void {
			pParent = aParent
		}
		
		
		override public function mDestroy():void  {
			pPos = null			
			super.mDestroy()
		}
		
		
		public function mGetPos():Point {
			return pPos
		}
		
		
		public function mGetOrigin():Point {
			if (pParent == null) {
				return new Point(0, 0)
			} else {			
				return pParent.mGetAbsolutePos()
			}
		}
		
		
		public function mGetRotation():Number {
			return pRotation
		}
		
		
		public function mGetScale():Number {
			return pScale
		}
		
		
		public function mGetAbsolutePos():Point {						
			var vPos:Point = Utils.rotateVector(pPos, mGetAbsoluteRotation())
			var vPosScaled:Point = Utils.multiplyVector(vPos, pScale)						
			var vAbsolutePos:Point = vPosScaled.add(Utils.multiplyVector(mGetOrigin(), pScale))
			return vAbsolutePos
		}

		
		public function mGetAbsoluteRotation():Number {
			if (pParent == null) {
				return pRotation
			} else {			
				return pParent.mGetAbsoluteRotation() + pRotation
			}
		}

		
		public function mSetX(aX:Number):void {
			var vNewPos:Point = mGetPos().clone()
			vNewPos.x = aX
			mSetPos(vNewPos)
		}

		
		public function mSetY(aY:Number):void {
			var vNewPos:Point = mGetPos().clone()
			vNewPos.y = aY
			mSetPos(vNewPos)
		}
		
		
		public function mGetX():Number {
			return mGetPos().x
		}
				
		
		public function mGetY():Number {
			return mGetPos().y
		}
		
		
		public function mSetPos(aPos:Point):void {
			pPos = aPos.clone()
		}
		
		
		public function mSetRotation(aRotation:Number):void {
			pRotation = aRotation			
		}		
		
		
		public function mSetScale(aScale:Number):void {
			pScale = aScale
		}

		
		public function mGetSpeed():Point {
			throw new Error(this)
		}

		
		
		public function mUndoUpdate(aTime:Number):void {
			
		}
		
		
		/**
		 * Removes the parent and sets the relative position to the absolute position.
		 */
		public function mRemoveParent():void {
			pPos = mGetAbsolutePos()						
			pParent = null			
		}
		
		
		public function mGetNextPos(aTime:Number):Point {
			mUpdate(aTime) //Simulate update
			var vNextPos:Point = pPos.clone()
			mUndoUpdate(aTime)
			return vNextPos
		}
		
	}

}