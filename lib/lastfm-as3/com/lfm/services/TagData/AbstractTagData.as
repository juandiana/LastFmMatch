package com.lfm.services.TagData
{
	import com.lfm.services.AbstractService;
	
	import flash.events.Event;

	public class AbstractTagData extends AbstractService
	{
		public function AbstractTagData(tag:String="")
		{
			super();
			_properties['tag'] = tag;
			BASE_URL += "tag/";
		}
		override protected function parseData(evt:Event):void {
			super.parseData(evt);
		}
		public function get tag():String{
			return _properties['tag'];
		}
	}
}