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


	public class Session extends EventDispatcher {
		
		private static const HANDSHAKE_URL:String = "http://post.audioscrobbler.com/";
		private var _username:String;
		private var _password:String;
		private var lfm_session:Object = new Object();
		private var _timestamp:Number = 0;
		private var _clientid:String;
		

		public function ScrobblerSession(user:String="",pass:String="",clientid:String="tst") {
			clear_session();
			_clientid = clientid;
			this.username = user;
			this.password = pass;
		}
		
		
		private function handshake():void {
	
			var post_vars:URLVariables = new URLVariables();
			post_vars['hs'] = "true";
			post_vars['p'] = "1.2";
			post_vars['c'] = _clientid;
			post_vars['v'] = "1";
			post_vars['u'] = this._username;
			var timestamp:Date = new Date();
			post_vars['t'] = _timestamp = Math.floor(timestamp.getTime()/1000);
			post_vars['a'] = MD5.encrypt(this._password + Math.floor(timestamp.getTime()/1000));
			
			
			var shake_request:URLRequest = new URLRequest(HANDSHAKE_URL);
			var shake_loader:URLLoader = new URLLoader();
			shake_request.data = post_vars;
			shake_request.method = URLRequestMethod.POST;
			shake_loader.addEventListener(Event.COMPLETE,parse_response);
			shake_loader.addEventListener(IOErrorEvent.IO_ERROR,handshakeError);
			shake_loader.load(shake_request);
		
		}
		
		private function parse_response(e:Event):void {
			var loader:URLLoader = URLLoader(e.target);
			var response:Array = new Array();
			clear_session();
			response = loader.data.split("\n");
			var stat:String = response[0].split(" ",1)[0];
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
			this.dispatchEvent( new StatusEvent(StatusEvent.STATUS, false, false, stat, level) );
		}
		
		private function handshakeError(event:IOErrorEvent):void {
			this.dispatchEvent(event);
		}
		
		private function clear_session():void {
			lfm_session = { status:"",
							id:"",
							post_url:"",
							np_url:"",
							interval:1,
							success:false };
		}
		
		
		public function set username(user:String):void {
			_username = user;
		}
		public function set password(pass:String):void {
			_password = MD5.encrypt(pass);
		}
		
		public function set password_MD5(pass:String):void {
			_password = pass;
		}
		
		public function get username():String {
			return _username;
		}
		public function get password():String {
			return _password;
		}
		public function get status():String {
			return lfm_session.status;
		}
		public function get interval():Number {
			return lfm_session.interval;
		}
		public function get success():Boolean {
			return lfm_session.success;
		}
		public function get id():String {
			return lfm_session.id;
		}
		public function get reason():String {
			return lfm_session.reason;
		}
		public function get postURL():String {
			return lfm_session.post_url;
		}
		public function get npURL():String {
			return lfm_session.np_url;
		}
		public function get updateURL():String {
			return lfm_session.update_url;
		}
		
		public function get timestamp():Number {
			return _timestamp;
		}
		
		public function create():void {
			this.handshake();
		}
		
	}
	
	
}