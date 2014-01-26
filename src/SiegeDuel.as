package
{
	import flash.ui.Keyboard;
	import flash.utils.getDefinitionByName;
	
	import feathers.themes.MetalWorksMobileTheme;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	
	import utils.ProgressBar;
	
	import view.scenes.Scene;
	
	/**
	 *@author: wanghe
	 *@data: Nov 27, 2013
	 */
	
	public class SiegeDuel extends Sprite
	{
		private static var sAssets:AssetManager;
		private var mLoadingProgress:ProgressBar;
		private var mMainMenu:MainMenu;
		private var mCurrentScene:Scene;
		public function SiegeDuel()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		private function addedToStageHandler(event:starling.events.Event):void
		{
			var _theme:MetalWorksMobileTheme = new MetalWorksMobileTheme(this.stage);
		}
		
		public function start(background:Texture, assets:AssetManager):void
		{
			sAssets = assets;
			
			// The background is passed into this method for two reasons:
			// 
			// 1) we need it right away, otherwise we have an empty frame
			// 2) the Startup class can decide on the right image, depending on the device.
			var bg:Image = new Image(background);
			bg.width = SDContext.stageWidth;
			bg.height = SDContext.stageHeight;
//			addChild(bg);
			
			// The AssetManager contains all the raw asset data, but has not created the textures
			// yet. This takes some time (the assets might be loaded from disk or even via the
			// network), during which we display a progress indicator. 
			
			mLoadingProgress = new ProgressBar(175, 20);
			mLoadingProgress.x = (SDContext.stageWidth  - mLoadingProgress.width) / 2;
			mLoadingProgress.y = (SDContext.stageHeight - mLoadingProgress.height) / 2;

			addChild(mLoadingProgress);
			
			assets.loadQueue(
				function(ratio:Number):void
				{
					mLoadingProgress.ratio = ratio;
					
					// a progress bar should always show the 100% for a while,
					// so we show the main menu only after a short delay. 
					
					if (ratio == 1){
						Starling.juggler.delayCall(
							function():void	{
								mLoadingProgress.removeFromParent(true);
								mLoadingProgress = null;
								showMainMenu();								
							}, 
							0.15
						);
					}
						
				});
			
			addEventListener(Event.TRIGGERED, onButtonTriggered);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey);
		}
		
		private function showMainMenu():void
		{
			if (mMainMenu == null)
				mMainMenu = new MainMenu();
			
			addChild(mMainMenu);
			mMainMenu.x = (SDContext.stageWidth - mMainMenu.width)/2
			mMainMenu.y = (SDContext.stageHeight - mMainMenu.height)/2
				
//			showScene("view.scenes::BuildScene");
		}
		
		private function onKey(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.SPACE)
				Starling.current.showStats = !Starling.current.showStats;
			else if (event.keyCode == Keyboard.X)
				Starling.context.dispose();
		}
		
		private function onButtonTriggered(event:Event):void
		{
			var button:Button = event.target as Button;
			
			if (button.name == "backButton")
				closeScene();
			else
				showScene(button.name);
		}
		
		private function closeScene():void
		{
			mCurrentScene.removeFromParent(true);
			mCurrentScene = null;
			showMainMenu();
		}
		
		private function showScene(name:String):void
		{			
			if(name){
				if (mCurrentScene){
					mCurrentScene.removeFromParent(true);
					mCurrentScene = null;	
				} 
				
				var sceneClass:Class = getDefinitionByName(name) as Class;
				mCurrentScene = new sceneClass() as Scene;
				mMainMenu.removeFromParent();
				addChild(mCurrentScene);
			}			
		}
		
		public static function get assets():AssetManager { return sAssets; }
	}
}