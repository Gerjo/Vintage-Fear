package Items {
	import Layers.BaseLayer;
	import Objects.Player;
	import StarFinding.StarNode;
	import Objects.BaseObject;
	import Objects.TextCloud;
	
	public class ItemHealth extends BaseObject {
		private var value:int = 10; //Health awarded for this pick up.
		
		public function ItemHealth(owner:Game, where:StarNode) {
			super(owner, where.x, where.y);
			loadBitmap(Assets.ITEMHEALTH, "map");
			
			//image.x = -20;
			//image.y = -20;
			setTilesUsed(1, 1);
			//drawTilesUsed();
		}	
		
		public override function update(timeDifference:Number) : void {
			
		}
		
		public override function onCollision(object:BaseObject) : void {
			if(object is Player) {
				this.deleteMe = true;
				var diff:int = 99 - owner.player.health;
				
				if(diff != 0) {
					owner.player.health += (diff > value) ? value:diff;
				}
				
				new TextCloud(owner, getNodeLocation(), "+" + value + " health");
			}
		}
	}
}