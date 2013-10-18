package com.lfm.client {
	
	import flash.events.*;
	import com.gsolo.encryption.MD5;
	import flash.net.*;
    import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLRequestMethod;
	
	public class RadioSession extends AbstractSession {
		
		private var _response:Array;
		
		public function RadioSession(username:String, password:String, client:String='tst', language:String='en') {
			super(username, password, client);
			HANDSHAKE_URL = "http://ws.audioscrobbler.com/radio/handshake.php";
		}
		
		override protected function setPostVars():void {
			_postVars = new URLVariables();
			_postVars['version'] = "1.3.1.1";
			_postVars['platform'] = "win32";
			_postVars['username'] = _username;
			_postVars['passwordmd5'] = _password;
			_postVars['language'] = 'en';
			_postVars['player'] = 'winamp';
			trace(_postVars);
		}
		
		
		override protected function parse_response(event:Event):void {
			var loader:URLLoader = URLLoader(event.target);
			_response = new Array();
			_response = loader.data.split("\n");
			var stat:String = _response[0].split(" ",1)[0];
			var level:String = "";
			switch(stat) {
				case "session=FAILED":
					stat = "FAILED";
					level = "error";
					break;
				default:
					stat = "OK";
					level = "status";
			}
			trace(_response);
			dispatchEvent( new StatusEvent(StatusEvent.STATUS, false, false, stat, level) );
		}
		
		
	}
	
	
	
}