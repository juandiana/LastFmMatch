package com.lfm.services.UserData {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import com.lfm.services.UserData.AbstractUserData;
	
	public class SystemRecommendations extends AbstractUserData {
		
		public function SystemRecommendations(user:String) {
			super(user);
			BASE_URL += "systemrecs.xml";
			_properties['recommendations'] = new Array();
		}
		
		override protected function parseData(event:Event):void {
			
			super.parseData(event);

			for each (var item:XML in _svcXML..artist) {
				
				var rec:Object = {'name':item.name,
								  'mbid':item.mbid,
								  'url':item.url }
				_properties['recommendations'].push(rec);
				
			}

			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function get recommendations():Array {
			return _properties['recommendations'];
		}
		
		public function get link():String {
			return _properties['link'];
		}
		
		public function get description():String {
			return _properties['description'];
		}
		
	}
	
}