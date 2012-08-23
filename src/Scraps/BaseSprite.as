package Base {
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import Engine2D.*;
	
	// Base class on which any sprite extends upon.
	public class BaseSprite extends Sprite implements ICollision2D{
		protected var _owner:Game;
		protected var imageSprite:ImageSprite   = null;
		protected var polygon:Polygon2D         = null;
		protected var boundingbox:BoundingBox2D = null;
		protected var circle:Circle2D           = null;
		protected var timestamp:Number			= 0;
		protected var velocity:Vector2D			= null;
		protected var _forceDestroyed:Boolean	= false;
		protected var scale:Number				= 1;
		
		public function BaseSprite(owner:Game) {
			this.owner = owner;
		}
		
		// Ready to be overriden:
		public function update(difference:Number = -1) : void {			
			
		}
		
		// Lets us easily load a single imageSprite:
		public function loadImageSprite(imageSprite:ImageSprite) : void {
			this.imageSprite = imageSprite;
			addChild(imageSprite);
		}
		
		public function onKeyDown(e:KeyboardEvent) : void {
			
		}
		
		public function setLocation(vector:Vector2D) : void {
			x = vector.x;
			y = vector.y;
		}
		
		public function getLocation() : Vector2D {
			return new Vector2D(x, y);
		}
		
		public function addLocation(vector:Vector2D) : void {
			x += vector.x;
			y += vector.y;
		}
		
		public function getScale() : Number {
			return scale;
		}
		
		public function getPolygon2D() : Polygon2D {
			polygon.translate = getLocation();
			polygon.scale     = getScale();
			return polygon;
		}
		
		public function onCollision(object:BaseSprite, location:Vector2D = null) : void {
			
		}
		
		public function getBoundingBox2D() : BoundingBox2D {
			var correctX:int = width / 2;
			var correctY:int = height / 2;
			
			return new BoundingBox2D(x-correctX, x+width-correctX, y-correctY, y+height-correctY);
		}
		
		public function get owner() : Game {
			return _owner;
		}
		
		public function set owner(value:Game) : void {
			_owner = value;
		}

		public function getCircle2D() : Circle2D {
			return circle;
		} 
		
		public function isDestroyed() : Boolean {
			if (forceDestroyed) return true;
			return (x < -100) ? true:false;
		}
		
		public function set forceDestroyed(value:Boolean) : void {
			_forceDestroyed = value;
		}
		
		public function get forceDestroyed() : Boolean {
			return _forceDestroyed;
		}
		
		public function onRemove() : void {
			// concept function.
		}
	}
}