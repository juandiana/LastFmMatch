package com.lfm.services.ArtistData
{
	import flash.events.Event;
	
	public class SimilarArtists extends AbstractArtistData
	{
		public function SimilarArtists(artist:String)
		{
			super(artist);
			_properties['artists'] = new Array();
			BASE_URL += "similar.xml";
		}
		override protected function parseData(event:Event):void {
			super.parseData(event);
			_properties['streamable'] = _svcXML.@streamable.toString() == "1" ? true : false;
			_properties['picture'] = _svcXML.@picture.toString();
			_properties['mbid'] = _svcXML.@mbid.toString();
			
			for each (var item:XML in _svcXML..artist) {
				var artist:Object = { 'name':item.name,
									  'mbid':item.mbid,
									  'match':Number(item.match),
									  'streamable':item.streamable.toString() == "1" ? true : false,
									  'url':item.url,
									  'image_small':item.image_small,
									  'image':item.image };
				_properties['artists'].push(artist);
			}
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function get artists():Array {
			return _properties['artists'];
		}
		
		public function get mbid():String {
			return _properties['mbid'];
		}
		
		public function get picture():String {
			return _properties['picture'];
		}
		
		public function get streamable():Boolean {
			return _properties['streamable'];
		}
		
		
	}
}