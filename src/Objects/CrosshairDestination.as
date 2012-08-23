package Objects {
	import Layers.BaseLayer;
	public class CrosshairDestination extends BaseObject {
		public function CrosshairDestination(owner:Game) {
			super(owner, -100, -100, false);
			loadBitmap(Assets.CROSSHAIRRED, "center");
			
			image.x = 7;
			image.y = 7;
			
			owner.addChild(this);
		}	
		
		public override function update(timeDifference:Number) : void {
			image.rotation += 6;
		}
	}
}