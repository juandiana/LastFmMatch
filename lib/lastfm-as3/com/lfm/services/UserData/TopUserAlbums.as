package com.lfm.services.UserData {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import com.lfm.services.UserData.AbstractUserData;
	
	public class TopUserAlbums extends AbstractUserData {
		
		public function TopUserAlbums(user:String,type:String="overall") {
			super(user);
			_properties['type'] = type;
			_properties['albums'] = new Array();
			BASE_URL += "topalbums.xml?type="+type;
		}
		
		
		override protected function parseData(event:Event):void {
			
			super.parseData(event);
			_properties['type'] = _svcXML.@type.toString();
			for each (var item:XML in _svcXML..album) {
				var album:Object = { 'artist':{name:item.artist,mbid:item.artist.@mbid},
									  'name':item.name,
									  'mbid':item.mbid,
									  'playcount':Number(item.playcount),
									  'rank':Number(item.rank),
									  'url':item.url,
									  'image':{ large:item.image.large,
									  			medium:item.image.medium,
												small:item.image.small } };
				_properties['albums'].push(album);
			}
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function get type():String {
			return _properties['type'];
		}
		
		public function get albums():Array {
			return _properties['albums'];
		}
		
	}
	
}