package com.lfm.services.UserData {
	import com.lfm.services.AbstractEventsData;
	
	public class UserEvents extends AbstractEventsData {
		
		public static const FRIENDS:String = "friends";
		public static const PERSONAL:String = "personal";
		public static const RECOMMENDED:String = "recommended";
		
		public function UserEvents(user:String, type:String="personal") {
			super();
			if(type == RECOMMENDED) {
				BASE_URL += "user/" + user + "/eventsysrecs.rss";
			} else if(type == FRIENDS) {
				BASE_URL += "user/" + user + "/friendevents.rss";
			} else {
				BASE_URL += "user/" + user + "/events.rss";
			}
		}
		
	}
	
}