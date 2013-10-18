package com.lfm.client {	
	
	import com.gsolo.encryption.MD5;
	import flash.events.Event;
	import flash.events.StatusEvent;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
    import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLRequestMethod;


	public class AbstractSession extends EventDispatcher {
		
		protected var HANDSHAKE_URL:String;
		protected var _username:String;
		protected var _password:String;
		protected var _postVars:URLVariables;
		protected var _client:String;
		
		public function AbstractSession(username:String,password:String,client:String) {
			_username = username;
			this.password = password;
			_client = client;
		}
		
		private function handshake():void {
			var shake_request:URLRequest = new URLRequest(HANDSHAKE_URL);
			var shake_loader:URLLoader = new URLLoader();
			shake_request.data = _postVars;
			shake_request.method = URLRequestMethod.GET;
			shake_loader.addEventListener(Event.COMPLETE,parse_response);
			shake_loader.addEventListener(IOErrorEvent.IO_ERROR,handshakeError);
			shake_loader.load(shake_request);
		}
		
		
		protected function parse_response(event:Event):void { }
		
		private function handshakeError(event:IOErrorEvent):void { 
			dispatchEvent(event);
		}
		
		
		public function create():void {
			setPostVars();
			this.handshake();
		}
		
		protected function setPostVars():void { }
		
		public function set username(user:String):void {
			_username = user;
		}
		public function set password(pass:String):void {
			_password = MD5.encrypt(pass);
		}
		
		
	}
	
	
}