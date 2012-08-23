package Layers {
	import flash.display.Bitmap;
	import flash.display.Sprite;

	public class Flash extends BaseLayer {
		private var isFadingToVisible:Boolean = false;
		private var inSpeed:Number            = 0.2;
		private var outSpeed:Number           = 0.2;
		
		public function Flash(owner:Game) {
			super(owner);
			
			loadBitmap(Assets.FLASHLAYER);
			
			alpha = 0;
		}
		
		public function show() : void {
			isFadingToVisible = true;
		}
		
		public function hide() : void {
			isFadingToVisible = false;
		}
		
		public override function update(timeDifference:Number) : void {
			if (isFadingToVisible) {
				if (alpha <= 1) {
					alpha += inSpeed;
				} else {
					hide();
				}
			} else if (!isFadingToVisible) {
				if (alpha > 0) {
					alpha -= outSpeed;
				}
			}
		}
	}
}