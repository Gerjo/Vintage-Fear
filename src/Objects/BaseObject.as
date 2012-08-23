package Objects  {
	import flash.geom.Rectangle;
	import Layers.BaseLayer;
	import flash.geom.Point;
	import flash.display.Sprite;
	import StarFinding.StarNode;
	
	public class BaseObject extends BaseLayer {
		protected var tilesUsed:Point		= null;
		protected var walking:int    		= 0;
		protected var maxspeed:Point        = new Point(2, 2);		
		protected var walkTimer:Number      = 0;
		public    var tileIndex:Number      = -1; // using 0 might be safer, but -1 makes more sense.
		public    var path:Array            = new Array();
		protected var rotateTo:Number		= 0;
		protected var isWalking:Boolean	    = false;
		
		public function BaseObject(owner:Game, x:int = -100, y:int = -100, addToGameLAyer:Boolean = true) {
			super(owner, false);
			
			// Game object are added to their own layer. Using this routine we can maintain 
			// a z-index between object. Per example: zombies will always sit underneath the picture canvas.
			
			if(addToGameLAyer) owner.gameLayer.addChild(this);
			setLocation(x, y);
			
			// Might have to add: if(addToGameLAyer)
			owner.registerTileItem(this);
		}
		
		public function showSpriteItem(col:int, row:int) : void {
			if (bitmapMask == null) throw new Error("Cannot show sprite item when the sprite map is not loaded to begin with.");
			showSpriteCol(col);
			//bitmapHolder.x = -(bitmap.width  / 3) * col;
			//bitmapHolder.y = -(bitmap.height / 4) * row;
		}
		
		public function showSpriteCol(col:int) : void {
			if (bitmapMask == null) throw new Error("Cannot show sprite item when the sprite map is not loaded to begin with.");
			bitmapHolder.x = -(bitmap.width  / 3) * col - 4; // The magic "5"
		}
		
		public function showSpriteRow(row:int) : void {
			throw new Error("Method depricated. Stop using it!");
			if (bitmapMask == null) throw new Error("Cannot show sprite item when the sprite map is not loaded to begin with.");
			bitmapHolder.y = -(bitmap.height / 4) * row;
		}
		
		public function enableSpriteMap() : void {
			if (bitmapHolder == null) throw new Error("Cannot load spritemap when no sprite is loaded to begin with.");
			bitmapMask = new Sprite();
			
			bitmapMask.graphics.beginFill(0, .3);
			bitmapMask.graphics.drawCircle(image.height/3, image.height/3, image.height/2);
			//bitmapMask.graphics.drawRect(spriteOffset.x / 2, spriteOffset.y / 2, image.width / 3, image.height);
			bitmapMask.graphics.endFill();
			
			bitmapHolder.mask = bitmapMask;

			addChild(bitmapMask);
			
			showSpriteItem(0, 0);
		}
		
		public function setTilesUsed(x:int, y:int) : void {
			tilesUsed = new Point(x, y);
			//setLocation(0, 0);
		}
				
		public function setLocation(x:int, y:int) : void {
			this.x = Game.gameOffset.x + x * Game.tileSize;			
			this.y = Game.gameOffset.y + y * Game.tileSize;
		}
		
		public function drawTilesUsed() : void {
			if (tilesUsed == null) throw new Error("Unable to draw tiles if no tiles are actually used.");
			graphics.lineStyle(1);
			graphics.drawRect(0, 0, tilesUsed.x * Game.tileSize, tilesUsed.y * Game.tileSize);
		}
		
		public function getNodeLocation() : StarNode {
			return new StarNode(Math.floor((x-Game.gameOffset.x)/Game.tileSize), Math.floor((y-Game.gameOffset.y)/Game.tileSize));
		}
		
		public function arriveAtGoal() : void {
			
		}
		
		public function arriveAtStarNode() : void {
			
		}
		
		public function onCollision(object:BaseObject) : void {
			
		}
		
		public function walkPath(timeDifference:Number = -1, spriteMotion:Boolean = true) : void {
			// probably could move down this bit in due time:
			//image.rotation += 5;
			
			if(image.rotation != rotateTo) {
				image.rotation = rotateTo;
			}
			
			if (path.length <= 0) return;
			
			var location:Point = new Point(x, y);
			var goto:StarNode  = (path[0] as StarNode);
			
			var tmaxspeed:Point = new Point(maxspeed.x * timeDifference, maxspeed.y * timeDifference);
			
			if (goto.coordinates.equals(location)) { 
				path.shift();
				if (path.length <= 0) {
					arriveAtGoal();
				} else {
					arriveAtStarNode();
				}
			}
			
			var distance:Point  = goto.coordinates.subtract(location);
			
			if(distance.x != 0) {
				if (Math.abs(distance.x) > tmaxspeed.x) {
					x += tmaxspeed.x * ((distance.x < 0) ? -1:1);
					//if(spriteMotion) showSpriteRow((distance.x > 0)?2:1);
				} else {
					x += distance.x;
					//if(spriteMotion) showSpriteRow((distance.x > 0)?2:1);
				}
			}
			
			if(distance.y != 0) {
				if (Math.abs(distance.y) > tmaxspeed.y) {
					y += tmaxspeed.y * ((distance.y < 0) ? -1:1);
					//if(spriteMotion) showSpriteRow((distance.y > 0)?0:3);
				} else {
					y += distance.y;
					//if(spriteMotion) showSpriteRow((distance.y > 0)?0:3);
				}
			}
			
			// No movement has taken place so resume the last position.
			if (location.equals(new Point(x, y))) {
				isWalking = false;
				
			} else {
				isWalking = true;
				var normalized:Point = location.subtract(new Point(x, y));
				//normalized.normalize(1);
				
				// Setup the new target rotation angle:
				rotateTo = 180 - (Math.atan2(normalized.x, normalized.y) * 180 / Math.PI);
			}
			
			
			if(spriteMotion) {
				if((walkTimer += timeDifference) > 100) {
					showSpriteCol(++walking % 3);
					walkTimer = 0;
				}
			}
		}
		
		public function getRectangle() : Rectangle {
			return new Rectangle(x, y, width, height);
			
		}
		
		public function drawRectangle() : void {
			var rect:Rectangle = getRectangle();
			graphics.lineStyle(1);
			graphics.drawRect(0, 0, rect.width, rect.height);
		}
	}
}