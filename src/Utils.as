package   {	
	
	import flash.display.BitmapData
	import flash.display.DisplayObject
	import flash.display.DisplayObjectContainer
	import flash.display.MovieClip
	import flash.display.SimpleButton
	import flash.geom.ColorTransform
	import flash.geom.Matrix
	import flash.geom.Point
	import flash.geom.Rectangle
	import flash.text.TextField
	import flash.utils.Dictionary
	import flash.utils.describeType
	import flash.utils.getDefinitionByName	
	import flash.utils.getQualifiedClassName
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class Utils {
		
		//------------------------------------------------------------------------------------------
		// CLASS UTIILITIES
		//------------------------------------------------------------------------------------------
		
		
		static public function getRandomElementFromArray(aArray:Array):* {
			return aArray[Math.floor(aArray.length * Math.random())]
		}
		
		
		static public function getClassName(aObject:Object):String {
			return getQualifiedClassName(aObject).split("::")[1]
		}
		
		
		static public function getStackTrace():String {
			return new Error().getStackTrace()
		}
		
		
		/**
		 * Returns a string specifying the method and line number that is calling the caller of 
		 * this function.
		 * @param (Optional) aDepth Depth of the stack, to get callers deeper than the first.
		 * @example gmGetClassName[164]
		 */
		static public function getCallerMethod(aDepth:int = 0):String {
			var vStacktrace:String = new Error().getStackTrace()
			if (vStacktrace != null) { 
				var vParts:Array = vStacktrace.split("\n\t\at")
				var vMethodLine:String = vParts[3 + aDepth]
				
				var vMethodName:String
				
				//Handle both constructor and method cases
				if (vMethodLine.search("/") == -1) {
					//Method case
					vMethodName = "ctor()"				
				} else {
					//Constructor case
					vMethodName = vMethodLine.split("/")[1]
					vMethodName = vMethodName.split("[")[0]
				}
				
				var vLineNumber:String = vMethodLine.split(".as:")[1]
				
				return vMethodName + "[" + vLineNumber
			}
			else {
				return "Method"
			}
		}
		
		
		static public function getQualifiedCallerClassName(aStackDepth:int = 0):String {
			var vStacktrace:String = new Error().getStackTrace()
			if (vStacktrace != null) { 
				var vParts:Array = vStacktrace.split("\n\t\at")
				var vMethodLine:String = vParts[3 + aStackDepth]						
				var vClassName:String
				
				if (vMethodLine.indexOf("$cinit") != -1) {
					//Static initalizer
					vClassName = vMethodLine.split("$cinit")[0]
				} else {
					vClassName = vMethodLine.split("()")[0]	
				}
				
				vClassName = vClassName.replace("::", ".")
				vClassName = vClassName.replace(" ", "")			
				return vClassName
			}
			else {
				return "Class"
			}
		}
		
		
		static public function getSimpleCallerClassName(aStackDepth:int = 0):String {
			var vSplitQualifiedName:Array = getQualifiedCallerClassName(aStackDepth).split(".")
			var vClassAndMethodName:String = getLastArrayElement(vSplitQualifiedName)
			//e.g. SymbolSlot/mUpdate
			return vClassAndMethodName.split("/")[0]
		}
		
		
		static public function dotProduct(aPoint1:Point, aPoint2:Point):Number {
			return (aPoint1.x * aPoint2.x + aPoint1.y * aPoint2.y)
		}
		
		
		static public function getLastArrayElement(aArray:Array):* {
			return aArray[aArray.length - 1]
		}
		
		
		static public function getObjectClass(aObject:Object):Class {
			return (Class)(getDefinitionByName(getQualifiedClassName(aObject)))
		}
		
		
		static public function getDisplayObjectName(displayObject:DisplayObject):String 
		{
			return displayObject.toString().split("[object ")[1].split("]")[0];
		}
		
		static public function isDifferentToAll(string:String, ...otherStrings):Boolean 
		{
			for (var i:int = 0; i < otherStrings.length; i++) {
				if (string == otherStrings[i]) {
					return false;
				}				
			}
			return true;
		}
		
		
		//------------------------------------------------------------------------------------------
		// MATH UTILITIES - GENERAL
		//------------------------------------------------------------------------------------------		
		
		/**
		 * Returns the sum of the elements of an array.
		 * @param	aArray an array of int or Number
		 * @return
		 */
		static public function getArraySum(aArray:Array):Number {
			var vSum:Number = 0
			for (var i:int = 0; i < aArray.length; i++) {
				vSum += aArray[i]
			}
			return vSum
		}

		
		//------------------------------------------------------------------------------------------
		// MATH UTILITIES - RANDOMNESS
		//------------------------------------------------------------------------------------------
		
		/**
		 * @example (0, 6) => random between (0, 5) (including 0 and 5)
		 */
		static public function getRandomIntBetween(aInt1:int, aInt2:int):int {
			return aInt1 + Math.floor(Math.random() * (aInt2 - aInt1 + 1))
		}
		
		
		static public function getRandomNumberBetween(aNumber1:Number, aNumber2:Number):Number {
			return aNumber1 + (Math.random() * (aNumber2 - aNumber1))
		}
		
		
		static public function getFrequenciesArray(numbersArray:Array):Array
		{
			//1         - total
			//frequency - number
			
			//e.g. numbersArray = {1,2,3}
			//total = 6
			//frequenciesArray = {1/6, 2/6, 3/6}
			
			var total:Number = getArraySum(numbersArray);
			var frequenciesArray:Array = new Array();
			
			for each (var number:Number in numbersArray) {
				frequenciesArray.push(number / total);
			}
			return frequenciesArray;
		}

		
		static public function getRandomArrayElementFromNumbers(array:Array, numbersArray:Array):*
		{
			if (getArraySum(numbersArray) == 0) {
				throw new ArgumentError("All numbers are 0");
			}
			
			return getRandomArrayElementFromFrequencies(array, getFrequenciesArray(numbersArray));
		}

		/**
		 * @param	aFrequencies an array of frequencies (Numbers), whose sum is 1.0, 
		 * e.g. {0.3, 0.2, 0.5}
		 * @return  A random int, that's an index of aFrequencies, randomized according to the
		 * frequencies. 
		 * @example If aFrequencies == {1.0} it will always return 0.
		 * If aFrequencies == {0.1, 0.9}, it will return 0 with a frequency of 1/10, and
		 * 1 with a frequency of 9/10.
		 */
		static public function getRandomIntFromFrequencies(aFrequencies:Array):int {
			if (aFrequencies == null) {
				throw new ArgumentError("The frequency array can't be null.")
			}
			if (!(aFrequencies[0] is Number || aFrequencies[0] is int)) {
				throw new ArgumentError("The frequencies must be ints or Numbers")
			}			
			
			//the frequencies must sum up to 1.0
			if (Math.abs(getArraySum(aFrequencies) - 1.0) > 0.01) {
				throw new ArgumentError(
				"The frequencies doesn't sum up to 1.0. The actual sum is " +
				getArraySum(aFrequencies))
			}
			
			var vRandom:Number = Math.random()
			var vFrequencyAccumulator:Number = 0
			
			for (var i:int = 0; i < aFrequencies.length; i++) {
				if (new String(aFrequencies[i]) == "NaN") {
					throw new ArgumentError("A frequency is NaN");
				}
				
				vFrequencyAccumulator += aFrequencies[i]				
				if (vRandom < vFrequencyAccumulator) {
					return i
				}
			}
			throw new Error("This shouldn't happen! The function is badly implemented!")
		}
		
		static public function getArrayFromStringVector(vector:Vector.<String>):Array {
			var array:Array = new Array();
			for (var i:int = 0; i < vector.length; i++) {
				array.push(vector[i]);
			}
			return array;
		}
		
		
		static public function getArrayFromNumberVector(vector:Vector.<Number>):Array {
			var array:Array = new Array();
			for (var i:int = 0; i < vector.length; i++) {
				array.push(vector[i]);
			}
			return array;
		}
		
		
		/**
		 * @param aArray an array of any type
		 * @param	aFrequencies an array of frequencies (Numbers), whose sum is 1.0, e.g. {0.3, 0.2, 0.5}
		 * @return the element of aArray with index equal to gmGetRandomIntFromFrequencies(aFrequencies)
		 * @see gmGetRandomIntFromFrequencies()
		 * @throws ArgumentError if the lengths of aArray and aFrequencies are not equal.
		 */
		static public function getRandomArrayElementFromFrequencies(aArray:Array,
			aFrequencies:Array):* {
			if (aArray.length != aFrequencies.length) {
				throw new ArgumentError("The lengths of aArray and aFrequencies must be equal.")
			}
			var vIndex:int = getRandomIntFromFrequencies(aFrequencies)
			return aArray[vIndex]
		}

		static public function removeArrayItem(array:Array, item:Object):void 
		{			
			array.splice(array.indexOf(item), 1);
		}
		
		
		//------------------------------------------------------------------------------------------
		// VECTOR UTILITIES
		//------------------------------------------------------------------------------------------

		
		/**
		 * @return The angle between aVector1 and aVector2 in degrees.
		 * If aVector2 is null or not specified, the vector (0,1) (Y axis) is assumed.
		 */
		static public function getAngleBetweenVectors(aVector1:Point, aVector2:Point = null):int 
		{
			var vVector1:Point = aVector1.clone()
			vVector1.normalize(1.0)
			var vVector2:Point = aVector2 == null ? new Point(0,1) : aVector2.clone()			
			vVector2.normalize(1.0)
			
			var vAngle:int = Math.acos(Utils.dotProduct(vVector1, vVector2)) * 360 / (2 * Math.PI);
			
			if (vVector1.x > 0.0) {
				vAngle = -vAngle
			}
			return vAngle
		}

		/**		 
		 * @param	aVector Vector to rotate
		 * @param	aAngle Rotation angle in degrees
		 * @return
		 */
		static public function rotateVector(aVector:Point, aAngle:Number):Point {
			if (aAngle == 0) {
				return aVector.clone()
			} else {
				var vAngle:Number = degreesToRadians(aAngle)			
				var vX:Number = aVector.x * Math.cos(vAngle) + aVector.y * Math.sin(vAngle)
				var vY:Number = aVector.y * Math.cos(vAngle) - aVector.x * Math.sin(vAngle)
				return new Point(vX, vY)
			}
		}
		
		
		static public function getOppositeVector(aVector:Point):Point {
			return new Point(0, 0).subtract(aVector)
		}
		
		
		static public function multiplyVector(aVector:Point, aFactor:Number):Point {						
			var vResult:Point = aVector.clone()
			vResult.x *= aFactor
			vResult.y *= aFactor			
			return vResult
		}
		
		
		static public function degreesToRadians(aAngleDegrees:Number):Number {
			return aAngleDegrees / 360 * (2 * Math.PI)
		}
		
		
		static public function radiansToDegrees(aAngleRadians:Number):Number {
			return aAngleRadians * 360 / (2 * Math.PI)
		}
		
		
		static public function getPos(displayObject:DisplayObject):Point 
		{
			return new Point(displayObject.x, displayObject.y)
		}
		
		
		static public function contains(array:Array, item:Object):Boolean
		{
			return array.indexOf(item) != -1
		}
		
		
		static public function isAnyOf(object:Object, ...otherObjects):Boolean 
		{
			for (var i:int = 0; i < otherObjects.length; i++) {
				if (object == otherObjects[i]) {
					return true
				}
			}
			return false
		}
		
		/*
		static public function simpleSchedule(aScheduledFunction:Function, aTimeBetweenCallsInSecs:Number, aNumCalls:int = 1):void {
			var vTimeAlive:Number = aTimeBetweenCallsInSecs * 1000;
			var vTimer:Timer = new Timer(vTimeAlive, aNumCalls)
			vTimer.addEventListener(TimerEvent.TIMER, aScheduledFunction)
			vTimer.start();
		}
		*/
		
		
		static public function onAnimFinish(mc:MovieClip, callback:Function):void {
			mc.visible = true;
			mc.gotoAndPlay(1);
			mc.addFrameScript(mc.totalFrames - 1, onAnimFinishCallback)
			function onAnimFinishCallback():void {
				mc.stop();
				mc.visible = false;
				callback();
			}
		}
		
		
		static public function addPoints(point1:Point, point2:Point):Point 
		{
			return new Point(point1.x + point2.x, point1.y + point2.y);
		}
		
		
		static public function substractPoints(point1:Point, point2:Point):Point
		{
			return new Point(point1.x - point2.x, point1.y - point2.y);
		}
		
		
		static public function getDisplayObjectPos(displayObject:DisplayObject):Point
		{
			return new Point(displayObject.x, displayObject.y);
		}
		
		
		static public function getButtonTextField(button:SimpleButton):TextField
		{
			var upState:DisplayObjectContainer = button.upState as DisplayObjectContainer;
			return upState.getChildAt(1) as TextField;
		}
		
		
		static public function labelButton(button:SimpleButton, text:String):void 
		{			
			var upState:DisplayObjectContainer = button.upState as DisplayObjectContainer;
			var textField:TextField  = upState.getChildAt(1) as TextField;
			textField.text = text;
			upState = null;
			
			var overState:DisplayObjectContainer = button.overState as DisplayObjectContainer;
			textField = overState.getChildAt(1) as TextField;
			textField.text = text;
			overState = null;
			
			var downState:DisplayObjectContainer = button.downState as DisplayObjectContainer;
			textField = downState.getChildAt(1) as TextField;
			textField.text = text;
			downState = null;
			
			textField = null;
		}

		
		static public function getRandomPoint(screenWidth:Number, screenHeight:Number):Point 
		{
			return new Point(Utils.getRandomNumberBetween(0, screenWidth), Utils.getRandomNumberBetween(0, screenHeight));
		}
		
		
		static public function getDictionarySize(dictionary:Dictionary):int
		{
			var numObjects:int = 0;
			for each (var object:Object in dictionary) {
				numObjects++;
			}
			return numObjects;
		}
		
		
		static public function calculateProjectileTimeToReachY(currentY:Number, targetY:Number, acceleration:Number, speedY:Number):Number 
		{
			var deltaY:Number = targetY - currentY;
			
			//deltaY = vi*t + 1/2*a*t2
			//1/2*acc*t2 + vi*t - deltaY = 0			
			//ax2 + bx + c = 0
			
			var a:Number = acceleration / 2;
			var b:Number = speedY;
			var c:Number = -deltaY;
			var b2:Number = Math.pow(b, 2);
			
			//x = (-b +- sqrt(b2 - 4*a*c)) / 2*a			
			var x:Number = ( -b + Math.sqrt(b2 - 4 * a * c)) / (2 * a)									
			var time:Number = x;
			
			return time;
		}
		
		
		static public function calculateProjectileMinDeltaY(acceleration:Number, initialSpeed:Number):Number
		{
			//vf2 = vi2 + 2*a*d			
			//0 = vi2 + 2*a*d
			var vi:Number = initialSpeed;
			var a:Number = acceleration;			
			var vi2:Number = Math.pow(vi, 2);
			
			//2*a*d = -vi2
			//d = -vi2 / (2*a)
			
			var d:Number = -vi2 / (2 * a);
			return d;
		}
	}
}