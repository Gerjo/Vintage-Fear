package  {
	import flash.display.Graphics;
	import flash.geom.Point;
	public class Tile {
		protected var index:Point;
		protected var position:Point;
		public    var isSolid:Boolean  = false;
		public    var isMarked:Boolean = false;
		
		public function Tile(index:Point) {
			this.index    = index;
			this.position = new Point(index.x * Game.tileSize, index.y * Game.tileSize);
		}
		public function draw(g:Graphics, color:uint = 0x000000, opacity:Number = .1) : void {
			g.beginFill(0, 0);
			g.lineStyle(1, color, opacity);
			g.drawRect(Game.gameOffset.x+position.x, Game.gameOffset.y+position.y, Game.tileSize, Game.tileSize);
			g.endFill();
		}
		
		public function mark(g:Graphics) : void {
			isMarked = true;
			draw(g, 0xff0000, 1);
			
			//isMarked = !isMarked;
		}
	}
}