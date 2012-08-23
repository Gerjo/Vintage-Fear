package Base {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.events.Event;
	
	// This class should only be used as a place holder.
	public class ImageSprite extends Sprite {
		private var imageURL:String;
		private var _posOffset:Point;
		private var _angleOffset:Number;
		private var sprite:DisplayObject = null;
		private var spriteLoader:Loader  = new Loader();
		private var lastUsedURL:String   = null;
		
		public function ImageSprite(imageURL:String, _posOffset:Point, _angleOffset:Number = 0) {
			this.imageURL     = imageURL;
			this._posOffset   = _posOffset;
			this._angleOffset = _angleOffset;
			
			loadSprite(imageURL);
		}
		
		public function showCenter() : void {
			graphics.lineStyle(10, 0x8f00aa);
			graphics.drawRect(-5, -5, 1, 1);
		}
	
		public function loadSprite(url:String) : void {
			if (lastUsedURL == url) return;
			lastUsedURL = url;
			
			var spriteURLReq:URLRequest = new URLRequest(url);
			
			spriteLoader = new Loader();
			spriteLoader.load(spriteURLReq);
				
			spriteLoader.x = _posOffset.x;
			spriteLoader.y = _posOffset.y;
				
			spriteLoader.rotation = _angleOffset;
			
			if (sprite != null) removeChild(sprite);
			
			addChild(spriteLoader);
			
			sprite = spriteLoader;
		}
		
		public function get posOffset() : Point {
			return _posOffset;
		}
		
		public function set posOffset(value:Point) : void {
			_posOffset = value;
		}
	}
}