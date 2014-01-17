package
{
	import flash.desktop.NativeApplication;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	
	import starling.core.Starling;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	import starling.utils.formatString;

	/**
	 *@author: wanghe
	 *@data: Nov 27, 2013
	 */
	
	public class Main extends Sprite
	{
		// Startup image for SD screens
		[Embed(source="assets/textures/background.png")]
		private static var Background:Class;
		
		[Embed(source="assets/assets01.xml", mimeType="application/octet-stream")]
		public static const AtlasXml_assets01:Class;
		[Embed(source="assets/assets01.tps", mimeType="application/octet-stream")]
		public static const AtlasTexture_assets01:Class;
	
		private var _Starling:Starling;
		public function Main()
		{
			super();

			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var iOS:Boolean = Capabilities.manufacturer.indexOf("iOS") != -1;
			Starling.multitouchEnabled = true;  // useful on mobile devices				
			Starling.handleLostContext = !iOS;  // not necessary on iOS. Saves a lot of memory!
			
			var viewPort:Rectangle = RectangleUtil.fit(
				new Rectangle(0, 0, SDContext.stageWidth, SDContext.stageHeight), 
				new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight), 
				ScaleMode.NONE, iOS);
			
			// create the AssetManager, which handles all required assets for this resolution
			
			var scaleFactor:int = viewPort.width < 480 ? 1 : 2; // midway between 320 and 640
			scaleFactor = 1
			var appDir:File = File.applicationDirectory;
			var assets:AssetManager = new AssetManager(scaleFactor);
			
			assets.verbose = Capabilities.isDebugger;
	
			assets.enqueue(
				appDir.resolvePath("assets/audio"),
				appDir.resolvePath(formatString("assets/fonts/{0}x", scaleFactor)),
				appDir.resolvePath(formatString("assets/textures/{0}x", scaleFactor)),
				appDir.resolvePath("assets/textures/others")
			);
			
			// While Stage3D is initializing, the screen will be blank. To avoid any flickering, 
			// we display a startup image now and remove it below, when Starling is ready to go.
			// This is especially useful on iOS, where "Default.png" (or a variant) is displayed
			// during Startup. You can create an absolute seamless startup that way.
			// 
			// These are the only embedded graphics in this app. We can't load them from disk,
			// because that can only be done asynchronously - i.e. flickering would return.
			// 
			// Note that we cannot embed "Default.png" (or its siblings), because any embedded
			// files will vanish from the application package, and those are picked up by the OS!
			
			var background:Bitmap = new Background();
			Background = null; // no longer needed!
			
			background.x = viewPort.x;
			background.y = viewPort.y;
			background.width  = viewPort.width;
			background.height = viewPort.height;
			background.smoothing = true;
			addChild(background);
			
			// launch Starling
			
			_Starling = new Starling(SiegeDuel, stage, viewPort);
			_Starling.stage.stageWidth  = SDContext.stageWidth;  // <- same size on all devices!
			_Starling.stage.stageHeight = SDContext.stageHeight; // <- same size on all devices!
			_Starling.simulateMultitouch  = true;
			_Starling.enableErrorChecking = false;
			
			_Starling.addEventListener(starling.events.Event.ROOT_CREATED, function():void
			{
				removeChild(background);
				
				var siegeDuel:SiegeDuel = _Starling.root as SiegeDuel;
				var bgTexture:Texture = Texture.fromBitmap(background, false, false, scaleFactor);
				
				siegeDuel.start(bgTexture, assets);
				_Starling.start();
			});
			
			// When the game becomes inactive, we pause Starling; otherwise, the enter frame event
			// would report a very long 'passedTime' when the app is reactivated. 
			
			NativeApplication.nativeApplication.addEventListener(
				flash.events.Event.ACTIVATE, function (e:*):void { _Starling.start(); });
			
			NativeApplication.nativeApplication.addEventListener(
				flash.events.Event.DEACTIVATE, function (e:*):void { _Starling.stop(); });
			
			
		}		
	}
}