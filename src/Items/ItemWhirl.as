package Items {
	import Layers.BaseLayer;
	import Objects.Player;
	import StarFinding.StarNode;
	import Objects.BaseObject;
	

	public class ItemWhirl extends BaseObject {
		public function ItemWhirl(owner:Game, where:StarNode) {
			super(owner, where.x, where.y);
			
			loadBitmap(Assets.WHIRL);
			
			image.x = 10;
			image.y = 10;
		}
		
		public override function update(timeDifference:Number) : void {
			image.rotation += 10;
		}
	}
}