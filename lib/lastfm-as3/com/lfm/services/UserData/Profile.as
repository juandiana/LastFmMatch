package com.lfm.services.UserData {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import com.lfm.services.UserData.AbstractUserData;
	
	public class Profile extends AbstractUserData {

		
		public function Profile(user:String) {
			 _properties = { 'id':0,
						   'cluster':0,
						   'username':"",
						   'url':"",
						   'mboxsha1sum':"",
						   'registered':null,
						   'age':0,
						   'gender':"",
						   'country':"",
						   'playcount':0,
						   'avatar':"" };
			super(user);
			BASE_URL += "profile.xml";
		}
		
		
		override protected function parseData(event:Event):void {
			super.parseData(event);
			_properties['id'] = Number(_svcXML.@id.toString());
			_properties['cluster'] = Number(_svcXML.@cluster.toString());
			_properties['username'] = _svcXML.@username.toString();
			_properties['url'] = _svcXML.url.toString();
			_properties['mboxsha1sum'] = _svcXML.mbox_sha1sum.toString();
			_properties['registered'] = new Date((Number(_svcXML.registered.@unixtime.toString())*1000));
			_properties['age'] = Number(_svcXML.age.toString());
			_properties['gender'] = _svcXML.gender.toString();
			_properties['country'] = _svcXML.country.toString();
			_properties['playcount'] = Number(_svcXML.playcount.toString());
			_properties['avatar'] = _svcXML.avatar.toString();
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function get id():Number {
			return _properties['id'];
		}
		
		public function get cluster():Number {
			return _properties['cluster'];
		}
		
		public function get url():String {
			return _properties['url'];
		}
		
		public function get mboxsha1sum():String {
			return _properties['mboxsha1sum'];
		}
		
		public function get registered():Date {
			return _properties['registered'];
		}
		
		public function get age():Number {
			return _properties['age'];
		}
		
		public function get gender():String {
			return _properties['gender'];
		}
		
		public function get country():String {
			return _properties['country'];
		}
		
		public function get playcount():Number {
			return _properties['playcount'];
		}
		
		public function get avatar():String {
			return _properties['avatar'];
		}
	}
	
}