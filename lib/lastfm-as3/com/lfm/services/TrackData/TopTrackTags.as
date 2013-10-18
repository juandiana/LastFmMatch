package com.lfm.services.TrackData
{
	import flash.events.Event;
	
	public class TopTrackTags extends AbstractTrackData
	{
		public function TopTrackTags(artist:String, track:String)
		{
			super(artist, track);
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