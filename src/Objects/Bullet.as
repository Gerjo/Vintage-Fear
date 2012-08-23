package Objects {
	import flash.geom.Point;
	import Items.ItemBullets;
	import Items.ItemHealth;
	import Items.ItemWhirl;
	import Layers.BaseLayer;
	import StarFinding.StarNode;
	public class Bullet extends BaseObject {
		public var normalVector:Point;
		public var incremental:Number = 15;
		
		public function Bullet(owner:Game, base:StarNode, normalVector:Point) {
			super(owner, base.x, base.y);
			this.normalVector = normalVector;
			
			rotation = 180 - (Math.atan2(normalVector.x, normalVector.y) * 180 / Math.PI);
			
			x += 5;
			y += 5;
			loadBitmap(Assets.BULLET, "center");
			
			
		}	
		
		public override function update(timeDifference:Number) : void {
			
			x += incremental * normalVector.x;
			y += incremental * normalVector.y;
			
			// World boundaries:
			if (x < Game.gameOffset.x || y < Game.gameOffset.y || x > Game.gameSize.x + Game.gameOffset.x  || y > Game.gameSize.y + Game.gameOffset.y) {
				deleteMe = true;
			}
			
			// A solid object (usually walls):
			if (owner.checkForSolid(getNodeLocation())) {
				deleteMe = true;
				//new Gore(owner, getNodeLocation());
			}
			
			if (owner.grid != null) {
				//owner.grid.highlightTile(getNodeLocation());
			}
			
			// Get the objects at the same tile:
			var objectsAtTile:Array = new Array();// owner.getTileItemsAt(getNodeLocation());
			objectsAtTile = objectsAtTile.concat(owner.getTileItemsAround(getNodeLocation()));
			
			
			if (objectsAtTile.length > 0) { // Sometime is actually at the tile:
				
				
				
				for (var i:int = 0; i < objectsAtTile.length; ++i) {
					if (objectsAtTile[i] is Zombie) {
						var zombie:Zombie = objectsAtTile[i];
						if (!zombie.deleteMe) {
							if(zombie.getRectangle().intersects(getRectangle())) {
								
								zombie.health -= Toolkit.random(1,3);
								owner.sound.zombieHit();
								if (zombie.health <= 0) {
									
									
									// Lets just assume we can kill it.
									zombie.deleteMe = true;
									owner.spawnZombies(1);
									this.deleteMe = true;
									
									switch(Toolkit.random(0, 10)) {
										case 0:
										case 1:
										case 2:
										case 3:
										case 4:
											new ItemBullets(owner, zombie.getNodeLocation()); 
											break;
										
										
										case 7: 
											new ItemHealth(owner, zombie.getNodeLocation());  
											break;
											
										//case 2: new ItemWhirl(owner, getNodeLocation());          break;
									}
									
									//new ItemWhirl(owner, getNodeLocation());
									
									new Gore(owner, getNodeLocation(), rotation);
								}
								
								new Gore(owner, getNodeLocation(), rotation);
								new Gore(owner, getNodeLocation(), rotation);
								
								//new ItemWhirl(owner, getNodeLocation());
								//return;
							}
						}
					}
				}
			}
			
			//++incremental;
		}
	}
}