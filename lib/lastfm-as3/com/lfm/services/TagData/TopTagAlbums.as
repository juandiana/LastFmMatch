package com.lfm.services.TagData
{
	import flash.events.Event;
	
	public class TopTagAlbums extends AbstractTagData
	{
		public function TopTagAlbums(tag:String="")
		{
			super(tag);
			_properties['albums'] = new Array();
			BASE_URL += tag + "/topalbums.xml";
		}
		override protected function parseData(event:Event):void {
			
			super.parseData(event);
			_properties['type'] = _svcXML.@type.toString();
			for each (var item:XML in _svcXML..album) {
				var album:Object = { 'artist':
										{
											name:item.artist.@name, 
											mbid:item.artist.mbid,
											url:item.artist.url
										},
									  'name':item.@name,
									  'streamable':item.@streamable.toString() == "yes" ? true : false,
									  'count':Number(item.@count),
									  'url':item.url,
									  'image':{ large:item.coverart.large,
									  			medium:item.coverart.medium,
												small:item.coverart.small } };
				_properties['albums'].push(album);
			}
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		public function get albums():Array {
			return _properties['albums'];
		}
	}
}