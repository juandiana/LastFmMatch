package  {
	import flash.events.EventDispatcher	
	
	
	public class Manageable extends EventDispatcher {
		
		private var pIsRegistered:Boolean
		private var pIsPaused:Boolean		
		private var pId:String
		
		public function Manageable() {
			pIsRegistered = true
			pIsPaused = false			
		}
		
		
		public function mDestroy():void {
			pId = null
			pIsRegistered = false          			
		}		


		public function mUpdateIfNotPaused(aTime:Number):void {
			if (!mIsPaused()) {
				mUpdate(aTime)
			}
		}

		
		protected function mUpdate(aTime:Number):void {
		
		}
		
		
		public function mRender():void {
		
		}
		
		
		public function mIsRegistered():Boolean {
			return pIsRegistered
		}
		
		
		/**
		 * Stops updating.
		 */
		public function mPause():void {
			pIsPaused = true
		}
		
		
		/**
		 * Continues updating.
		 */
		public function mResume():void {			
			pIsPaused = false			
		}
		
		
		public function mIsPaused():Boolean { 
			return pIsPaused
		}
		
		
		public function mGetId():String {
			return pId
		}
		
		
		public function mSetId(aId:String):void {
			pId = aId			
		}

		
		public function mTraceIfHasId(...rest):void {
			if 	(pId != null) {
				trace(rest)
			}
		}
		
		public function mUnregister():void {
			pIsRegistered = false
		}
	}
}