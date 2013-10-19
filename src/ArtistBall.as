package  
{
	import com.lfm.services.ArtistData.TopArtistTags;
	import flash.display.ColorCorrection;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Santiago Rosas
	 */
	public class ArtistBall extends Manager
	{		
		private static const MIN_VELOCITY:Number = 0;
		private static const MAX_VELOCITY:Number = 0;
		
		public static const MIN_DIAMETER:Number = 50;		
		public static const MAX_DIAMETER:Number = 150;
		private static const SAME_USER_ZERO_ATTRACTION_DISTANCE:Number = 600;
		private static const SAME_NAME_ZERO_ATTRACTION_DISTANCE:Number = 50;
		private static const SAME_TAG_ZERO_ATTRACTION_DISTANCE:Number = 400;
			
		private var mc:MovieClip;
		private var mover:MoverComponent;
		private var scaler:LinearMoverComponent;
		private var diameter:Number;
		private var isMouseDown:Boolean;
		private var screen:VisualizationScreen;
		private var topTagsLoader:TopArtistTags;
		private var topTags:Vector.<String>;
		private var color:Color;
		private var playcount:int;
		
		public function ArtistBall(name:String, playcount:int, diameter:Number, screen:VisualizationScreen, isRing:Boolean)
		{
			this.diameter = diameter;
			this.screen = screen;
			this.playcount = playcount;
			
			if (isRing) {
				mc = new m_ArtistRing();
			}
			else {
				mc = new m_ArtistBall();
			}
			Main.instance.layer1.addChild(mc);				
			
			var pos:Point = getNewSpawnPos();
			var speed:Point = Utils.substractPoints(Main.instance.getCenterOfScreen(), pos);
			speed.normalize(Utils.getRandomNumberBetween(MIN_VELOCITY, MAX_VELOCITY));
			
			mover = (MoverComponent)(mAddComponent(new MoverComponent(mc, pos, speed)));
			scaler = (LinearMoverComponent)(mAddComponent(new LinearMoverComponent(new Point(0, 0), new Point(100, 0))));						
			
			mc.nameText.text = name;						
			
			mc.width = 0;
			mc.height = 0;			
			
			mc.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			Main.instance.stage.addEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
			Main.instance.stage.addEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
									
			mc.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			mc.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);	
			
			topTagsLoader = new TopArtistTags(name);			
			topTagsLoader.load();
			topTagsLoader.addEventListener(Event.COMPLETE, onTagsLoaded);
			mc.tagText.visible = false;
		}

		
		private function onTagsLoaded(e:Event):void
		{
			topTags = new Vector.<String>();
			
			for (var i:int = 0; i < 3; i++) {
				topTags.push(topTagsLoader.tags[i]["name"]);
			}
			
			color = TagColors.instance.getColor(topTags[0]);
			
			mc.background.transform.colorTransform = new ColorTransform(1, 1, 1, 1, color.r, color.g, color.b);
		}
		
		
		public function areTopTagsLoaded():Boolean
		{
			return topTagsLoader.tags.length > 0;
		}
		
		
		private function onStageMouseMove(e:MouseEvent):void 
		{
			if (isMouseDown) {				
				mover.mSetX(e.stageX);
				mover.mSetY(e.stageY);				
			}
		}
		
		
		private function onStageMouseUp(e:MouseEvent):void 
		{
			isMouseDown = false;
		}
		
		
		private function onMouseDown(e:MouseEvent):void 
		{
			isMouseDown = true;
		}
		
		
		private function onMouseMove(e:MouseEvent):void 
		{
			var tooltip:m_Tooltip = Main.instance.getTooltip();
			tooltip.x = e.stageX;
			tooltip.y = e.stageY;
			tooltip.mouseEnabled = false;
			tooltip.mouseChildren = false;
			tooltip.visible = true;
			
			if (topTags != null) {
				tooltip.tagText1.text = topTags[0];
				tooltip.tagText2.text = topTags[1];
				tooltip.tagText3.text = topTags[2];
				tooltip.playsText.text = playcount + "";			
			}
			
			if (tooltip.y > 200) {
				tooltip.gotoAndStop("up");
			}
			else {
				tooltip.gotoAndStop("down");
			}
		}
		
		
		private function onMouseOut(e:MouseEvent):void 		
		{
			trace("MOUSE OUT");
			Main.instance.getTooltip().visible = false;
		}
		
		
		public function getPos():Point
		{
			return mover.mGetPos();
		}		
		
		
		public function getAttractionSpeed(otherBall:ArtistBall):Point
		{
			var speed:Point = Utils.substractPoints(otherBall.getPos(), getPos());
			var distance:Number = getDistance(otherBall);
			var velocity:Number = (getZeroAttractionDistance(otherBall) - distance) * mc.scaleX * mc.scaleX;
			
			speed.normalize(velocity);
			return speed;
		}
		
		
		private function getZeroAttractionDistance(otherBall:ArtistBall):Number
		{
			/*
			var tagsInCommon:Number = Main.itemsInCommon(topTags, otherBall.getTopTags());
			
			var distance:Number = 700 - tagsInCommon * 100;
			
			return distance;
			*/
			
			if (color == null || otherBall.getColor() == null) {
				return 400;
			}
			
			if (color.isEqual(otherBall.getColor())) {
				return 300;
			}
			else {
				return 400;
			}
		}
		
		
		public function getColor():Color
		{
			return color;
		}
		
		
		public function getRadius():Number
		{			
			return mc.width / 2;
		}
		
		
		public function getTopTags():Vector.<String>
		{
			return topTags;
		}
		

		private function getNewSpawnPos():Point
		{					
			return Utils.addPoints(screen.center,
				new Point(Utils.getRandomIntBetween( -100, 100), Utils.getRandomIntBetween( -100, 100)));		
		}
		
		
		private function getDistance(otherBall:ArtistBall):Number
		{
			return Point.distance(otherBall.getPos(), getPos())
		}
		
		
		override protected function mUpdate(aTime:Number):void 
		{
			mc.width = scaler.mGetX();
			mc.height = scaler.mGetX();
			
			if (scaler.mGetX() >= diameter) {
				scaler.mSetX(diameter);
				scaler.mStop();
			}			
						
			if (!isMouseDown) {
				mover.mSetSpeed(screen.getSpeedFromOtherBalls(this));	
			}
			
			updateTooltip();
			
			super.mUpdate(aTime);
		}
		
		
		private function updateTooltip():void 
		{
			
		}
		
		
		public function getArtistName():String
		{
			return mc.nameText.text;
		}
		
		
		public function overlaps(aBall:ArtistBall):Boolean
		{
			return getDistance(aBall) < aBall.getRadius() + getRadius();
		}
		
	}

}