package Layers {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.geom.Point;

	public class Hud extends BaseLayer {
		private var fpsDuration:TextSprite = new TextSprite("", new Point(500, 465), { size:13 } );
		private var fpsText:TextSprite     = new TextSprite("", new Point(500, 480), { size:13 } );
		private var weapon:BaseLayer	   = new BaseLayer(null, false);
		private var bulletText:TextSprite  = new TextSprite("", new Point(160, 465), { size:32 } );
		
		private var fpsBuffer:int      = 0;
		private var fpsCounter:int     = 0;
		private var fpsTimer:Number	   = 0;
		
		public function Hud(owner:Game) {
			super(owner);
			
			//loadBitmap(Assets.HUD);
			
			alpha = 1;
			
			//weapon.loadBitmap(Assets.TOMMYGUN);
			
			weapon.x = 520;
			weapon.y = 467;
			
			//image.alpha = 0.8;
			
			//addChild(weapon);
			//addChild(fpsText);
			//addChild(fpsDuration);
			//addChild(bulletText);
		}
		
		public override function update(timeDifference:Number) : void {
			++fpsCounter;
			if ((fpsTimer += timeDifference) >= 100) {
				fpsBuffer = fpsTimer;
				fpsTimer = 0;
			}
			
			//bulletText.setText(owner.player.ammo+"");
			//fpsText.setText("Frames per Sec: " + timeDifference);
			//fpsDuration.setText("Frame Duration: " + fpsBuffer);
		}
	}
}