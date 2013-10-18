package com.lfm.services.UserData {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import com.lfm.services.UserData.AbstractUserData;
	
	public class RecentBannedTracks extends AbstractUserData {
		

		public function RecentBannedTracks(user:String) {
			super(user);
			_properties['tracks'] = new Array();
			BASE_URL += "recentbannedtracks.xml";
		}
		
		
		override protected function parseData(event:Event):void {
			super.parseData(event);
			for each (var item:XML in _svcXML..track) {
				var track:Object = {'artist':{name:item.artist, mbid:item.artist.@mbid},
									'name':item.name,
								    'mbid':item.mbid,
								    'url':item.url,
									'date':new Date(Number(item.date.@uts)*1000) };
				_properties['tracks'].push(track);
			}

			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function get username():String {
			return _properties['username'];
		}
		
		public function get tracks():Array {
			return _properties['tracks'];
		}
		
	}
	
}