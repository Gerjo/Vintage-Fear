package Objects {
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import Items.ItemWhirl;
	import StarFinding.StarNode;
	import StarFinding.StarFinder;
	import StarFinding.StarErrorImpossibleRoute;

	public class Player extends BaseObject {
		public var health:Number       = 100;
		public var ammo:Number         = 99;
		public var bulletDamage:Number = 1;
		
		public function Player(owner:Game, x:int, y:int) {
			super(owner, x, y);
			loadBitmap(Assets.PLAYER, "custom", new Point(-12,-15));//-8, -10
			enableSpriteMap();			
			setTilesUsed(1, 1);
			//drawTilesUsed();
			maxspeed = new Point(0.07, 0.07);
			showSpriteCol(2);
			
			//drawBounds();
			
			//drawRectangle();
		}
			
		public override function update(timeDifference:Number) : void {
			walkPath(timeDifference);
			
		}
		
		public override function arriveAtGoal() : void {
			owner.crosshairDestination.setLocation( -100, -100);
			arriveAtStarNode();
		}
		
		public override function arriveAtStarNode() : void {
			owner.registerTileItem(this);
		}
		
		public function shoot(mouseLocation:Point) : void {
			if (ammo > 0) {
				owner.sound.gunShot();
				
				--ammo;
				var ab:Point   = new Point(mouseLocation.x-x, mouseLocation.y-y);
				var len:Number = Math.sqrt(ab.x * ab.x + ab.y * ab.y);
				var n:Point    = new Point(ab.x / len, ab.y / len);
				
				new Bullet(owner, getNodeLocation(), n);
			}
		}
		
		// Set all the initial values.
		public function reset() : void {
			health = 100;
			ammo   = 30;
		}
		
		
		public override function onCollision(object:BaseObject) : void {
			//trace("Player hits a ", object);
			
			if (object is Zombie) {
				health -= 30;
				owner.flash.show();
				object.deleteMe = true;
				
				owner.sound.playerHit();
				owner.spawnZombies(2);
				
				new TextCloud(owner, getNodeLocation(), '-20% health', 0xFF0000);
				
				new Gore(owner, getNodeLocation());
				new Gore(owner, getNodeLocation());
				new Gore(owner, getNodeLocation());
				new Gore(owner, getNodeLocation());
			}
		}
		
		public function onMouseDown(e:MouseEvent) : void {
			try {
				
				var coords:Point  = new Point(e.stageX, e.stageY).subtract(Game.gameOffset);
				var goal:StarNode = new StarNode(Math.floor(coords.x / Game.tileSize), Math.floor(coords.y / Game.tileSize));
			
				var buff:Array = StarFinder.getInstance().createPath(owner, getNodeLocation(), goal);
				buff.shift();
				
				path = buff;
				
				if(owner.grid != null) {
					// Use this to draw the route:
					for each(var node:StarNode in path) {
						//owner.grid.highlightTile(node);
					}
				}
				owner.crosshairDestination.setLocation(goal.x, goal.y);
				
			} catch (e:StarErrorImpossibleRoute) {
				trace("no route found");
				path = new Array();
			}
		}
		
		public override function getRectangle() : Rectangle {
			
			return new Rectangle(x, y, 22, 22);
		}
	}
}