package com.lfm.services.ArtistData {
	import com.lfm.services.AbstractEventsData;
	
	public class ArtistEvents extends AbstractEventsData {
		
		public function ArtistEvents(artist:String) {
			super();
			_properties['artist'] = artist;
			BASE_URL += "artist/" + artist + "/events.rss";
		}
		
	}
	
}