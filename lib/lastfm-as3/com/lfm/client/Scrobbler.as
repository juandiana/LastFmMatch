package com.lfm.client {	
	
	import com.lfm.client.Session;
	import com.lfm.model.Track;
	import com.gsolo.encryption.MD5;
	import flash.events.Event;
	import flash.events.StatusEvent;
	import flash.events.ErrorEvent;
	import flash.events.IOErrorEvent;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
    import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLRequestMethod;


	public class Scrobbler extends EventDispatcher {

		private var lfm_session:Session;
		public var ready:Boolean = false;
		public var lastSubmission:Track;
		
		public function Scrobbler(user:String,pass:String) {
			lfm_session = new Session(user,pass);
			lfm_session.addEventListener(StatusEvent.STATUS, sessionStatus);
			lfm_session.addEventListener(IOErrorEvent.IO_ERROR, sessionError);
			lfm_session.create();
		}
		
		public function connect():void {
			lfm_session.create();
		}
		
		private function sessionStatus(event:StatusEvent):void {
			if(event.code == "OK") {
				dispatchEvent(new Event(Event.CONNECT));
			} else {
				dispatchEvent(new ErrorEvent(ErrorEvent.ERROR, false, false, lfm_session.reason));
			}
			trace("Session acquired. Session Success: "+lfm_session.success);
		}
		
		public function submit(track:Track):void {
			
			dispatchEvent(new Event(Event.INIT));
			
			var req:URLRequest = new URLRequest(lfm_session.postURL);
			var loader:URLLoader = new URLLoader();
			
			var post_vars:URLVariables = new URLVariables();
			var submitTime:Date = new Date();
			post_vars['s'] = lfm_session.id;
			post_vars['a[0]'] = track.artist;
			post_vars['t[0]'] = track.title;
			post_vars['i[0]'] = track.timestamp;
			post_vars['o[0]'] = track.source;
			post_vars['r[0]'] = track.rating;
			post_vars['l[0]'] = track.length;
			post_vars['b[0]'] = track.album;
			post_vars['n[0]'] = track.tracknum;
			post_vars['m[0]'] = track.mbid;

			req.data = post_vars;
			req.method = URLRequestMethod.POST;
			lastSubmission = track;
			
			loader.addEventListener("complete",submitComplete);
			loader.addEventListener("ioError",submitError);
			loader.load(req);
			
		}
		
		public function submitNowPlaying(track:Track):void {
			var post_vars:URLVariables = new URLVariables();
			post_vars['s'] = lfm_session.id;
			post_vars['a'] = track.artist;
			post_vars['t'] = track.title;
			post_vars['b'] = track.album;
			post_vars['m'] = track.mbid;
			post_vars['l'] = track.length;
			
			var req:URLRequest = new URLRequest(lfm_session.npURL);
			var loader:URLLoader = new URLLoader();
			
			req.data = post_vars;
			req.method = URLRequestMethod.POST;
			loader.load(req);
			loader.addEventListener(Event.COMPLETE,function(evt:Event):void { trace("np: "+evt.target.data); });
		}
		
		private function submitComplete(evt:Event):void {
			trace("complete: "+evt.target.data);
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function submitError(event:IOErrorEvent):void {
			dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR,false,false,"There was a problem submitting the track. The webservice may be temporarily down."));
		}
		
		private function sessionError(event:IOErrorEvent):void {
			trace("error establishing session "+lfm_session.reason);
			dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR,false,false,"There was a problem establishing a session. The webservice may be temporarily down."));
		}
		
		
	}
	
	
}