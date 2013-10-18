package  
{
	/**
	 * ...
	 * @author 
	 */
	public class TagColors 
	{		
		private static var _instance:TagColors;
		private var colorsAndTags:Vector.<ColorAndTags>;
		
		static public function get instance():TagColors 
		{
			if (_instance == null) {
				_instance = new TagColors();
			}
			return _instance;
		}
		
		
		public function TagColors() 
		{			
			colorsAndTags = new Vector.<ColorAndTags>();
			colorsAndTags.push(new ColorAndTags(new Color(255, 102, 102), 
			new < String > ["rock", "Alternative rock", "Art rock‎", "Blues rock‎", "Celtic rock", "Christian rock‎", "Comedy rock‎", "Country rock", "Dance-rock", "Deathrock",
			"Electronic rock‎", "Folk rock", "Funk rock‎", "Garage rock‎", "Glam rock", "Hard rock‎", "Krautrock‎", "Pop rock‎", "Progressive rock‎", "Psychedelic rock", "Psychobilly‎",
			"Rap rock‎", "Reggae rock‎", "Rock and roll", "Rock en Español‎", "Rock in Opposition‎", "Rockabilly‎", "Soft rock‎", "Space rock‎", "Swamp rock", "Symphonic rock", "Synth rock",
			"Viking rock‎", "Grunge", "Indie Rock", "Classic rock", "Christian rock", "Alternative", "Progressive rock", "Blues rock", "Post-rock", "rock uruguayo"]));
			
			colorsAndTags.push(new ColorAndTags(new Color(255, 153, 102),
			new < String > ["pop", "popular", "britpop", "dangdut", "dance-pop‎", "c-pop‎", "country pop‎", "bubblegum pop", "power pop‎", "shibuya-kei", "sophisti-pop", "surf music", "swamp pop music", "synthpop‎", "indie pop", "Indie", "singer-songwriter", "Shoegazing", "dream pop"]));
			
			colorsAndTags.push(new ColorAndTags(new Color(255, 204, 102), 
			new < String > ["Jazz", "Bossa Nova", "Bebop", "Bop", "Chamber Jazz", "Cool Jazz", "Dixieland‎"]));
			
			colorsAndTags.push(new ColorAndTags(new Color(255, 255, 102), 
			new < String > ["Hip-Hop", "Rap", "G-funk‎", "Gangsta rap‎", "Hip Hop", "hiphop"]));
			
			colorsAndTags.push(new ColorAndTags(new Color(204, 255, 102), 
			new < String > ["Folk", "Country", "Western", "Folclore", "Alternative Country", "Country Rock", "Country Pop", "Country Rap", "Cowpunk", "Outlaw", "Rockabilly"]));
			
			colorsAndTags.push(new ColorAndTags(new Color(153, 255, 102), 
			new < String > ["Latin", "Cumbia", "Cumbia Rap", "Cumbia Villera", "Tecnocumbia", "MPB", "Reggaeton", "Samba", "Pagode"]));
			
			colorsAndTags.push(new ColorAndTags(new Color(102, 255, 102), 
			new < String > ["Reggae", "Rocksteady", "Ska", "Dancehall‎", "Dub", "Raggamuffin"]));
			
			colorsAndTags.push(new ColorAndTags(new Color(102, 255, 204), 
			new < String > ["Blues", "R&B", "Rhythm and Blues"]));
			
			colorsAndTags.push(new ColorAndTags(new Color(102, 255, 255), 
			new < String > ["Electronic", "House", "Ambient", "Acid House", "Dance", "Breakbeat", "Downtempo", "Boogie", "Crunk", "Grime", "Electroclash", "Funktronica", "Synthpop‎", "Trip Hop", "Noise Music", "Industrial Music", "Club House", "Electro Tango", "Lounge", "Trip-hop", "Chillout", "dubstep"]));
			
			colorsAndTags.push(new ColorAndTags(new Color(102, 153, 255), 
			new < String > ["Punk", "Anarcho-punk‎", "Celtic punk‎", "Christian punk", "Cowpunk‎", "Dance-punk‎", "Deathrock‎", "Deutschpunk", "Folk punk‎", "Garage punk‎", "Gypsy punk‎", "Hardcore punk‎", "Horror punk‎", "Mod revival‎", "New wave music‎", "Oi!‎", "Pop punk‎", "Post-hardcore", "Post-punk", "Psychobilly‎", "Punk blues‎", "Punk rock", "Queercore‎", "Riot grrrl‎", "Skate punk‎", "Street punk‎", "Taqwacore", "Pop punk", "Punk pop", "Emo", "Screamo", "Hardcore"]));
			
			colorsAndTags.push(new ColorAndTags(new Color(102, 102, 255), 
			new < String > ["Heavy Metal", "Nu Metal", "Alternative Metal‎", "Black Metal‎", "Blackened death Metal‎", "Christian Metal‎", "Death Metal‎", "Doom Metal‎", "Extreme Metal‎", "Metalcore‎", "Industrial Metal", "Funk Metal", "Glam Metal‎", "Gothic Metal‎", "Grindcore‎", "Groove Metal‎", "Thrash Metal‎", "Progressive Metal‎", "Power Metal", "gothic", "metal", "industrial", "metalcore"]));
			
			colorsAndTags.push(new ColorAndTags(new Color(153, 102, 255), 
			new < String > ["Techno", "4-beat", "Acid techno", "Amigacore", "Birmingham sound", "Detroit techno", "Dub techno", "Freetekno", "Ghettotech", "Hard trance", "Hardtechno", "Microhouse", "Minimal techno", "Nortec", "Power noise", "Rotterdam techno", "Schranz", "Symphonic techno", "Tech house", "Tech trance", "Tecno brega"]));
			
			colorsAndTags.push(new ColorAndTags(new Color(204, 102, 255), 
			new < String > ["Trance", "Acid trance", "Dark trance", "Dream trance", "Euro-trance", "Hard trance", "Hardstyle", "Lento Violento", "List of progressive house artists", "List of vocal trance artists", "Progressive house", "Psychedelic trance", "Rebolation", "Suntrip Records", "Tech trance", "Uplifting trance", "Vocal trance"]));
			
			colorsAndTags.push(new ColorAndTags(new Color(255, 102, 255), 
			new < String > ["Dance", "Acid Jazz", "Dance-pop", "Dance-rock", "Dance-punk", "Disco", "Funk", "Soul"]));
			
			colorsAndTags.push(new ColorAndTags(new Color(255, 102, 204), 
			new < String > ["Classical", "Flamenco"]));
			
		}
		
		
		public function getColor(tag:String):Color
		{
			for (var i:int = 0; i < colorsAndTags.length; i++) {
				var colorAndTags:ColorAndTags = colorsAndTags[i];				
				if (colorAndTags.containsTag(tag)) {
					return colorAndTags.getColor();
				}				
			}
					
			//If the tag is not in the list, then the color is gray.
			return new Color(150,150,150);
		}
	}

}