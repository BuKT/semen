package semen.staff{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Mickodin Ilja mka BuKT
	 */
	public class Config {
		public static var eggsVelocity:Number = 1000;
		static public var newEggsFrequency:Number = 1500;
		static public var maximumTriesToAddEgg:Number = 10;
		static public var hareAppearingInterval:Number = 3000;
		static public var flushFailsScores:Array = [200, 500];
		static public var maxFailsPerGame:Number = 4;
		static public var pointsToSpeedUp:Number = 10;
		static public var eggsVelocityMultiplier:Number = .5;
		static public var newEggsMultiplier:Number = .5;
		static public var placeHoldersAlpha:Number = .1;
		static public var halfLifeInterval:Number = 500;
		static public var pausedScreenFlashingInterval:Number = 1000;
		static public var soundVolume:Number = .8;
        static public var musicVolume:Number = .3;
		static public var backgroundMusicLink:String = 'http://some.sound/url';
		static private var loadCallback:Function = null;
		
		
		public static function loadConfig(url:String, callback:Function):void {
			loadCallback =  callback;
			var loader:URLLoader= new URLLoader(new URLRequest(url));
			loader.addEventListener(Event.COMPLETE, setConfig);
			loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		}
		
		static private function ioErrorHandler(e:IOErrorEvent):void {
			trace(' === Config load failed === ');
			loadDone();
		}
		
		static private function setConfig(e:Event):void {
			var loadedXML:XML = XML(URLLoader(e.currentTarget).data);
			if (!loadedXML) {
				trace(' === Config load failed === ');
				loadDone();
				return;
			}
			var  variables:XML = loadedXML.config[0];
			eggsVelocity = Number(variables.velocity) ? Number(variables.velocity) : eggsVelocity;
			newEggsFrequency = Number(variables.appearNew) ? Number(variables.appearNew) : newEggsFrequency;
			maximumTriesToAddEgg = Number(variables.maximumTries) ? Number(variables.maximumTries) : maximumTriesToAddEgg;
			hareAppearingInterval = Number(variables.wifeAppearInterval) ? Number(variables.wifeAppearInterval) : hareAppearingInterval;
			flushFailsScores = variables.flushLifesEvery ? variables.flushLifesEvery.split(',') : flushFailsScores;
			maxFailsPerGame = int(variables.lifes)? int(variables.lifes) :maxFailsPerGame;
			pointsToSpeedUp = int(variables.pointsToSpeedUp) ? int(variables.pointsToSpeedUp) : pointsToSpeedUp;
			eggsVelocityMultiplier = Number(variables.velocityMultiplier) ? Number(variables.velocityMultiplier) / 100 : eggsVelocityMultiplier ;
			newEggsMultiplier = Number(variables.appearNewMultiplier) ? Number(variables.appearNewMultiplier) / 100 : newEggsMultiplier ;
			placeHoldersAlpha = Number(variables.placeHoldersAlpha) ? Number(variables.placeHoldersAlpha) / 100 : placeHoldersAlpha;
			halfLifeInterval = Number(variables.halfLifeInterval) ? Number(variables.halfLifeInterval) : halfLifeInterval;
			pausedScreenFlashingInterval = Number(variables.pausedScreenFlashingInterval) ? Number(variables.pausedScreenFlashingInterval) : pausedScreenFlashingInterval;
			soundVolume = !isNaN(Number(variables.soundVolume)) ? Number(variables.soundVolume) / 100 : soundVolume;
            musicVolume = !isNaN(Number(variables.musicVolume)) ? Number(variables.musicVolume) / 100 : musicVolume;
			backgroundMusicLink = variables.backgroundMusicLink ? variables.backgroundMusicLink : backgroundMusicLink;
			trace(' === Config load done === ');
			loadDone();
		}
		
		static private function loadDone():void {
			loadCallback.apply();
			loadCallback = null;
		}
	}
	
	
}