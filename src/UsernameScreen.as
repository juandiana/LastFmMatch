package  
{
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author 
	 */
	public class UsernameScreen 
	{
		
		private var mc:m_UsernameScreen
		
		public function UsernameScreen() 
		{
			trace("new username screen");
			mc = new m_UsernameScreen();
			Main.instance.layer1.addChild(mc);
			mc.okButton.addEventListener(MouseEvent.CLICK, onOkButtonClick);			
		}
		
		
		private function onOkButtonClick(e:MouseEvent):void 
		{
			trace("start visualization");
			Main.instance.startVisualization(mc.input1.text, mc.input2.text);
			Main.instance.layer1.removeChild(mc);
		}
		
	}

}