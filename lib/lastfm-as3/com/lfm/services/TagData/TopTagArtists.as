package com.lfm.services.TagData
{
	import flash.events.Event;
	
	public class TopTagArtists extends AbstractTagData
	{
		public function TopTagArtists(tag:String="")
		{
			super(tag);
			_properties['artists'] = new Array();
			BASE_URL += tag + "/topartists.xml";
		}
		override protected function parseData(event:Event):void {
			super.parseData(event);
			_properties['count'] = _svcXML.@count.toString();
			
			
			for each (var item:XML in _svcXML..artist) {
				var artist:Object = { 'name':item.@name,
									  'streamable':item.@streamable.toString() == "yes" ? true : false,
									  'count':Number(item.@count),
									  'mbid':item.mbid,
									  'url':item.url,
									  'thumbnail':item.thumbnail,
									  'image':item.image };
				_properties['artists'].push(artist);
			}
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		public function get artists():Array {
			return _properties['artists'];
		}
		public function get count():int{
			return _properties['count'];
		}
	}
}