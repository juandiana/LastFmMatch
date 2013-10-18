package   {	
	import flash.events.TimerEvent
	
	
	public class Timer extends Manager {
		
		private var pTime:Number
		private var pDelay:Number
		private var pRepeatCount:int				
		
		public function Timer(aDelay:Number, aRepeatCount:int = 0)  {
			pDelay = aDelay
			
			if (aRepeatCount == 0) {
				pRepeatCount = -1
				//Infinite repeats
			} else {
				pRepeatCount = aRepeatCount
			}
			
			pTime = 0.0			
		}
		
		
		override protected function mUpdate(aTime:Number):void  {			
			pTime += aTime
			if (pTime >= pDelay) {
				dispatchEvent(new TimerEvent(TimerEvent.TIMER))
				if (pRepeatCount == -1) {
					//Infinite repeats
					pTime = 0
				} else if (pRepeatCount > 1) {
					pTime = 0
					pRepeatCount--
				} else {
					dispatchEvent(new TimerEvent(TimerEvent.TIMER_COMPLETE))
					mDestroy()
				}
			}
			super.mUpdate(aTime)
		}
		
	}

}
