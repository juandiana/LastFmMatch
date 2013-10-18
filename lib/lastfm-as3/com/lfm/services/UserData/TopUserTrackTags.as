package com.lfm.services.UserData {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import com.lfm.services.UserData.AbstractUserData;
	
	public class TopUserTrackTags extends AbstractUserData {

		
		public function TopUserTrackTags(user:String,artist:String,track:String) {
			super(user);
			_properties['artist'] = artist;
			_properties['track'] = track;
			_properties['tags'] = new Array();
			BASE_URL += "tracktags.xml?artist="+artist+"&track="+track;
		}
		
		
		override protected function parseData(event:Event):void {
			super.parseData(event);
			_properties['track'] = _svcXML.@track.toString();
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
		
		public function get track():String {
			return _properties['track'];
		}
		
		public function get tags():Array {
			return _properties['tags'];
		}
		
	}
	
}