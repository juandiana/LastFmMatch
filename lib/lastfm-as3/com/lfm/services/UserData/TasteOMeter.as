package com.lfm.services.UserData {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import com.lfm.services.UserData.AbstractUserData;
	
	public class TasteOMeter extends AbstractUserData {
		
		
		public function TasteOMeter(user:String,compareUser:String) {
			super(user);
			_properties['score'] = 0;
			_properties['compareWith'] = compareUser;
			_properties['commonArtists'] = new Array();
			BASE_URL += "tasteometer.xml?with="+compareUser;
		}
		
		override protected function parseData(event:Event):void {
			super.parseData(event);
			_properties['score'] = _svcXML.score;
			for each (var item:XML in _svcXML..commonArtists.artist) {
				_properties['commonArtists'].push(item.name);
			}
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function get compareWith():String {
			return _properties['compareWith'];
		}
		
		public function get commonArtists():Array {
			return _properties['commonArtists'];
		}
		
		public function get score():Number {
			return _properties['score'];
		}
		
	}
	
}