package Layers {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.geom.Point;
	import StarFinding.StarNode;

	public class FogOfWar extends BaseLayer {
		public var grid:Array;
		public var poked:Array      = new Array();
		public var totalTime:Number = 0;
		public var limit:Number     = 0; // set to .8
		
		public function FogOfWar(owner:Game) {
			super(owner);	
			
			fillGrid();
		}
		
		public function reset() : void {
			for (var x:int = 0; x < Game.tileCount.x; ++x) {
				for (var y:int = 0; y < Game.tileCount.y; ++y) {
					grid[x][y].alpha = limit;
				}
			}
		}
		
		public function fillGrid() : void {
			grid = new Array();
			
			for (var x:int = 0; x < Game.tileCount.x; ++x) {
				grid[x] = new Array();
				for (var y:int = 0; y < Game.tileCount.y; ++y) {
					grid[x][y] = new FogCloud(Game.gameOffset.x + x * Game.tileSize, Game.gameOffset.y + y * Game.tileSize, new StarNode(x,y));
					grid[x][y].alpha = limit;
					addChild(grid[x][y]);
				}
			}
		}
		
		public override function update(timeDifference:Number) : void {
			totalTime += timeDifference;
			var loc:StarNode = owner.player.getNodeLocation();
			
			if (totalTime > 100) {
				totalTime = 0;
				
				for (var j:int = 0; j < poked.length; ++j) {
					var obj:FogCloud = poked[j];
					if( obj.alpha < limit) {
						 obj.alpha += 0.01;
						 
						//var top:Boolean    = !getVisibiltyAtCoord(obj.starnode.x, obj.starnode.y - 1);
						//var bottom:Boolean = !getVisibiltyAtCoord(obj.starnode.x, obj.starnode.y + 1);
						//var left:Boolean   = !getVisibiltyAtCoord(obj.starnode.x - 1, obj.starnode.y);
						//var right:Boolean  = !getVisibiltyAtCoord(obj.starnode.x + 1, obj.starnode.y);
						
					} else {
						obj.addedToPokedList = false;
						poked.splice(j, 1);
					}
				}
			}
			
			// Poke all the clouds around the player:
			for (var i:int = -3; i < 4; ++i) {
				poke(loc.x - 3, loc.y + i);
				poke(loc.x - 2, loc.y + i);
				poke(loc.x - 1, loc.y + i);
				poke(loc.x - 0, loc.y + i);
				poke(loc.x + 1, loc.y + i);
				poke(loc.x + 2, loc.y + i);
				poke(loc.x + 3, loc.y + i);
			}
			
			var out:Number = .4;
			
			poke(loc.x - 2, loc.y - 4, out);
			poke(loc.x - 1, loc.y - 4, out);
			poke(loc.x - 0, loc.y - 4, out); //poke(loc.x - 0, loc.y - 4);
			poke(loc.x + 1, loc.y - 4, out);
			poke(loc.x + 2, loc.y - 4, out);
			
			poke(loc.x - 4, loc.y - 2, out);
			poke(loc.x - 4, loc.y - 1, out);
			poke(loc.x - 4, loc.y - 0, out); //poke(loc.x - 4, loc.y - 0);
			poke(loc.x - 4, loc.y + 1, out);
			poke(loc.x - 4, loc.y + 2, out);
			
			poke(loc.x + 4, loc.y - 2, out);
			poke(loc.x + 4, loc.y - 1, out);
			poke(loc.x + 4, loc.y - 0, out); //poke(loc.x + 4, loc.y - 0);
			poke(loc.x + 4, loc.y + 1, out);
			poke(loc.x + 4, loc.y + 2, out);
			
			poke(loc.x - 2, loc.y + 4, out);
			poke(loc.x - 1, loc.y + 4, out);
			poke(loc.x + 0, loc.y + 4, out); //poke(loc.x + 0, loc.y + 4);
			poke(loc.x + 1, loc.y + 4, out);
			poke(loc.x + 2, loc.y + 4, out);
			
		}
		
		public function getCloudAt(loc:StarNode) : FogCloud {
			try { return grid[loc.x][loc.y]; } catch (e:Error) {  }
			return null;
		}
		
		public function getVisibiltyAt(loc:StarNode) : Boolean {
			return true;// remove this line!
			try { return !(grid[loc.x][loc.y].alpha >= limit-0.1); } catch (e:Error) {  }
			return false;
		}
		
		public function getVisibiltyAtCoord(x:int, y:int) : Boolean {
			try { return !(grid[x][y].alpha >= limit-0.1); } catch (e:Error) {  }
			return false;
		}
		
		public function poke(x:int, y:int, newAlpha:Number = 0) : void {
			// Reset the alpha channel:
			try { 
				if(grid[x][y].alpha > newAlpha) {
					grid[x][y].alpha = newAlpha; 
				}
			} catch (e:Error) { return; }
			
			// Cloud is added to a quick list; only clouds in this array are updated.
			if (!grid[x][y].addedToPokedList) {
				grid[x][y].addedToPokedList = true;
				poked.push(grid[x][y]);	
				
			}
		}
	}
}