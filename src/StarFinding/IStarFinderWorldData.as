package StarFinding {
	public interface IStarFinderWorldData {
		function checkForSolid(a:StarNode) : Boolean;
		function checkForWorldBounds(a:StarNode) : Boolean;
		function getStarNodeCost(a:StarNode) : Number;
	}
}