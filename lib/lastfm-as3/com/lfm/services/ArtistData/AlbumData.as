package com.lfm.services.ArtistData
{
	import flash.events.Event;
	
	public class AlbumData extends AbstractArtistData
	{
		public function AlbumData(artist:String, album:String)
		{
			super("");
			_properties['artist'] = artist;
			_properties['album'] = album;
			_properties['tracks'] = new Array();
			BASE_URL += "album/" + artist + "/" + album + "/info.xml";
			
		}
		override protected function parseData(event:Event):void {
			super.parseData(event);
			_properties['album'] = _svcXML.@title.toString()
			_properties['reach'] = Number(_svcXML.reach);
			_properties['url'] = _svcXML.url.toString()
			_properties['releasedate'] = _svcXML.releasedate.toString();
			_properties['image_small'] = _svcXML.coverart.small.toString();
			_properties['image_medium'] = _svcXML.coverart.medium.toString();
			_properties['image_large'] = _svcXML.coverart.large.toString();
			_properties['mbid'] = _svcXML.mbid.toString();
			
			for each (var item:XML in _svcXML..track) {
				var track:Object = { 'name':item.@title,
				  					  'reach':Number(item.reach),
									  'url':item.url};
				_properties['tracks'].push(track);
			}
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		public function get album():String{
			return _properties['album'];
		}
		public function get reach():Number{
			return _properties['reach'];
		}
		public function get url():String{
			return _properties['url'];
		}
		public function get releasedate():String{
			return _properties['releasedate'];
		}
		public function get image_small():String{
			return _properties['image_small'];
		}
		public function get image_medium():String{
			return _properties['image_medium'];
		}
		public function get image_large():String{
			return _properties['image_large'];
		}
		public function get mbid():String{
			return _properties['mbid'];
		}
		public function get tracks():Array{
			return _properties['tracks'];
		}
	}
}