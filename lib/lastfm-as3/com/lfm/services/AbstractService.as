package com.lfm.services {
	
	import flash.net.URLLoader;
    import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLRequestMethod;
	import flash.events.*;
	import flash.events.IOErrorEvent;
	import flash.events.EventDispatcher;
	
	public class AbstractService extends EventDispatcher {
		
		protected var BASE_URL:String = "http://ws.audioscrobbler.com/1.0/";
		protected var _svcXML:XML;
		protected var _properties:Object = new Object();
		
		public function AbstractService() { }
		
		public function get serviceURL():String {
			return BASE_URL;
		}
		
		public function load():void {
			var service_request:URLRequest = new URLRequest(this.serviceURL);
			var service_loader:URLLoader = new URLLoader();
			service_loader.addEventListener(IOErrorEvent.IO_ERROR,serviceError);
			service_loader.addEventListener(Event.COMPLETE,parseData);
			service_loader.load(service_request);
		}
		
		protected function parseData(evt:Event):void { 
			_svcXML = new XML(evt.target.data);
		}
		
		protected function serviceError(evt:IOErrorEvent):void {
			this.dispatchEvent(evt);
			trace("Error loading web service: "+evt.text);
		}
	}
	
	
}