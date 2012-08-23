package StarFinding {
	import flash.geom.Point;
	
	public class StarNode {
		public var x:Number;
		public var y:Number;
		public var name:String;
		
		public var g:Number = 0; // Distance optimal path (steps taken so far)
		public var h:Number = 0; // Heuristic for this node
		public var c:Number = 0; // Movement cost for this node
		
		public var previous:StarNode = null; // Linked list reference field.
		
		public function StarNode(x:Number, y:Number, g:Number = 0, h:Number = 0, name:String = "") {
			this.x = x;
			this.y = y;
			this.g = g;
			this.h = h;
			this.name = name;
		}
		
		public function get f() : Number {
			return g + h + (h*0.01);
		}
		
		public function toArray(arr:Array = null) : Array {			
			if (arr == null) {
				var arr:Array = new Array();
			}
			
			// Creates better paths, however this might be buggy:
			if(false && arr.length > 1) {
				var dist:StarNode = this.distanceBetween(arr[arr.length - 1]);
				if (!dist.x == 1 || !dist.y == 1) {
					arr.push(this);
				}
			} else {
				arr.push(this);
			}
			
			if (previous != null) {
				previous.toArray(arr);
			}
			return arr;
		}
		
		public function calculateHeuristics(b:StarNode) : Number {
			//h = Math.abs(b.x - x) + Math.abs(b.y - y); // Manhattan distance
			h = Math.sqrt(Math.abs(b.x - x) * Math.abs(b.x - x) + Math.abs(b.y - y) * Math.abs(b.y - y)); // Euclidean distance
			
			return h;
		}
		
		public function equals(a:StarNode) : Boolean {
			return (a.x == this.x && a.y == this.y);
		}
		
		public function toString() : String {
			return "[StarNode (x: "+x+", y: "+y+", g: "+g+", h: "+h+", f:"+f+") "+name+"]";
		}
		
		public function distanceBetween(b:StarNode) : StarNode {
			return new StarNode(Math.abs(x - b.x), Math.abs(y - b.y));
		}
		
		public function duplicate() : StarNode {
			return new StarNode(x, y, g, h);
		}
		
		public function get coordinates() : Point {
			return new Point(Game.gameOffset.x + (x * Game.tileSize), Game.gameOffset.y + (y * Game.tileSize));
		}
		
		public function substract(a:StarNode) : StarNode {
			return new StarNode(x-a.x, y-a.y);
		}
		
		public function add(a:StarNode) : StarNode {
			return new StarNode(x+a.x, y+a.y);
		}
		
		public static function fromPoint(a:Point) : StarNode {
			return new StarNode(a.x, a.y);
		}
	}
}