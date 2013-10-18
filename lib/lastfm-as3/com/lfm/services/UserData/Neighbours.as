package com.lfm.services.UserData {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import com.lfm.services.UserData.AbstractUserData;
	
	public class Neighbours extends AbstractUserData {
		
		public function Neighbours(user:String) {
			super(user);
			_properties['neighbours'] = new Array();
			BASE_URL += "neighbours.xml";
		}
		
		override protected function parseData(event:Event):void {
			super.parseData(event);
			for each (var item:XML in _svcXML..user) {
				var user:Object = { 'name':item.@username,
								    'image':item.image,
								    'url':item.url,
									'match':Number(item.match) };
				_properties['neighbours'].push(user);
			}

			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function get neighbours():Array {
			return _properties['neighbours'];
		}
		
	}
	
}