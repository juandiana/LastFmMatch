package com.lfm.services.TrackData
{
	import flash.events.Event;
	
	public class SimilarTracks extends AbstractTrackData
	{
		public function SimilarTracks(artist:String, track:String)
		{
			super(artist, track);
			_properties['tracks'] = new Array();
			BASE_URL += "similar.xml";
		}
		override protected function parseData(event:Event):void {
			super.parseData(event);
			for each (var item:XML in _svcXML..track) {
				var track:Object = { 'name':item.name,
									  'match':Number(item.match),
									  'streamable':item.streamable.toString() == "1" ? true : false,
									  'url':item.url,
									  'artist':
									   {
									  	name : item.artist.name,
									  	url : item.artist.url
									   }
									  };
				_properties['tracks'].push(track);
			}
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		public function get tracks():Array {
			return _properties['tracks'];
		}
		
	}
}