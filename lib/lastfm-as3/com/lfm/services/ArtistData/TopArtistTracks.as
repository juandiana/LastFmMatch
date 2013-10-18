package com.lfm.services.ArtistData
{
	import flash.events.Event;
	
	public class TopArtistTracks extends AbstractArtistData
	{
		public function TopArtistTracks(artist:String)
		{
			super(artist);
			_properties['tracks'] = new Array();
			BASE_URL += "toptracks.xml";
		}
		override protected function parseData(event:Event):void {
			super.parseData(event);
			for each (var item:XML in _svcXML..track) {
				
				var track:Object = { 'name':item.name,
									'reach':Number(item.reach),
									'mbid':item.mbid,
									'url':item.url };
				_properties['tracks'].push(track);
			}
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function get tracks():Array {
			return _properties['tracks'];
		}	

	}
}