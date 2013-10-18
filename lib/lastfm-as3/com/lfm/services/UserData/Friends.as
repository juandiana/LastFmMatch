package com.lfm.services.UserData {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import com.lfm.services.UserData.AbstractUserData;
	
	public class Friends extends AbstractUserData {
		
		
		public function Friends(user:String) {
			super(user);
			_properties['friends'] = new Array();
			BASE_URL += "friends.xml";
		}
		
		override protected function parseData(event:Event):void {
			super.parseData(event);
			for each (var item:XML in _svcXML..user) {
				var user:Object = { 'name':item.@username,
								    'image':item.image,
								    'url':item.url };
				_properties['friends'].push(user);
			}
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function get friends():Array {
			return _properties['friends'];
		}
		
	}
	
}