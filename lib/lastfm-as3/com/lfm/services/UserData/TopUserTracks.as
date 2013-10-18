package com.lfm.services.UserData {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import com.lfm.services.UserData.AbstractUserData;
	
	public class TopUserTracks extends AbstractUserData {

		public function TopUserTracks(user:String,type:String="overall") {
			super(user);
			
			_properties['tracks'] = new Array();
			_properties['type'] = type;
			BASE_URL += "toptracks.xml?type="+type;
		}
		
		
		override protected function parseData(evt:Event):void {
			super.parseData(evt);
			_properties['type'] = _svcXML.@type.toString();
			
			for each (var item:XML in _svcXML..track) {
				var track:Object = { 'artist':{name:item.artist,mbid:item.artist.@mbid},
									  'name':item.name,
									  'mbid':item.mbid,
									  'playcount':Number(item.playcount),
									  'rank':Number(item.rank),
									  'url':item.url };
				_properties['tracks'].push(track);
			}
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function get type():String {
			return _properties['type'];
		}
		
		public function get tracks():Array {
			return _properties['tracks'];
		}
		
	}
	
}