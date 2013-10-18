package com.lfm.services.ArtistData
{
	import flash.events.Event;
	
	public class TopArtistAlbums extends AbstractArtistData
	{
		public function TopArtistAlbums(artist:String)
		{
			super(artist);
			_properties['albums'] = new Array();
			BASE_URL += "topalbums.xml";
		}
		override protected function parseData(event:Event):void {
			super.parseData(event);
			for each (var item:XML in _svcXML..album) {
				
				var album:Object = {'name':item.name,
									'mbid':item.mbid,
									'reach':Number(item.reach),
									'image_small':item.image.small,
									'image_medium':item.image.medium,
									'image_large':item.image.large,
									'url':item.url };
				_properties['albums'].push(album);
			}
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function get albums():Array {
			return _properties['albums'];
		}	
	}
}