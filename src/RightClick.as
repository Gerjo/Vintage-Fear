package {
    import flash.display.*;
    import flash.external.ExternalInterface;
 
    public class RightClick extends Sprite {
	    	private var owner:Game;    
	
        public function RightClick(owner:Game)
        {
			this.owner = owner;
            //stage.scaleMode = StageScaleMode.NO_SCALE;
            //stage.align = StageAlign.TOP_LEFT;
           
            var methodName:String = "rightClick";
            var method:Function = onRightClick;
            ExternalInterface.addCallback(methodName, method);
        }
       
        private function onRightClick():void {
 			owner.flash.show();
            var mx:int = stage.mouseX;
            var my:int = stage.mouseY;
 
            if(my> 0 && my <stage.stageHeight && mx> 0 && mx <stage.stageWidth) {
                // YOUR CODE HERE
            }
        }
    }
}