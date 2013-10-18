package com.lfm.services.UserData {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import com.lfm.services.UserData.AbstractUserData;
	
	public class TopUserArtistTags extends AbstractUserData {

		
		public function TopUserArtistTags(user:String,artist:String="") {
			super(user);
			_properties['artist'] = artist;
			_properties['tags'] = new Array();
			BASE_URL += "artisttags.xml?artist="+artist;
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
		
		public function get artist():String {
			return _properties['artist'];
		}
		
		public function get tags():Array {
			return _properties['tags'];
		}
		
	}
	
}