package Layers {
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.geom.Point;
	
	public class BaseLayer extends Sprite {
		protected var owner:Game			= null;
		protected var bitmap:Bitmap			= null;
		protected var bitmapHolder:Sprite	= null;
		protected var _image:Sprite			= null;
		protected var bitmapMask:Sprite		= null;
		protected var spriteOffset:Point    = new Point(0, 0);
		protected var _deleteMe:Boolean		= false;
		
		public function BaseLayer(owner:Game, addToWorldAsChild:Boolean = true) {
			this.owner = owner;
			if(addToWorldAsChild) owner.addChild(this);
		}
		
		public function loadBitmap(data:Class, position:String = "center", spriteOffset:Point = null) : void {
			
			if(numChildren > 0) removeChildAt(0);
			
			bitmapHolder 	= new Sprite();
			bitmap 			= new data as Bitmap;
			
			bitmapHolder.addChild(bitmap);
			
			switch(position) {
				case "custom":
					_image			  = new Sprite();
					this.spriteOffset = spriteOffset;
					bitmap.x = spriteOffset.x;
					bitmap.y = spriteOffset.y;
					
					image.x = 10;
					image.y = 10;
					break;
				case "center":
					bitmapHolder.x = bitmap.width / 2;
					bitmapHolder.y = bitmap.height / 2;
					
					bitmap.x = -bitmapHolder.x;
					bitmap.y = -bitmapHolder.y;
					
					break;
				default:
			}
			
			if (_image == null) {
				addChild(bitmapHolder);
			} else {
				image.addChild(bitmapHolder);
				addChild(image);
			}
		}
		
		public function get deleteMe() : Boolean {
			return _deleteMe;
		}
		
		public function set deleteMe(v:Boolean) : void {
			_deleteMe = v;
		}
		
		public function get image() : Sprite {
			if(_image != null) return _image;
			return bitmapHolder;
		}
		
		public function update(timeDifference:Number) : void {
			
		}
	}
}