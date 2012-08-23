package Levels {
	public interface ILevel {
		function getSolidNodes() : Array;
		function getCheapNodes() : Array;
		function getBackground() : Class;
	}
}