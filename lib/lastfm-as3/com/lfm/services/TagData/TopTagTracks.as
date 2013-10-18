package com.lfm.services.TagData
{
	import flash.events.Event;
	
	public class TopTagTracks extends AbstractTagData
	{
		public function TopTagTracks(tag:String="")
		{
			super(tag);
			_properties['tracks'] = new Array();
			BASE_URL += tag + "/toptracks.xml";
		}
		
		override protected function parseData(evt:Event):void {
			super.parseData(evt);
			_properties['count'] = Number(_svcXML.@count.toString());
			
			for each (var item:XML in _svcXML..track) {
				var track:Object = { 'artist':
										{
											name:item.artist.@name,
											mbid:item.artist.mbid,
											url:item.artist.url
										},
									  'name':item.@name,
									  'count':Number(item.@count),
									  'streamable':item.@streamable.toString() == "yes" ? true : false,
									  'image':item.image,
									  'thumbnail':item.thumbnail,
									  'url':item.url};
				_properties['tracks'].push(track);
			}
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function get count():int {
			return _properties['count'];
		}
		
		public function get tracks():Array {
			return _properties['tracks'];
		}
	}
}