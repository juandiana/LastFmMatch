package com.lfm.services.UserData {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import com.lfm.services.UserData.AbstractUserData;
	
	public class WeeklyChartList extends AbstractUserData {

		
		public function WeeklyChartList(user:String) {
			super(user);
			_properties['charts'] = new Array();
			BASE_URL += "weeklychartlist.xml";
		}
		
		
		override protected function parseData(event:Event):void {
			super.parseData(event);
			for each (var item:XML in _svcXML..chart) {
				var chart:Object = {'from':Number(item.@from),
									'to':Number(item.@to) };
				_properties['charts'].push(chart);
				
			}
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function get charts():Array {
			return _properties['charts'];
		}
		
	}
	
}