package utils
{
	import flash.display.Sprite;
	
	import starling.core.Starling;

	public class NativeUtil
	{
		//you can add native sprite into nativeSpriteContainer 
		//not to use nativeSpriteContainer directly
		public static var nativeSpriteContainer:Sprite
		public function NativeUtil()
		{
			
		}
		
		public static function initNativeAssets():void{
			nativeSpriteContainer = Starling.current.nativeOverlay
		}
		
	}
}