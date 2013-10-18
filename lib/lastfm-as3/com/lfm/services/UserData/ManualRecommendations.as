package com.lfm.services.UserData {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import com.lfm.services.UserData.AbstractUserData;
	
	public class ManualRecommendations extends AbstractUserData {
		
		public function ManualRecommendations(user:String) {
			super(user);
			BASE_URL += "manualrecs.rss";
			_properties['recommendations'] = new Array();
		}
		
		override protected function parseData(event:Event):void {
			
			super.parseData(event);
			
			_properties['description'] = _svcXML.channel.title;
			_properties['link'] = _svcXML.channel.link;
			for each (var item:XML in _svcXML..item) {
				
				var rec:Object = {'name':item.title,
								  'url':item.link,
								  'description':item.description }
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