package Layers {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class Menu extends BaseLayer {
		private var isFadingToVisible:Boolean = true;
		private var inSpeed:Number            = 0.2;
		private var outSpeed:Number           = 0.2;
		
		public function Menu(owner:Game) {
			super(owner);
		}
		
		public function onMouseDown(e:MouseEvent) : void {
			owner.startGame();
			
			alpha                         = 0;
			owner.gamestate               = GameStates.PLAYING;
			owner.pictureFrame.buttonMode = false;
			removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			
		}
		
		public function showStartGame() : void {
			loadBitmap(Assets.STARTGAME);
			alpha 						  = 1;
			owner.gamestate               = GameStates.MAINMENU;
			owner.pictureFrame.buttonMode = true;
			owner.pictureFrame.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			
		}
		
		public function showRipGame() : void {
			loadBitmap(Assets.RIPGAME);
			alpha 						  = 1;
			owner.gamestate               = GameStates.MAINMENU;
			owner.pictureFrame.buttonMode = true;
			owner.pictureFrame.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
	}
}