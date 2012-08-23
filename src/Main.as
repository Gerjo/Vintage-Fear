package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	
	public class Main extends Sprite {
		private var game:Game;
		
		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			game = new Game();
			addChild(game);
			stage.addEventListener(Event.ENTER_FRAME, game.onEnterFrame);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, game.onMouseMove);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, game.onKeyDown);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, game.onMouseDown);
			stage.frameRate = 40;
			
			stage.showDefaultContextMenu = false;
			
			try {
				ExternalInterface.addCallback("rightClick", game.onRightClick);
			//ExternalInterface.call("fromAS3");
			} catch (e:Error) {
				
			}
		}
	}
}