package StarFinding {
	public class StarFinder {
		public static var INSTANCE:StarFinder = null;
		public static var DURATION:Number     = -1;
		
		public static function getInstance() : StarFinder {
			if (INSTANCE == null) INSTANCE = new StarFinder();
			return INSTANCE;
		}
		
		private var startNode:StarNode;
		private var goalNode:StarNode;
			
		private var fail:Array ;
		private var open:Array; 
		private var closed:Array;
		
		private var overflowPrevention:int = 0;
		
		private var worldData:IStarFinderWorldData;
		
		public function StarFinder() : void {
			
		}
		
		
		public function createPath(worldData:IStarFinderWorldData, from:StarNode, to:StarNode) : Array {
			overflowPrevention = 0;
			fail       = new Array();
			open       = new Array();
			closed     = new Array();
			startNode  = from;
			goalNode   = to;
			this.worldData = worldData;
			
			open.push(from);
			
			if (worldData.checkForWorldBounds(to) == true || worldData.checkForSolid(to) == true) {
				throw new StarErrorImpossibleRoute();
			}
			
			var now:Number = new Date().time;
			pathTo(goalNode, fail, open, closed);
			DURATION = new Date().time - now;
			
			return (open[0].toArray() as Array).reverse();
		}
		
		public function pathTo(goal:StarNode, fail:Array, open:Array, closed:Array) : void {
			if (++overflowPrevention > 700) { trace("pathTo stack overflow. open[0]:",open[0]); return; }
			var debug:Boolean = false;
			if(debug) trace();
			if(debug) trace("=========== NEW ===========");
			//unHighlightGrid();
			
			// Re sort the array so the "best" open item comes first:
			// Todo: We only need the lowest value, so sorting is overkill.
			//open.sortOn("f", Array.NUMERIC);			
			
			var lowestFNode:StarNode;
			var lowestFNodeIndex:Number = 0;
			var tempNode:StarNode;
			for (var k:int = 0; k < open.length; ++k) {
				if (open[k] != null && (lowestFNode == null || lowestFNode.f > open[k].f)) {
					lowestFNode = open[k];
					lowestFNodeIndex = k;
				}
			}
			
			tempNode               = open[0];
			open[0] 			   = lowestFNode;
			open[lowestFNodeIndex] = tempNode;
			
			var currentNode:StarNode = open[0];
			
			if (open.length == 0 || currentNode == null) {
				throw new StarErrorImpossibleRoute();
				return;
			}

			if (currentNode.equals(goal)) {
				return;
			}
			
			// Array of all posible nodes:
			var starNodes:Array   = getStarNodesAround(open[0], goal, open[0].g);
			var goodNode:StarNode = null;
			
			//trace("-- TESTING: --");
			// Itarate over all possible nodes and find the "best" one:
			for (var i:int = 0; i < starNodes.length; ++i) {
				var allOK:Boolean = true;
				//trace("opt: ", starNodes[i].direction);
				for (var j:int = 0; j < starNodes[i].options.length; ++j) {
					//if(goodNode == null) {
					//	(worldData as Game).grid.highlightTile(starNodes[i].options[j]);
					//}
					if (worldData.checkForWorldBounds(starNodes[i].options[j]) == false) {
						if (worldData.checkForSolid(starNodes[i].options[j]) == false) {
							if(currentNode.previous == null || !currentNode.previous.equals(starNodes[i].options[j])) {
								if(checkForInPath(starNodes[i].options[j], closed) == false) {
									//getTileAt(starNodes[i]).pushNode(starNodes[i]);
									
									
								} else { allOK = false; break; }
							} else { allOK = false; break; }
						} else { allOK = false; break; }
					} else { allOK = false; break; }
				}
				
				if (allOK) {
					//trace("all OK");
					if (goodNode == null) {
										
						goodNode          = starNodes[i].direction;
						goodNode.previous = currentNode;
						open[0] = goodNode;
						
						if(debug) trace(goodNode, " new good node");
							
						closed.push(goodNode);
						
					} else {
						// Add this node to "open" collection:		
						starNodes[i].direction.previous = open[0];
						open.push(starNodes[i].direction);
					}
				}
			}

			// No further moves are possible:
			if (goodNode == null) {
				// Add this node to a failed array so it wont be stepped upon again:
				//fail.push(open[0]);
				open[0] = null;
				//open[0] = open[0].previous;
				//open.shift();
				if(debug) trace("No good nodes found.");
				// Attempt the path again from the last known "correct" node:
				pathTo(goal, fail, open, closed);
			} else {
				// Continue finding a path from the next node:
				pathTo(goal, fail, open, closed);
			}
		}
					
		public function checkForMovingBackwards(a:StarNode, path:Array) : Boolean {
			return !(path.length < 2 || !path[path.length - 2].equals(a));
		}
		
		public function checkForInPath(a:StarNode, failed:Array) : Boolean {
			for (var i:int = 0; i < failed.length; ++i) {
				if (failed[i].equals(a)) return true;
			}
			return false;
		}
		
		public function getStarNodesAround(a:StarNode, b:StarNode, g:int) : Array {
			
			
			var enableSideway:Boolean = true;
			
			// Build an array with all walkable directions:
			var directions:Array = new Array();
			directions[0] = new StarNode(a.x + 0, a.y - 1, g, 0, "left"); // left
			directions[1] = new StarNode(a.x + 0, a.y + 1, g, 0, "right"); // right
			directions[2] = new StarNode(a.x - 1, a.y + 0, g, 0, "up"); // up
			directions[3] = new StarNode(a.x + 1, a.y + 0, g, 0, "down"); // down
			
			if(enableSideway) {
				directions[4] = new StarNode(a.x + 1, a.y + 1, g, 0, "right down"); // right down
				directions[5] = new StarNode(a.x - 1, a.y + 1, g, 0, "left down"); // left down
				directions[6] = new StarNode(a.x - 1, a.y - 1, g, 0, "left up"); // left up
				directions[7] = new StarNode(a.x + 1, a.y - 1, g, 0, "right up"); // right up
			}
			var nodes:Array = new Array();
			nodes[0] = new Array();
			nodes[1] = new Array();
			nodes[2] = new Array();
			nodes[3] = new Array();
			
			if(enableSideway) {
				nodes[4] = new Array();
				nodes[5] = new Array();
				nodes[6] = new Array();
				nodes[7] = new Array();
			}
			var size:int     = 1;
			
			for (var j:int = 0; j < size; ++j) {
				nodes[0].push(new StarNode(a.x + j, a.y - 1));    // left
				nodes[1].push(new StarNode(a.x + j, a.y + size)); // right
				nodes[2].push(new StarNode(a.x - 1, a.y + j));    // up
				nodes[3].push(new StarNode(a.x + size, a.y + j)); // down
			}
			
			if(enableSideway) {
				nodes[4] = nodes[3].concat(nodes[1]); // right down
				nodes[5] = nodes[0].concat(nodes[3]); // left down
				nodes[6] = nodes[0].concat(nodes[2]); // left up
				nodes[7] = nodes[1].concat(nodes[2]); // right up
				
				nodes[4].push(new StarNode(a.x+size, a.y+size)); // right down
				nodes[5].push(new StarNode(a.x-1, a.y+size)); // left down
				nodes[6].push(new StarNode(a.x-1, a.y-1)); // left up
				nodes[7].push(new StarNode(a.x+size, a.y-1)); // right up
			}
			
			var sortTest:Array = new Array();
			for (var k:int = 0; k < nodes.length; ++k) {
				sortTest[k]              = new Object();
				directions[k].g         += worldData.getStarNodeCost(directions[k]);
				sortTest[k]["f"]         = directions[k].calculateHeuristics(b);
				sortTest[k]["options"]   = nodes[k];
				sortTest[k]["direction"] = directions[k];
			}
			
			
			// Sort the nodes by heuristics score:
			sortTest.sortOn("f", Array.NUMERIC);
			return sortTest;
		}
	}
}