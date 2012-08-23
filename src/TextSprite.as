package {
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.*;
	
	public class TextSprite extends Sprite {
		public var textbox:TextField     = new TextField();
		public var textFormat:TextFormat = new TextFormat();
		
		public function TextSprite(initText:String, position:Point, formatFlags:Object = null) {
			this.x 	   = position.x;
			this.y     = position.y;
			
			setText(initText);
			
			textFormat.font  = "arial";
			textFormat.size  = 35;
			textFormat.color = 0xffffff;
			textFormat.align = TextFormatAlign.LEFT;
			
			if (formatFlags != null) {
				for (var k:String in formatFlags) {
					textFormat[k] = formatFlags[k];
				}
			}


			
			textbox.setTextFormat(textFormat);
			textbox.antiAliasType = AntiAliasType.ADVANCED;
			
			//textbox.width = 100;
			
			textbox.autoSize      = TextFieldAutoSize.LEFT;
            addChild(textbox);
        }
		
		public function setText(text:String) : void {
			textbox.text = text;
			textbox.setTextFormat(textFormat);
		}
	}
}