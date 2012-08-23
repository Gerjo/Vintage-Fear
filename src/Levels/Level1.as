package Levels {
	public class Level1 implements ILevel {	

		public function getBackground() : Class {
			return Assets.LEVEL1BACKGROUND;
		}
		 
		public function getCheapNodes() : Array {
			var arr:Array = new Array();
			for (var x:int = 0; x < Game.tileCount.x; ++x) {
				arr[x] = new Array();
				for (var y:int = 0; y < Game.tileCount.y; ++y) {
					arr[x][y] = 1; // default tile score
				}
			}
			var s:int = .1;
			return arr;
		}
		
		public function getSolidNodes() : Array {
			var arr:Array = new Array();
			for (var x:int = 0; x < Game.tileCount.x; ++x) {
				arr[x] = new Array();
				for (var y:int = 0; y < Game.tileCount.y; ++y) {
					arr[x][y] = false; // default tile score
				}
			}
			arr[0][0] = true;arr[0][1] = true;arr[0][2] = true;arr[0][3] = true;arr[0][4] = true;arr[0][5] = true;arr[0][6] = true;arr[0][7] = true;arr[0][8] = true;arr[0][9] = true;arr[0][10] = true;arr[0][11] = true;arr[0][12] = true;arr[0][13] = true;arr[0][14] = true;arr[0][15] = true;arr[0][16] = true;arr[0][17] = true;arr[0][18] = true;arr[0][19] = true;arr[0][20] = true;arr[0][21] = true;arr[0][22] = true;arr[0][23] = true;arr[0][24] = true;arr[0][25] = true;arr[0][26] = true;arr[0][27] = true;arr[1][0] = true;arr[1][12] = true;arr[1][27] = true;arr[2][0] = true;arr[2][27] = true;arr[3][0] = true;arr[3][12] = true;arr[3][27] = true;arr[4][0] = true;arr[4][12] = true;arr[4][27] = true;arr[5][0] = true;arr[5][12] = true;arr[5][27] = true;arr[6][0] = true;arr[6][12] = true;arr[6][27] = true;arr[7][0] = true;arr[7][12] = true;arr[7][27] = true;arr[8][0] = true;arr[8][12] = true;arr[8][27] = true;arr[9][0] = true;arr[9][12] = true;arr[9][27] = true;arr[10][0] = true;arr[10][12] = true;arr[10][27] = true;arr[11][0] = true;arr[11][12] = true;arr[11][27] = true;arr[12][0] = true;arr[12][7] = true;arr[12][8] = true;arr[12][9] = true;arr[12][10] = true;arr[12][11] = true;arr[12][12] = true;arr[12][13] = true;arr[12][14] = true;arr[12][16] = true;arr[12][17] = true;arr[12][18] = true;arr[12][19] = true;arr[12][20] = true;arr[12][21] = true;arr[12][22] = true;arr[12][23] = true;arr[12][25] = true;arr[12][26] = true;arr[12][27] = true;arr[13][0] = true;arr[13][27] = true;arr[14][0] = true;arr[14][27] = true;arr[15][0] = true;arr[15][27] = true;arr[16][0] = true;arr[16][27] = true;arr[17][0] = true;arr[17][27] = true;arr[18][0] = true;arr[18][27] = true;arr[19][0] = true;arr[19][27] = true;arr[20][0] = true;arr[20][27] = true;arr[21][0] = true;arr[21][9] = true;arr[21][10] = true;arr[21][11] = true;arr[21][13] = true;arr[21][14] = true;arr[21][15] = true;arr[21][16] = true;arr[21][17] = true;arr[21][19] = true;arr[21][20] = true;arr[21][21] = true;arr[21][22] = true;arr[21][23] = true;arr[21][25] = true;arr[21][26] = true;arr[21][27] = true;arr[22][0] = true;arr[22][9] = true;arr[22][15] = true;arr[22][21] = true;arr[22][27] = true;arr[23][0] = true;arr[23][9] = true;arr[23][15] = true;arr[23][21] = true;arr[23][27] = true;arr[24][0] = true;arr[24][9] = true;arr[24][15] = true;arr[24][21] = true;arr[24][27] = true;arr[25][0] = true;arr[25][9] = true;arr[25][15] = true;arr[25][21] = true;arr[25][27] = true;arr[26][0] = true;arr[26][9] = true;arr[26][15] = true;arr[26][21] = true;arr[26][27] = true;arr[27][0] = true;arr[27][9] = true;arr[27][15] = true;arr[27][21] = true;arr[27][27] = true;arr[28][0] = true;arr[28][9] = true;arr[28][15] = true;arr[28][21] = true;arr[28][27] = true;arr[29][0] = true;arr[29][9] = true;arr[29][27] = true;arr[30][0] = true;arr[30][9] = true;arr[30][15] = true;arr[30][21] = true;arr[30][27] = true;arr[31][0] = true;arr[31][9] = true;arr[31][15] = true;arr[31][21] = true;arr[31][27] = true;arr[32][0] = true;arr[32][9] = true;arr[32][15] = true;arr[32][21] = true;arr[32][27] = true;arr[33][0] = true;arr[33][1] = true;arr[33][2] = true;arr[33][3] = true;arr[33][4] = true;arr[33][5] = true;arr[33][6] = true;arr[33][7] = true;arr[33][8] = true;arr[33][9] = true;arr[33][10] = true;arr[33][11] = true;arr[33][12] = true;arr[33][13] = true;arr[33][14] = true;arr[33][15] = true;arr[33][16] = true;arr[33][17] = true;arr[33][18] = true;arr[33][19] = true;arr[33][20] = true;arr[33][21] = true;arr[33][22] = true;arr[33][23] = true;arr[33][24] = true;arr[33][25] = true;arr[33][26] = true;arr[33][27] = true;
			arr[12][0] = true;arr[12][1] = true;arr[12][2] = true;arr[12][3] = true;arr[12][4] = true;arr[12][5] = true;
			return arr;
		}
	}
}