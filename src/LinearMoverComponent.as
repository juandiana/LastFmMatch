package  {	
		
	import flash.geom.Point

	public class LinearMoverComponent extends AbstractMoverComponent {
		
		private var pSpeed:Point
		private var pAcceleration:Point		
		private var pIsDeccelerating:Boolean;
		private var pDeccelerationModule:Number;
		
		public function LinearMoverComponent(aPos:Point, aSpeed:Point = null, aRotation:Number = 0) {
			super(aPos, aRotation)
			if (aSpeed != null) {
				pSpeed = aSpeed
			} else {
				pSpeed = new Point(0, 0)
			}
			pAcceleration = new Point(0, 0)
		}
		
		
		public override function mDestroy():void {
			pSpeed = null
			pAcceleration = null
			super.mDestroy()
		}
		
		
		override protected function mUpdate(aTime:Number):void {		
			if (!mIsPaused()) {			
				pSpeed.x += pAcceleration.x * aTime
				pSpeed.y += pAcceleration.y * aTime
				
				var vNewPos:Point = mGetPos().clone()
				vNewPos.x += pSpeed.x * aTime
				vNewPos.y += pSpeed.y * aTime
				mSetPos(vNewPos)
				
				if (pIsDeccelerating) {
					mDeccelerate(pDeccelerationModule);
					if (mGetSpeed().length < 10) {
						mStop();
						pIsDeccelerating = false;
					}
				}
								
				super.mUpdate(aTime)
			}
		}
		
		
		/**
		 * Used for predictive collision detection		 
		 */
		override public function mUndoUpdate(aTime:Number):void {
			var vNewPos:Point = mGetPos().clone()
			vNewPos.y -= pSpeed.y * aTime
			vNewPos.x -= pSpeed.x * aTime
			mSetPos(vNewPos)
			
			pSpeed.y -= pAcceleration.y * aTime
			pSpeed.x -= pAcceleration.x * aTime
			
			super.mUndoUpdate(aTime)
		}
		
		
		public function mSetSpeed(aSpeed:Point):void {
			pSpeed = aSpeed.clone()
		}
		
		
		public function mSetSpeedX(aSpeedX:Number):void {			
			pSpeed.x = aSpeedX
		}
		
		
		public function mSetSpeedY(aSpeedY:Number):void {
			pSpeed.y = aSpeedY
		}
		
		
		override public function mGetSpeed():Point {
			return pSpeed
		}
		
				
		public function mGetSpeedX():Number {
			return pSpeed.x
		}
		
		
		public function mGetSpeedY():Number {
			return pSpeed.y
		}
		
		
		public function mIncrease(aDiff:Point):void {
			mIncreaseX(aDiff.x)
			mIncreaseY(aDiff.y)
		}
		
		
		public function mIncreaseX(aDiff:Number):void {
			var vNewPos:Point = mGetPos().clone()
			vNewPos.x += aDiff
			mSetPos(vNewPos)
		}
		
		
		public function mIncreaseY(aDiff:Number):void {
			var vNewPos:Point = mGetPos().clone()
			vNewPos.y += aDiff
			mSetPos(vNewPos)
		}
		
		
		public function mGetAcceleration():Point {
			return pAcceleration
		}
		
		
		public function mSetAcceleration(aAcceleration:Point):void {
			pAcceleration = aAcceleration.clone()
		}
		
		
		public function mSetAccelerationX(aAccelerationX:Number):void {
			pAcceleration.x = aAccelerationX;
		}
		
		
		public function mSetAccelerationY(aAccelerationY:Number):void {
			pAcceleration.y = aAccelerationY;
		}
		
		
		/**
		 * Calculates the time to offset aX in the X axis based on constant acceleration
		 * 			Negative time should be considered that an offset aX is unreachable
		 * @param	aX offset in time
		 * @return	time to offset aX
		 */
		public function mTimeToMoveX(aX:Number):Number {
			if (pAcceleration.x == 0) {
				return aX / pSpeed.x
			} else {
				var vDelta:Number = Math.pow(pSpeed.x, 2) - 2 * pAcceleration.x * ( -aX)
				if (vDelta < 0) {
					return -1
				} else {
					var vSqrtDelta:Number = Math.sqrt(vDelta)
					var vTime1:Number = ( -pSpeed.x + vSqrtDelta) / pAcceleration.x
					var vTime2:Number = ( -pSpeed.x - vSqrtDelta) / pAcceleration.x
					
					if ((vTime1 > 0) && (vTime1 < vTime2)) {
						return vTime1
					} else if ((vTime2 > 0) && (vTime2 < vTime1)) {
						return vTime2
					} else {
						return -1
					}
				}
			}
		}
		
		
		public function mIsStopped():Boolean {
			return pSpeed.x == 0 && pSpeed.y == 0
		}
		
		
		public function mStop():void {
			mSetSpeed(new Point(0, 0))
			mSetAcceleration(new Point(0, 0))
		}
	
		
		public function mGetVelocity():Number {
			return pSpeed.length
		}
		
		
		public function mDeccelerate(deccelerationModule:Number):void 
		{
			var accel:Point = Utils.getOppositeVector(mGetSpeed());
			accel.normalize(deccelerationModule);
			pIsDeccelerating = true;
			pDeccelerationModule = deccelerationModule;
			
			pAcceleration = accel;
		}
		
	}
	
}