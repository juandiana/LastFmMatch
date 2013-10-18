package  {		
	
	import flash.utils.Dictionary;
	
	
	public class Manager extends Manageable {
		
		private var pDictionaries:Array; //of Dictionary
		private var pManageables:Dictionary; //of (Manageable, Manageable)
		private var pComponents:Dictionary; //of (Manageable, Manageable)		
		private var pTimer:TimerComponent;
		
		public function Manager() {
			pManageables = new Dictionary();
			pComponents = new Dictionary();
			pDictionaries = new Array(pManageables, pComponents);
		}
		
		
		public override function mDestroy():void {
			for each (var vDictionary:Dictionary in pDictionaries) {
				for each (var vManageable:Manageable in vDictionary) {
					if (vManageable.mIsRegistered()) {
						vManageable.mDestroy();
						delete vDictionary[vManageable];
					}
				}
			}
			pDictionaries = null;
			pManageables = null;
			pComponents = null;
			pTimer = null;
			super.mDestroy();
		}
		
		
		public function mAddManageable(aManageable:Manageable):Manageable {
			if (aManageable == null) {
				throw new ArgumentError("The argument can't be null");
			}
			pManageables[aManageable] = aManageable;
			return aManageable;
		} 
		
		
		public function mAddComponent(aComponent:Manageable):Manageable {
			if (aComponent == null) {
				throw new ArgumentError("The argument can't be null");
			}
 			pComponents[aComponent] = aComponent;
			return aComponent;
		}
		
		
		public function mRemoveManageable(aManageable:Manageable):void {
			delete (pManageables[aManageable]);
		}
		
		
		public function mRemoveComponent(aComponent:Manageable):void {
			delete (pComponents[aComponent]);
		}
		
		
		public override function mRender():void {
			for each (var vDictionary:Dictionary in pDictionaries) {
				for each (var vManageable:Manageable in vDictionary) {
					if (vManageable.mIsRegistered()) {
						vManageable.mRender();
					}
				}
			}
		}
		
		
		protected override function mUpdate(aTime:Number):void {			
			for each (var vDictionary:Dictionary in pDictionaries) {
				for each (var vManageable:Manageable in vDictionary) {
					if (vManageable.mIsRegistered()) {
						vManageable.mUpdateIfNotPaused(aTime);
					}
					else {
						vManageable.mDestroy();
						delete (vDictionary[vManageable]);
					}
				}
			}
		}
		
		
		public function mGetManageables():Dictionary {
			return pManageables;
		}

		
		protected function mUnregisterAllManageables():void {
			for each (var vManageable:Manageable in pManageables)  {
				vManageable.mDestroy();
			}
		}
		
		
		override public function mPause():void  {
			for each (var vDictionary:Dictionary in pDictionaries) {
				for each (var vManageable:Manageable in vDictionary) {					
					vManageable.mPause();
				}
			}			
			super.mPause();
		}
		
		
		override public function mResume():void  {
			for each (var vDictionary:Dictionary in pDictionaries) {
				for each (var vManageable:Manageable in vDictionary) {			
					vManageable.mResume();
				}
			}
			super.mResume();
		}
		
		
		override public function mSetId(aId:String):void  {
			for each (var vDictionary:Dictionary in pDictionaries) {
				for each (var vManageable:Manageable in vDictionary) {
					vManageable.mSetId(aId);
				}
			}
			super.mSetId(aId);
		}
		
		
		/**		 
		 * Calls the function aFunctionToCall aNumCall times with an interval of aTimeBetweenCalls.
		 * @param aNumCalls If 0, calls infinitely.
		 */
		public function schedule(aScheduledFunction:Function, aTimeBetweenCalls:Number, 
		aNumCalls:int = 1):void {
			//Creo el timer a demanda
			if (pTimer == null) {
				pTimer = (TimerComponent) (mAddComponent(new TimerComponent()));
			}
			pTimer.mTimedCall(aScheduledFunction, aTimeBetweenCalls, aNumCalls);
		}
		  
		public function unschedule(aScheduledFunction:Function):void {
			if (pTimer != null) {
				pTimer.mCancelTimedCall(aScheduledFunction);
			}
		}
		
		
		public function traceIf(aId:String, ...rest):void {
			if (aId == mGetId()) {
				trace(rest);
			}
		}
		
		
		public function hasManageableOfClass(aClass:Class):Boolean
		{
			return getManageableOfClass(aClass) != null;
		}
		
		
		public function getManageableOfClass(aClass:Class):*
		{
			for each (var manageable:Manageable in pManageables) {
				if (manageable is aClass) {
					return manageable;
				}
			}
			return null;
		}
		
		
		protected function assert(condition:Boolean):void
		{
			if (!condition) {
				throw new Error("Assert failed");
			}
		}
	}
}
