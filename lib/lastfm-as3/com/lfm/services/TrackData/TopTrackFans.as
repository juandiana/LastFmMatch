package com.lfm.services.TrackData
{
	import flash.events.Event;
	
	public class TopTrackFans extends AbstractTrackData
	{
		public function TopTrackFans(artist:String, track:String)
		{
			super(artist, track);
			_properties['fans'] = new Array();
			BASE_URL += "fans.xml";
		}
		override protected function parseData(event:Event):void {
			super.parseData(event);
			for each (var item:XML in _svcXML..user) {
				
				var user:Object = { 'name':item.@username,
									'weight':Number(item.weight),
									'url':item.url,
									'image':item.image };
				_properties['fans'].push(user);
			}
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function get fans():Array {
			return _properties['fans'];
		}
	}
}