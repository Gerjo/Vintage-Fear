package  {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.events.Event;
	import Layers.*;
	import flash.ui.Mouse; //Mouse.hide();
	import flash.events.KeyboardEvent;
	import Levels.*;
	import StarFinding.*;
	import Objects.*;
	import flash.external.ExternalInterface;


	public class Game extends Sprite implements IStarFinderWorldData {
		public static const gameSize:Point   = new Point(500, 420);
		public static const worldSize:Point  = new Point(600, 400);
		public static const tileSize:int     = 15;
		public static const tileCount:Point  = new Point(gameSize.x/tileSize, gameSize.y/tileSize);
		public static const gameOffset:Point = new Point(150, 90); // trace(new Point(background.width  / 2 - world.width  / 2, background.height / 2 - world.height / 2));
		
		// Internal variables:
		private var lastTime:Number		= new Date().time;
		private var tileItems:Array;
		public  var sound:SoundController;
		public  var gamestate:int 		= GameStates.MAINMENU;
		
		// Game layers:
		public  var background:Background;
		public  var pictureFrame:PictureFrame;
		public  var world:World;
		public  var grid:Grid;
		public  var hud:Hud;
		public  var tophud:TopHud;
		public  var flash:Flash;
		public  var gameLayer:GameLayer;
		public  var fogOfWar:FogOfWar;
		public  var menu:Menu;
		
		// Data used for Starfinding:
		public  var solidNodes:Array; 
		public  var cheapNodes:Array; 
		
		// Other Objects;
		public  var player:Player;
		public  var crosshairDestination:CrosshairDestination;
		
		// Level settings:
		private var currentLevel:ILevel = null;
		private var levels:Array		= new Array();
		
		public function Game() {
			// Declare all available levels:
			levels[0] = new Level1();
			
			// Link the first level:
			currentLevel = levels[0];
			
			tileItems    = new Array();
			// So instead of hit testing everything against everything, objects are placed on a grid. Each time an object moves
			// it is removed from the grid, and placed back on the grid at its new location. This means for a hittest,
			// we only need to test the surrounding tiles, or objects at said tile.
			
			
			world		 = new World(this);
			grid		 = new Grid(this);
			gameLayer    = new GameLayer(this);
			
			player       = new Player(this, 20, 20);
			
			world.x      = gameOffset.x;
			world.y      = gameOffset.y;
			
			fogOfWar     = new FogOfWar(this);
			hud			 = new Hud(this);
			menu         = new Menu(this);
			flash		 = new Flash(this);
			pictureFrame = new PictureFrame(this);
			tophud		 = new TopHud(this);
			sound        = new SoundController();
			
			
			crosshairDestination = new CrosshairDestination(this);
			
			
			
			//flash.show();
			menu.showStartGame();
		}
		
		public function resetTileItems() : void {
			for (var i:int = 0; i < tileCount.x + tileCount.x * tileCount.y; ++i) {
				tileItems[i] = new Array();
			}
		}
		
		public function startGame() : void {
			if (gamestate != GameStates.MAINMENU) return;
			resetTileItems();
			
			world.loadBitmap(currentLevel.getBackground());
			solidNodes  = currentLevel.getSolidNodes();
			
			while (gameLayer.numChildren > 0) {
				gameLayer.removeChildAt(0);
			}
			player.reset();
			fogOfWar.reset();
			gameLayer.addChild(player);
			
			spawnZombies(1);
		}
		
		public function onRightClick():void {
            var mx:int = stage.mouseX;
            var my:int = stage.mouseY;
 
            if(my > 0 && my < stage.stageHeight && mx > 0 && mx < stage.stageWidth) {
                if (gamestate == GameStates.PLAYING) {
					player.shoot(new flash.geom.Point(mx, my));
				}
            }
        }

		public function spawnZombies(qty:int = 10) : void {
			for (var i:int = 0; i < qty; ) {
				var loc:StarNode = new StarNode(Toolkit.random(0, Game.tileCount.x-1), Toolkit.random(0, Game.tileCount.y-1));
				//trace(loc);
				if (checkForSolid(loc) == false && checkForWorldBounds(loc) == false) {
					
					gameLayer.addChild(new Zombie(this, loc));
					++i;
				}
			}
		}
		
		public function showInto() : void {
			
		}
		
		public function onEnterFrame(e:Event) : void {
			var currentTime:Number    = new Date().time;
			var timeDifference:Number = currentTime - lastTime;
			lastTime                  = currentTime;
			
			grid.reset();
			//trace("--");
			for (var k:int = 0; k < tileItems.length; ++k) {
				if (tileItems[k].length > 0) {
					for (var l:int = 0; l < tileItems[k].length; ++l) {
						grid.highlightTile((tileItems[k][l] as BaseObject).getNodeLocation());
						//trace(tileItems[k][l]);
					}
				}
			}
			
			for (var i:int = 0; i < numChildren; ++i) {
				(getChildAt(i) as BaseLayer).update(timeDifference);
				
				// To do: store pointers in array then delete objects after this loop has completed.
				if ((getChildAt(i) as BaseLayer).deleteMe) {
					removeChildAt(i);
					trace("Deleted from base: ", getChildAt(i));
					
					if (i > 0) --i;
				}
			}
			
			if (player.health <= 0 && gamestate != GameStates.MAINMENU) {
				//menu.showRipGame();
			}
			
			if (!(gamestate == GameStates.PLAYING)) {
				return;
			}
			
			var deleteAbles:Array = new Array();
			for (var j:int = 0; j < gameLayer.numChildren; ++j) {
				var obj:BaseObject = gameLayer.getChildAt(j) as BaseObject;
				obj.update(timeDifference);
				
				if(!(obj is Gore)) {
					if (fogOfWar.getVisibiltyAt(obj.getNodeLocation()) == true) {
						obj.alpha = 1;
					} else {
						obj.alpha = 0;
					}
				}
				
				try {
				//trace(fogOfWar.getVisibiltyAt(obj.getNodeLocation()), fogOfWar.getCloudAt(obj.getNodeLocation()).alpha);
				} catch(e:Error){}
				// To do: store pointers in array then delete objects after this loop has completed.
				if (obj.deleteMe) {
					trace("Deleted from game: ", obj);
					gameLayer.removeChildAt(j);
					deleteTileItem(obj);
					if (j > 0) --j;
					
				}
			}
		}
		
		public function onMouseMove(e:MouseEvent) : void {
			//grid.onMouseMove(e);
		}
		
		public function onKeyDown(e:KeyboardEvent) : void {
			switch(e.keyCode) {
				case 32:
					if (gamestate == GameStates.PLAYING) {
						player.shoot(new flash.geom.Point(mouseX, mouseY));
					}
					//trace(tileItems);
					break;
				case 13:
					spawnZombies(1);
					break;
			}			
		}
		
		public function onMouseDown(e:MouseEvent) : void {
			player.onMouseDown(e);
		}
		
		// Method required for StarFinding.
		public function getStarNodeCost(a:StarNode) : Number {
			try { return cheapNodes[a.x][a.y]; } catch (e:Error) { }
			return 1;
		}
		
		// Method required for StarFinding.
		public function checkForSolid(a:StarNode) : Boolean {
			try {
				return solidNodes[a.x][a.y];
			} catch (e:Error) {
				trace("check for solid error. StarNode out of bounds: ", a);
			}
			return true;
		}
		
		// Method required for StarFinding.
		public function checkForWorldBounds(a:StarNode) : Boolean {
			if (a.x < 0 || a.y < 0 || a.x > Game.tileCount.x || a.y > Game.tileCount.y) {
				return true;
			}
			return false;
		}
		
		public function getTileItemsAt(index:Object) : Array {
			try {
				if (index is StarNode) {
					return tileItems[((index as StarNode).x + (index as StarNode).y * (index as StarNode).x)];
				}
				
				return tileItems[index as int];
			} catch (e:Error) { }
			
			return new Array();
		}
		
		public function getTileItemsAround(node:StarNode) : Array {
			var buffer:Array = new Array();
			buffer = buffer.concat(getTileItemsAt((node.x - 1) +  node.y *  (node.x - 1)));
			buffer = buffer.concat(getTileItemsAt((node.x + 1) +  node.y *  (node.x + 1)));
			buffer = buffer.concat(getTileItemsAt(node.x + (node.y + 1) *  node.x));
			buffer = buffer.concat(getTileItemsAt(node.x + (node.y - 1) *  node.x));	
		
			return buffer;
		}
		
		public function deleteTileItem(object:BaseObject) : void {
			if (object.tileIndex < 0) return;
			for (var i:int = 0; i < tileItems[object.tileIndex].length; ++i) { // Remove the object form the previous tile.
				if (tileItems[object.tileIndex][i] == object) {
					//trace("removed item!");
					//new Gore(this, object.getNodeLocation());
					tileItems[object.tileIndex].splice(i, 1);
				}
			}
		}
		
		public function registerTileItem(object:BaseObject) : Number {
			if (object is Gore || object is TextCloud) return 0;
			
			var location:StarNode = object.getNodeLocation();
			var newIndex:Number   = location.x + location.y * location.x; // important formula
			var oldIndex:Number   = object.tileIndex;
			
			
			
			if (tileItems.length > newIndex) {
				if(newIndex != oldIndex) { // The object is not in the array yet, or has moved since the last update.
					//trace('----', object, ' arrives at a tile. running hit test: ');
					for (var j:int = 0; j < tileItems[newIndex].length; ++j) {
						if(object.getRectangle().intersects(tileItems[newIndex][j].getRectangle())){
							if (object.deleteMe == false &&  tileItems[newIndex][j].deleteMe == false) {
								// Dispatch the onCollision event:
								tileItems[newIndex][j].onCollision(object);
								object.onCollision(tileItems[newIndex][j]);
								
								trace(object , " collision with ", tileItems[newIndex][j]);
							}
						}
					}
					
					//trace(tileItems);
					if(oldIndex >= 0) {
						deleteTileItem(object);
						//trace("deleting index");
					} 
					
					
					tileItems[newIndex].push(object); // Push the object into this tile.
					/*
					// run some debug (this should highlight any items in the array:
					for (var k:int = 0; k < tileItems.length; ++k ) {
						if (tileItems[k].length > 0) {
							//trace("At tile (", k, "):", tileItems[k]);
						}
					}	*/
					//trace();
				}
			}
			
			object.tileIndex      = newIndex;
			return newIndex;
		}
	}
}