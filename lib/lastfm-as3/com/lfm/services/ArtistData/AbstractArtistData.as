package com.lfm.services.ArtistData
{
	import com.lfm.services.AbstractService;
	
	import flash.events.Event;

	public class AbstractArtistData extends AbstractService
	{
		public function AbstractArtistData(artist:String)
		{
			super();
			if(artist == "") return; //override for album, track data
			_properties['artist'] = artist;
			BASE_URL += "artist/" + artist + "/";
		}
		override protected function parseData(evt:Event):void {
			super.parseData(evt);
			_properties['artist'] = _svcXML.@artist.toString();
		}
		public function get artist():String{
			return _properties['artist'];
		}
	}
}