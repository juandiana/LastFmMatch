package 
{
	import com.lfm.services.ArtistData.TopArtistTags;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.lfm.services.UserData.TopUserArtists;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.utils.getTimer;

	
	/**
	 * ...
	 * @author 
	 */
	public class Main extends Sprite 
	{
		public static const SCREEN_WIDTH:Number = 1024.0;
		public static const SCREEN_HEIGHT:Number = 768.0;
		
		public static var instance:Main;
		
		public var ballsLayer:MovieClip;
		public var particlesLayer:MovieClip;
		
		private var artistdata1:TopUserArtists;
		private var artistdata2:TopUserArtists;
		private var lastTime:Number;
		private var visualizationScreen1:VisualizationScreen;
		private var visualizationScreen2:VisualizationScreen;
		private var wasOneDataLoaded:Boolean = false;
		private var tooltip:m_Tooltip;
		private var divisionLine:m_divisionLine;
		
		public var layer1:MovieClip;
		public var layer2:MovieClip;
		
		public function Main():void 
		{
			instance = this;
			lastTime = getTimer();	
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			
		}
				
				
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);						
			
			layer1 = new MovieClip();
			layer2 = new MovieClip();
			addChild(layer1);
			addChild(layer2);
			
			new UsernameScreen();			
			
			tooltip = new m_Tooltip();
			tooltip.gotoAndStop("up");
			
			layer2.addChild(tooltip);			

		}
		
		
		private function onEnterFrame(e:Event):void
		{
			var currentTime:Number = getTimer();
			var timeSinceLastFrame:Number = (currentTime - lastTime) / 1000;
			lastTime = currentTime;
			if (timeSinceLastFrame.toString() == "NaN")
			{
				throw new Error("NaN");
			}
			
			if (visualizationScreen1 != null) {
				visualizationScreen1.mUpdateIfNotPaused(timeSinceLastFrame);
				visualizationScreen2.mUpdateIfNotPaused(timeSinceLastFrame);
			}
		}
		
		
		public function startVisualization(username1:String, username2:String):void 
		{						
									
			divisionLine = new m_divisionLine();
			divisionLine.gotoAndStop("join");
			layer2.addChild(divisionLine);
			divisionLine.x = SCREEN_WIDTH / 2;			
			divisionLine.y = 0;
			divisionLine.joinBtn.addEventListener(MouseEvent.CLICK, onJoinButtonClick);
			
			
			artistdata1 = new TopUserArtists(username1);
			artistdata1.addEventListener("complete",serviceLoaded);
			artistdata1.load();
			
			artistdata2 = new TopUserArtists(username2);
			artistdata2.addEventListener("complete",serviceLoaded);
			artistdata2.load();
			
			var screen1Center:Point = new Point(SCREEN_WIDTH / 9, SCREEN_HEIGHT / 2);
			visualizationScreen1 = new VisualizationScreen(screen1Center, true);
			
			var screen2Center:Point = new Point(SCREEN_WIDTH * (8 / 9), SCREEN_HEIGHT / 2);
			visualizationScreen2 = new VisualizationScreen(screen2Center, false);
			
			visualizationScreen1.setOtherScreen(visualizationScreen2);
			visualizationScreen2.setOtherScreen(visualizationScreen1);
		
			stage.focus = stage;
		}
		
		
		private function onJoinButtonClick(e:MouseEvent):void 
		{
			visualizationScreen1.setMix(true);
			visualizationScreen2.setMix(true);
			divisionLine.gotoAndStop("split");
			divisionLine.visible = false;
		}
		
		
		public function getCenterOfScreen():Point
		{
			return new Point(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
		}
		

		private function serviceLoaded(event:Event):void 
		{
			if (!wasOneDataLoaded) {
				wasOneDataLoaded = true;				
			}
			else {
				visualizationScreen1.initArtists(artistdata1.artists);
				visualizationScreen2.initArtists(artistdata2.artists);
			}

		}
		
		
		public function getTooltip():m_Tooltip
		{
			return tooltip;
		}
		
		
		public static function itemsInCommon(vector1:Vector.<String>, vector2:Vector.<String>):int
		{
			if (vector2 == null) {
				return 0;
			}
			
			var count:int = 0;
			for each (var item:* in vector1) {
				if (vector2.indexOf(item) != -1) {
					count++;
				}
			}
			
			return count;
		}
		
		
		
	}
	
}