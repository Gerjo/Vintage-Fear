package Objects {
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import Items.ItemBullets;
	import Layers.BaseLayer;
	import StarFinding.StarFinder;
	import StarFinding.StarNode;
	
	public class Zombie extends BaseObject {
		private var pathcounter:int = Toolkit.random(0, 10);
		protected var sleepDelay:Number   = 0;
		protected var sleepCounter:Number = 0;
		public var health:Number          = 5;
		
		public function Zombie(owner:Game, where:StarNode) {
			super(owner, where.x, where.y);
			loadBitmap(Assets.ZOMBIE, "custom", new Point(-12, -15));
			
			enableSpriteMap();
			setTilesUsed(1, 1);
			//drawTilesUsed();
			
			var speed:Number = Toolkit.random(40, 100) / 4000;
			maxspeed = new Point(speed, speed);
		}
		
		public override function arriveAtGoal() : void {
			arriveAtStarNode();
		}
		
		public override function onCollision(object:BaseObject) : void {
			//new ItemBullets(owner, getNodeLocation());
		}
		
		public override function arriveAtStarNode() : void {
			owner.registerTileItem(this);
			
			followPlayer();
		}
		
		public function followPlayer() : void {
			if (sleepCounter < sleepDelay && path.length > 0) return;
			sleepCounter = 0;
			
			try {
				if (++pathcounter >= 5) {
					pathcounter = 0;
					
					//if (getNodeLocation().calculateHeuristics(owner.player.getNodeLocation()) > 15) {
						path = StarFinder.getInstance().createPath(owner, getNodeLocation(), owner.player.getNodeLocation());
						path.shift();
						
						if (path.length > 10) {
							//path = new Array();
							sleepDelay = 10;
						} else {
							sleepDelay = 10;
						}
					//}
				}
			} catch (e:Error) { }
		}
		
		public override function update(timeDifference:Number) : void {
			sleepCounter += timeDifference; // increment an internal timer.
			
			if (path.length <= 0) followPlayer();
			walkPath(timeDifference, true);
		}
	}
}