package StarFinding {
	public class StarErrorImpossibleRoute extends Error{
		public function StarErrorImpossibleRoute(){
			super("Unable to find a path towards to goal.");
		}	
	}
}