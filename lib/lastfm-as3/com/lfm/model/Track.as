package com.lfm.model {
	
	public class Track {
		
		private var _artist:String = "";
		private var _title:String = "";
		private var _timestamp:uint = Math.floor((new Date()).time/1000);
		private var _source:String = "U";
		private var _rating:String = "";
		private var _album:String = "";
		private var _length:uint = 0;
		private var _tracknum:uint = 0;
		private var _mbid:String = "";
		
		public static const SOURCE_USER:String = "P";
		public static const SOURCE_BROADCAST:String = "R";
		public static const SOURCE_RECOMMENDATION:String = "E";
		public static const SOURCE_LASTFM:String = "L";
		public static const SOURCE_UNKNOWN:String = "U";
		
		public static const RATING_LOVE:String = "L";
		public static const RATING_BAN:String = "B";
		public static const RATING_SKIP:String = "S";
		
		
		function Track() { }
		
		public static function dateToTimestamp(d:Date):uint {
			return Math.floor(d.getTime()/1000);
		}
		
		
		public function set artist(a:String):void {
			_artist = a;
		}
		public function set title(t:String):void {
			_title = t;
		}
		public function set timestamp(t:uint):void {
			_timestamp = t;
		}
		public function set source(s:String):void {
			if(s != SOURCE_USER && s != SOURCE_BROADCAST && s != SOURCE_RECOMMENDATION && s != SOURCE_LASTFM && s != SOURCE_UNKNOWN)
				_source = SOURCE_UNKNOWN;
			else
				_source = s;
		}
		public function set rating(r:String):void {
			if(r != RATING_LOVE && r != RATING_BAN && r != RATING_SKIP)
				_rating = "";
			else
				_rating = r;
		}
		public function set album(a:String):void {
			_album = a;
		}
		public function set length(l:uint):void {
			_length = l;
		}
		public function set tracknum(n:uint):void {
			_tracknum = n;
		}
		public function set mbid(m:String):void {
			_mbid = m;
		}
		
		
		public function get artist():String {
			return _artist;
		}
		public function get title():String {
			return _title;
		}
		public function get timestamp():uint {
			return _timestamp;
		}
		public function get source():String {
			return _source;
		}
		public function get rating():String {
			return _rating;
		}
		public function get album():String {
			return _album;
		}
		public function get length():uint {
			return _length;
		}
		public function get tracknum():uint {
			return _tracknum;
		}
		public function get mbid():String {
			return _mbid;
		}
		
		
		
	}
	
	
	
}