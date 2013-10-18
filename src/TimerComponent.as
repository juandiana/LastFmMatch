package  {		
	import flash.events.TimerEvent
	import flash.utils.Dictionary
	
	
	/**
	 * Component to be added to entities that need to call functions
	 * with a certain delay, e.g. a character that blinks and needs
	 * to stop blinking in 3 seconds.	 
	 */
	
	public class TimerComponent extends Manager {
		private var pTimersByFunction:Dictionary
		
		public function TimerComponent() {			
			pTimersByFunction = new Dictionary()
		}
		
		
		/**
		 * Called on mDestroy() of the subclass or anytime that the current
		 * timed callers should no longer be used.
		 */
		public override function mDestroy():void {			
			pTimersByFunction = null
			super.mDestroy()
		}
		
		
		/**
		 * Calls the function aFunctionToCall when aWaitDuration seconds
		 * have elapsed.
		 * @param	aFunctionToCall Function to be called
		 * @param	aWaitDuration Time after which the function will be called
		 * @param	aRepeatCount Number of times to call the function. 0 is infinity.
		 */
		public function mTimedCall(aFunctionToCall:Function,
			aDelay:Number, aRepeatCount:int = 1):void {
			var vTimer:Timer = new Timer(aDelay, aRepeatCount)
			vTimer.addEventListener(TimerEvent.TIMER, aFunctionToCall)
			pTimersByFunction[aFunctionToCall] = vTimer
			mAddManageable(vTimer)
		}
		
		
		public function mCancelTimedCall(aFunctionToCall:Function):void {
			var vTimer:Timer = pTimersByFunction[aFunctionToCall]
			if (vTimer != null) {
				vTimer.mDestroy()
				delete pTimersByFunction[aFunctionToCall]				
			}
		}
		
		public function mHasTimedCall(aFunctionToCall:Function):Boolean {
			return pTimersByFunction[aFunctionToCall] != null
		}
		
	}
}