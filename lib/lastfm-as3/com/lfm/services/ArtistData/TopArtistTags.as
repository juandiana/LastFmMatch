package com.lfm.services.ArtistData
{
	import flash.events.Event;
	
	public class TopArtistTags extends AbstractArtistData
	{
		public function TopArtistTags(artist:String)
		{
			super(artist);
			_properties['tags'] = new Array();
			BASE_URL += "toptags.xml";
		}
		override protected function parseData(event:Event):void {
			super.parseData(event);
			for each (var item:XML in _svcXML..tag) {
				
				var tag:Object = { 'name':item.name,
									'count':Number(item.count),
									'url':item.url };
				_properties['tags'].push(tag);
			}
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function get tags():Array {
			return _properties['tags'];
		}	
		
	}
}