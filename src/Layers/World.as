package Layers {
	import flash.display.Bitmap;
	import flash.display.Sprite;

	public class World extends BaseLayer {
		public function World(owner:Game) {
			super(owner);
			
			loadBitmap(Assets.LEVEL1BACKGROUND);

		}
	}
}