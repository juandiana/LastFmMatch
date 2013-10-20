package  
{
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
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
			Main.instance.ballsLayer.addChild(mc);
			mc.okButton.addEventListener(MouseEvent.CLICK, onOkButtonClick);
			Main.instance.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.ENTER) {
				startVisualization();
			}
		}
		
		private function onOkButtonClick(e:MouseEvent):void 
		{
			startVisualization();
		}
		
		private function startVisualization():void {			
			Main.instance.startVisualization(mc.input1.text, mc.input2.text);
			Main.instance.ballsLayer.removeChild(mc);
		}
	}

}
