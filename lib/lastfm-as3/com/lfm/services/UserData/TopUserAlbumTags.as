package com.lfm.services.UserData {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import com.lfm.services.UserData.AbstractUserData;
	
	public class TopUserAlbumTags extends AbstractUserData {
		
		
		public function TopUserAlbumTags(user:String,artist:String="",album:String="") {
			super(user);
			_properties['artist'] = artist;
			_properties['album'] = album;
			_properties['tags'] = new Array();
			BASE_URL += "albumtags.xml?artist="+artist+"&album="+album;
		}
		
		
		override protected function parseData(event:Event):void {
			
			super.parseData(event);
			_properties['album'] = _svcXML.@album.toString();
			_properties['artist'] = _svcXML.@artist.toString();
			
			for each (var item:XML in _svcXML..tag) {
				var tag:Object = { 'name':item.name,
								   'count':Number(item.count),
								   'url':item.url };
				_properties['tags'].push(tag);
			}
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function get artist():String {
			return _properties['artist'];
		}
		
		public function get album():String {
			return _properties['album'];
		}
		
		public function get tags():Array {
			return _properties['tags'];
		}
		
	}
	
}