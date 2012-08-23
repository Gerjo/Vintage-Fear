package Layers {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.geom.Point;

	public class TopHud extends BaseLayer {
		private var bulletText:TextSprite  = new TextSprite("00",  new Point(310, 92), { size:17 } );
		private var healthText:TextSprite  = new TextSprite("100%", new Point(385, 92), { size:17 } );
		
		public function TopHud(owner:Game) {
			super(owner);
			
			loadBitmap(Assets.NEWHUD, "bla");
			
			image.x = 153;
			image.y = 93;
			
			addChild(bulletText);
			addChild(healthText);
		}
		public override function update(timeDifference:Number) : void {
			if (owner.player.ammo < 10) {
				bulletText.textFormat.color = 0xff0000;
			} else {
				bulletText.textFormat.color = 0xffffff;		
			}
			
			if (owner.player.health <= 25) {
				healthText.textFormat.color = 0xff0000;
			} else {
				healthText.textFormat.color = 0xffffff;		
			}
			
			bulletText.setText(owner.player.ammo + "");
			healthText.setText(owner.player.health + "%");
			
			if (owner.gamestate  == GameStates.MAINMENU) {
				alpha = 0;
			} else {
				alpha = 1;
			}
		}
	}
}