package Objects {
	import flash.geom.Point;
	import Layers.BaseLayer;
	import StarFinding.StarNode;
	
	public class Gore extends BaseObject {
		private var fadeTimer:Number = 0;
		
		public function Gore(owner:Game, where:StarNode, rotation:Number = 0) {
			super(owner, where.x, where.y);
			
			switch(Toolkit.random(1, 7)) {
				case 7:  loadBitmap(Assets.SPLATTER7, "custom", new Point( -30, -30));  break;
				case 6:  loadBitmap(Assets.SPLATTER6, "custom", new Point( -30, -30));  break;
				case 5:  loadBitmap(Assets.SPLATTER5, "custom", new Point( -30, -30));  break;
				case 4:  loadBitmap(Assets.SPLATTER4, "custom", new Point( -30, -30));  break;
				case 3:  loadBitmap(Assets.SPLATTER3, "custom", new Point( -30, -30));  break;
				case 2:  loadBitmap(Assets.SPLATTER2, "custom", new Point( -30, -30));  break;
				case 1:  loadBitmap(Assets.SPLATTER1, "custom", new Point( -30, -30));  break;
				default: loadBitmap(Assets.SPLATTER1, "custom", new Point( -30, -30));  break;
			}

			this.rotation = rotation;
			//image.x        = -20;
			//image.y        = -20;
		}	
		
		public override function update(timeDifference:Number) : void {
			if ((fadeTimer += timeDifference) > 100) {
				fadeTimer = 0;
				alpha -= 0.001;
				if (alpha < 0) deleteMe = true;
			}
			//rotation++;
		}
	}
}