package com.lfm.services.TrackData
{
	import com.lfm.services.AbstractService;
	
	import flash.events.Event;

	public class AbstractTrackData extends AbstractService
	{
		public function AbstractTrackData(artist:String, track:String)
		{
			super();
			_properties['artist'] = artist;
			_properties['track'] = track;
			BASE_URL += "track/" + artist + "/" + track + "/";
		}
		override protected function parseData(evt:Event):void {
			super.parseData(evt);
		}
		public function get artist():String{
			return _properties['artist'];
		}
		public function get track():String{
			return _properties['track'];
		}
	}
}