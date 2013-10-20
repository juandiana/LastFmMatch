package  
{
	import com.lfm.services.ArtistData.TopArtistAlbums;
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Santiago Rosas
	 */
	public class VisualizationScreen extends Manager
	{		
		private static const NUM_ARTISTS:int = 20;
		static public const TIME_BETWEEN_BALLS:Number = 1;
		
		private var artists:Array;
		private var maxPlaycount:int;
		private var _center:Point;
		private var numArtistsWithoutBall:int = NUM_ARTISTS;
		private var otherScreen:VisualizationScreen;	
		private var hasRings:Boolean;
		private var mix:Boolean;
		private var everyoneIsBornGray:Boolean;
		
		public function VisualizationScreen(center:Point, hasRings:Boolean)
		{	
			Main.instance.layer1.addChild(new m_ScreenBackground);
			_center = center;	
			
			this.hasRings = hasRings;
		}
		
		
		public function initArtists(artists:Array):void
		{
			schedule(onCreateArtistBall, TIME_BETWEEN_BALLS, NUM_ARTISTS);
			this.artists = artists;			
			
			maxPlaycount = artists[0]["playcount"];
			
			trace(artists[0]["name"]);
			trace(artists[0]["tags"]);
		}
		
		
		public function getSpeedFromOtherBalls(aBall:ArtistBall):Point
		{
			var speed:Point = new Point(0, 0);
			
			for each (var ball:ArtistBall in mGetManageables()) {
				if (ball != aBall) {					
					speed = speed.add(ball.getAttractionSpeed(aBall));
				}				
			}
			if (mix) {
				for each (ball in otherScreen.mGetManageables()) {
					if (ball.areTopTagsLoaded() && ball != aBall) {					
						speed = speed.add(ball.getAttractionSpeed(aBall));
					}
				}	
			}
			
			if (speed.length > 200) {
				speed.normalize(200);
			}
							
			return speed;
		}
		
		
		public function getOverlappingBall(aBall:ArtistBall):ArtistBall 
		{
			for each (var ball:ArtistBall in mGetManageables()) {
				if (ball.overlaps(aBall)) {
					return ball;
				}
			}
			for each (ball in otherScreen.mGetManageables()) {
				if (ball.overlaps(aBall)) {
					return ball;
				}
			}
			return null;
		}
		
		
		public function getBallWithSameName(artistName:String):ArtistBall 
		{
			for each (var ball:ArtistBall in mGetManageables()) {
				if (ball.getArtistName() == artistName) {
					return ball;
				}
			}
			return null;
		}
		
		
		private function onCreateArtistBall(e:Event):void 
		{
			if (numArtistsWithoutBall > 0) {
				var randomNumber:int = Utils.getRandomIntBetween(0, numArtistsWithoutBall - 1);
				var artistName:String = artists[randomNumber]["name"];
				var artistPlaycount:int = artists[randomNumber]["playcount"];
							
				Utils.removeArrayItem(artists, artists[randomNumber]);			
								
				var diameter:Number = ArtistBall.MIN_DIAMETER + 
					(ArtistBall.MAX_DIAMETER - ArtistBall.MIN_DIAMETER) * artistPlaycount / maxPlaycount;
				
				var artistBall:ArtistBall = (ArtistBall)
					(mAddManageable(new ArtistBall(artistName, artistPlaycount, diameter, this, hasRings)));	
				
				if (everyoneIsBornGray) {
					artistBall.turnGray();
				}
					
				numArtistsWithoutBall--;
			}
		}
		
		
		public function get center():Point 
		{
			return _center;
		}
		
		
		public function setOtherScreen(otherScreen:VisualizationScreen):void
		{
			this.otherScreen = otherScreen;
		}
		
		
		public function setMix(mix:Boolean):void
		{
			this.mix = mix;
		}

		
		public function turnOtherBallsGray(except:ArtistBall):void 
		{
			for each (var ball:ArtistBall in mGetManageables()) {				
				if (ball != except) {
					ball.turnGray();
				}
			}
			for each (ball in otherScreen.mGetManageables()) {
				if (ball.getArtistName() != except.getArtistName()) {
					ball.turnGray();
				}
			}
			
			everyoneIsBornGray = true;
			otherScreen.setEveryoneIsBornGray(true);
		}
		
		
		public function returnOtherBallsToNormal(except:ArtistBall):void
		{			
			for each (var ball:ArtistBall in mGetManageables()) {				
				ball.returnToNormal();				
			}
			for each (ball in otherScreen.mGetManageables()) {
				ball.returnToNormal();
			}
			
			everyoneIsBornGray = false;
			otherScreen.setEveryoneIsBornGray(false);
		}
		
		
		private function setEveryoneIsBornGray(value:Boolean):void 
		{
			everyoneIsBornGray = value;
		}
	}

}