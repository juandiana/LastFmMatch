package com.lfm.services.UserData {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import com.lfm.services.UserData.AbstractUserData;
	
	public class TopUserArtists extends AbstractUserData {

		
		public function TopUserArtists(user:String,type:String="overall") {
			super(user);
			_properties['type'] = type;
			_properties['artists'] = new Array();
			BASE_URL += "topartists.xml?type="+type;
		}
		
		
		override protected function parseData(event:Event):void {
			super.parseData(event);
			_properties['type'] = _svcXML.@type.toString();
			
			for each (var item:XML in _svcXML..artist) {
				var artist:Object = { 'name':item.name,
									  'mbid':item.mbid,
									  'rank':Number(item.rank),
									  'playcount':Number(item.playcount),
									  'url':item.url,
									  'thumbnail':item.thumbnail,
									  'image':item.image };
				_properties['artists'].push(artist);
			}
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function get type():String {
			return _properties['type'];
		}
		
		public function get artists():Array {
			return _properties['artists'];
		}
		
	}
	
}