package {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	public class Toolkit {
		public static function random(min:int, max:int) : int {
			return min + (Math.random() * (max + 1 - min));
		}
		
		public static function array_rand(collection:Array) : String {
			return collection[random(0, collection.length-1)].toString();
		}
		
		public static function array_remove(array:Array, index:int) : Array {
			if (index < 0) return array;
			if (index > array.length) return array;
			if (index == 0) { array.shift(); return array; }
			if(index == array.length) { array.pop(); return array; }
			return array.slice(0, index).concat(array.slice(index+1));
		}
		
		public static function rtrim(subject:String, remove:String) : String {
			while (subject.substr(subject.length - remove.length, remove.length) == remove) {
				subject = subject.substr(0, subject.length - remove.length);
			}
			return subject;
		}
		
		public static function printFamilyTree(base:Sprite, dept:int = 0) : void {
			var offset:String = "";
			for (var j:int = 0; j < dept; ++j) {
				offset += "   ";
			}
						
			for (var i:int = 0; i < base.numChildren; ++i) {
				trace(offset + i + " " + base.getChildAt(i));
				
				if(base.getChildAt(i) is Sprite) {
					if ((base.getChildAt(i) as Sprite).numChildren > 0) {
						printFamilyTree(base.getChildAt(i) as Sprite, dept+1);
						
						//trace(offset + i + " " + base.getChildAt(i));
					}
				}
			}
		}
	}
}