package com.lfm.services.UserData {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import com.lfm.services.UserData.AbstractUserData;
	
	public class WeeklyAlbumsChart extends AbstractUserData {
		
		
		public function WeeklyAlbumsChart(user:String,from:Number=0,to:Number=0) {
			super(user);
			var qstring:String = "";
			_properties['from'] = from;
			_properties['to'] = to;
			_properties['albums'] = new Array();
			if(from > 0 && to > 0)
				qstring = "?from="+from+"&to="+to;
			BASE_URL += "weeklyalbumchart.xml"+qstring;
		}
		
		
		override protected function parseData(event:Event):void {
			
			super.parseData(event);
			_properties['from'] = Number(_svcXML.@from);
			_properties['to'] = Number(_svcXML.@to);
			for each (var item:XML in _svcXML..album) {
				var album:Object = { 'artist':{mbid:item.artist.@mbid, name: item.artist},
									 'name':item.name,
									 'mbid':item.mbid,
									 'chartposition':Number(item.chartposition),
									 'playcount':Number(item.playcount),
									 'url':item.url };
				_properties['albums'].push(album);
				
			}
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function get albums():Array {
			return _properties['albums'];
		}
		
	}
	
}