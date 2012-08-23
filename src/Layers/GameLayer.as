package Layers {
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	public class GameLayer extends BaseLayer {
		public function GameLayer(owner:Game) {
			super(owner);
		}
		
		// Arguably a very poor thing to do, override commonly used functions and change their behaviour. 
		public override function addChild(child:DisplayObject) : DisplayObject {
			addChildAt(child, 0);
			return child;
		}
	}
}