package com.lfm.services.UserData {
	import com.lfm.services.AbstractService;
	import flash.events.Event;
	public class AbstractUserData extends AbstractService {

		function AbstractUserData(user:String) {
			super();
			_properties['username'] = user;
			BASE_URL += "user/" + user + "/";
		}
		
		override protected function parseData(evt:Event):void {
			super.parseData(evt);
			_properties['username'] = _svcXML.@user.toString();
		}
		public function get username():String {
			return _properties['username'];
		}
	}
	
}