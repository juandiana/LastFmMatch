package com.lfm.client {
	
	import flash.events.*;
	import com.gsolo.encryption.MD5;
	import flash.net.*;
    import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLRequestMethod;
	
	public class ScrobbleSession extends AbstractSession {
		
		
		public function ScrobbleSession(username:String, password:String, client:String) {
			super(username, password, client);
			HANDSHAKE_URL = "http://post.audioscrobbler.com/";
		}
		
		override protected function setPostVars():void {
			_postVars = new URLVariables();
			_postVars['hs'] = "true";
			_postVars['p'] = "1.2";
			_postVars['c'] = _client;
			_postVars['v'] = "1";
			_postVars['u'] = _username;
			var timestamp:Date = new Date();
			_postVars['t'] = Math.floor(timestamp.getTime()/1000);
			_postVars['a'] = MD5.encrypt(_password + Math.floor(timestamp.getTime()/1000));/**/
		}
		
		
		override protected function parse_response(e:Event):void {
			var loader:URLLoader = URLLoader(e.target);
			var response:Array = new Array();
			//sclear_session();
			response = loader.data.split("\n");
			var stat:String = response[0].split(" ",1)[0];
			var lfm_session:Object = {};
			switch(stat) {
				case "OK":
					lfm_session.status = "OK";
					lfm_session.id = response[1];
					lfm_session.np_url = response[2];
					lfm_session.post_url = response[3];
					lfm_session.success = true;
					break;
				case "BANNED":
					lfm_session.status = "BANNED";
					lfm_session.success = false;
					lfm_session.reason = "Banned Client";
					break;
				case "FAILED":
					lfm_session.status = "FAILED";
					lfm_session.reason = response[0].substr(response[0].indexOf(" ")+1);
					lfm_session.success = false;
					break;
				case "BADAUTH":
					lfm_session.status = "BADAUTH";
					lfm_session.reason = "Bad Authentication";
					lfm_session.success = false;
					break;
				case "BADTIME":
					lfm_session.status = "BADTIME";
					lfm_session.reason = "Bad timestamp";
					lfm_session.success = false;
					break;
				default:
					lfm_session.status = "UNKNOWN";
					lfm_session.reason = "Unknown Error";
					lfm_session.success = false;
			}
			var level:String = "";
			if(stat == "OK") {
				level = "status";
			} else {
				level = "error";
			}
			dispatchEvent( new StatusEvent(StatusEvent.STATUS, false, false, stat, level) );
		}
		
		
	}
	
	
	
}