package {
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	public class SoundController {
		private var soundChannel:SoundChannel = null;
		private var playerFireSound:Sound   = new SoundAssets.PLAYERFIRE;
		private var zombieHitSound:Sound    = new SoundAssets.ZOMBIEHIT;
		private var playerHitSound:Sound    = new SoundAssets.PLAYERHIT;
		
		public function SoundController() {
			
		}
		
		public function gunShot() : void {
			//soundChannel = playerFireSound.play(0, 0);
		}
		
		public function zombieHit() : void {
			//soundChannel = zombieHitSound.play(0, 0);
		}
		
		public function playerHit() : void {
			//soundChannel = playerHitSound.play(0, 0);
		}
	}
}