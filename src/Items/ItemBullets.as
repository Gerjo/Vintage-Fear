package Items {
	import Layers.BaseLayer;
	import Objects.Player;
	import Objects.TextCloud;
	import StarFinding.StarNode;
	import Objects.BaseObject;
	
	public class ItemBullets extends BaseObject {
		private var value:int = 10; // Bullets awarded for this pick up.
		private var timeAlive:Number = 0;
		
		public function ItemBullets(owner:Game, where:StarNode) {
			super(owner, where.x, where.y);
			loadBitmap(Assets.ITEMBULLET, "map");
			alpha = 1;
			//image.x = -20;
			//image.y = -20;
			setTilesUsed(1, 1);
			drawTilesUsed();
		}	
		
		public override function update(timeDifference:Number) : void {
			timeAlive += timeDifference;
			
			if (timeAlive > 5000) {
				alpha -= 0.01;
				if (alpha < 0) deleteMe = true;
			}
		}
		
		public override function onCollision(object:BaseObject) : void {
			if(object is Player) {
				deleteMe = true;
				var diff:int = 99 - owner.player.ammo;
				
				if(diff != 0) {
					owner.player.ammo += (diff > value) ? value:diff;
				}
				
				new TextCloud(owner, getNodeLocation(), "+" + value + " bullets");
			}
		}
	}
}