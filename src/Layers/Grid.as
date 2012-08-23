package Layers {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import StarFinding.StarNode;

	public class Grid extends BaseLayer {
		public var tiles:Array;
		public var worldBuilder:Array;
		
		public function Grid(owner:Game) {
			super(owner);
			
			buildTileGrid();
		}
		
		public function highlightTile(a:StarNode) : void {
			try { tiles[a.x][a.y].mark(graphics); }catch(e:Error){}
		}
		
		public function reset() : void {
			//tiles = new Array();
			graphics.clear();
			for (var x:int = 0; x < Game.tileCount.x; ++x) {
				//tiles[x] = new Array();
				for (var y:int = 0; y < Game.tileCount.y; ++y) {
					tiles[x][y] = new Tile(new Point(x, y));
					tiles[x][y].draw(graphics);
				}
			}
		}
		
		public function buildTileGrid() : void {
			tiles = new Array();
			
			for (var x:int = 0; x < Game.tileCount.x; ++x) {
				tiles[x] = new Array();
				for (var y:int = 0; y < Game.tileCount.y; ++y) {
					tiles[x][y] = new Tile(new Point(x, y));
					tiles[x][y].draw(graphics);
				}
			}
		}
		
		public function onMouseMove(e:MouseEvent) : void {
			if (e.buttonDown) {
				var foo:Point = new Point(e.stageX, e.stageY).subtract(Game.gameOffset);
				try { tiles[Math.floor(foo.x/Game.tileSize)][Math.floor(foo.y/Game.tileSize)].mark(graphics); } catch(e:Error) {}
				export();
				
				//owner.player.path = owner.pathfinder.fromToPath(owner.player.getNodeLocation(), new Node(foo.x, foo.y));
			}
		}
		
		public function onMouseDown(e:MouseEvent) : void {
			onMouseMove(e);
		}
				
		public function export() : void {
			var out:String = "";
			for (var x:int = 0; x < Game.tileCount.x; ++x) {
				for (var y:int = 0; y < Game.tileCount.y; ++y) {
					if ((tiles[x][y] as Tile).isMarked) {
						out += 'arr['+x+']['+y+'] = true;';
					}
				}
			}
			
			trace();
			trace(out);
		}
	}
}