package Layers {
	import StarFinding.StarNode;
	public class FogCloud extends BaseLayer {
		public static var SOLID:int = 0;
		public static var SIDE:int  = 1;
		public static var ANGLE:int = 2;
		
		public var addedToPokedList:Boolean = false;
		public var starnode:StarNode;
		public var isSolid:Boolean = true;
		public function FogCloud(x:int, y:int, starnode:StarNode) {
			super(null, false);
			this.starnode 	= starnode;
			this.x   		= x;
			this.y 			= y;

			showSolid();
		}
		
		
		public function showSolid(angle:int = 0) : void {
			loadBitmap(Assets.SOLIDCLOUD);
			image.rotation = angle;
			isSolid = true;
		}
		
		public function showAngle(angle:int = 0) : void {
			loadBitmap(Assets.ANGLECLOUD);
			image.rotation = angle;
			isSolid = false;
		}
		
		public function showSide(angle:int = 0) : void {
			loadBitmap(Assets.SIDECLOUD);
			image.rotation = angle;
			isSolid = false;
		}
	}
}