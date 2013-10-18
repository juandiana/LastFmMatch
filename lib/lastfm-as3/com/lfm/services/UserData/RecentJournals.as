package com.lfm.services.UserData {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import com.lfm.services.UserData.AbstractUserData;
	
	public class RecentJournals extends AbstractUserData {
		
		public function RecentJournals(user:String) {
			super(user);
			BASE_URL += "journals.rss";
			_properties['journals'] = new Array();
		}
		
		override protected function parseData(event:Event):void {
			
			super.parseData(event);
			
			_properties['description'] = _svcXML.channel.description;
			_properties['location'] = _svcXML.channel.link;
			for each (var item:XML in _svcXML..item) {
				var pubDate:Date = new Date();
				pubDate.setTime(Date.parse(item.pubDate));
				var journal:Object = {'title':item.title,
									  'link':item.link,
									  'pubDate':pubDate,
									  'content':item.description }
				_properties['journals'].push(journal);
				
			}

			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function get username():String {
			return _properties['username'];
		}
		
		public function get journals():Array {
			return _properties['journals'];
		}
		
		public function get location():String {
			return _properties['location'];
		}
		
		public function get description():String {
			return _properties['description'];
		}
		
	}
	
}