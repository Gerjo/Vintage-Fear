package Objects {
	import flash.geom.Point;
	import Layers.BaseLayer;
	import StarFinding.StarNode;
	
	public class TextCloud extends BaseObject {
		private var fadeTimer:Number = 0;
		private var text:TextSprite	 = new TextSprite("", new Point(0, 0), { size:10 } );
		
		public function TextCloud(owner:Game, where:StarNode, text:String = "Text Box", color:uint = 0xffffff) {
			super(owner, where.x, where.y);
			
			
			this.text.textFormat.color = color;
			this.text.setText(text);
			addChild(this.text);
			alpha = 1;
		}	
		
		public override function update(timeDifference:Number) : void {
			text.y--;
			text.alpha -= 0.02;
			
			if (text.alpha < 0) deleteMe = true;
		}
	}
}