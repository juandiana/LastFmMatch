package com.lfm.services {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class AbstractEventsData extends AbstractService {
		
		public function AbstractEventsData() {
			super();
			_properties['events'] = new Array();
		}
		
		override protected function parseData(event:Event):void {
			_svcXML = new XML(event.target.data);
			
			//Setup namespace to parse X-Cal dates
			var ns:Namespace = new Namespace("urn:ietf:params:xml:ns:xcal");
			_svcXML.addNamespace(ns);
			
			_properties['description'] = _svcXML.channel.description;
			_properties['location'] = _svcXML.channel.link;
			for each (var item:XML in _svcXML..item) {
				var calEvent:Object = new Object();
				
				calEvent.name = item.title.toString();
				calEvent.description = item.description.toString();
				calEvent.link = item.link.toString();
				calEvent.venueLink = item.ns::location.toString();
				
				// Look for venue address
				var pattern:RegExp = new RegExp("Location: (.*)", "i");
				calEvent.address = pattern.exec(item.description)[1];
				
				// Parse start date into a date object
				pattern = new RegExp("([0-9]{4})\-([0-9]{2})\-([0-9]{2})T([0-9]{2}):([0-9]{2}):([0-9]{2})Z", "i");
				
				var dtParse:Array = pattern.exec(item.ns::dtstart);
				var dtstart:Date = new Date();
				dtstart.setTime(Date.parse(dtParse[1]+"/"+dtParse[2]+"/"+dtParse[3]+" "+dtParse[4]+":"+dtParse[5]+":"+dtParse[6]+" UTC"));
				calEvent.start = dtstart;
				
				// Parse end date into a date object
				var dtend:Date = new Date();
				dtParse = pattern.exec(item.ns::dtend);
				dtend.setTime(Date.parse(dtParse[1]+"/"+dtParse[2]+"/"+dtParse[3]+" "+dtParse[4]+":"+dtParse[5]+":"+dtParse[6]+" UTC"));
				calEvent.end = dtend;
				
				pattern = new RegExp("(.*) at (.*) on","i");
				var infoBreakdown:Array = pattern.exec(calEvent.name);
				if(infoBreakdown) {
					var artists:Array = infoBreakdown[1].split(" + ");
					calEvent.artists = artists;
					calEvent.venue = infoBreakdown[2];
				} else {
					pattern = new RegExp("(.*) on","i");
					calEvent.artists = [pattern.exec(calEvent.name)[1]];
					calEvent.venue = calEvent.address;
				}
				_properties['events'].push(calEvent);
				
			}

			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function get username():String {
			return _properties['username'];
		}
		
		public function get events():Array {
			return _properties['events'];
		}
		
		public function get location():String {
			return _properties['location'];
		}
		
		public function get description():String {
			return _properties['description'];
		}
		
	}
	
}