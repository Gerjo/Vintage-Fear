package Layers {
	import flash.display.Bitmap;
	import flash.display.Sprite;

	public class Background extends BaseLayer {
		public function Background(owner:Game) {
			super(owner);
			
			loadBitmap(Assets.WALLPAPER);
		}
	}
}