package view.scenes
{
	import model.DataManager;
	import model.vo.BlockVO;
	
	import starling.display.BlendMode;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.RenderTexture;
	import starling.textures.Texture;
	
	import view.component.BlockBar;
	import view.element.BlocksCell;

	/**
	 *@author: wanghe
	 *@data: Jan 14, 2014
	 */
	
	public class BuildScene extends Scene
	{
		private var mButton:Button;
		public function BuildScene()
		{
			super();
			
			createChildren();
			
		}
		private function createChildren():void{
			createGridBG();
			
			var blockBar:BlockBar = new BlockBar();
			blockBar.x = SDContext.stageWidth - blockBar.width >>1;
			blockBar.y = SDContext.stageHeight - blockBar.height;
			this.addChild(blockBar);
			
			createModeSwitchor();
			controlBtnBar();
			
			var blockContainer:Sprite = new Sprite();
		}
		private function createGridBG():void{
			var rowLineTexture:Texture = SiegeDuel.assets.getTexture("row");
			var reelLineTexture:Texture = SiegeDuel.assets.getTexture("reel");
			var rowLineImage:Image = new Image(rowLineTexture);
			var reelLineImage:Image = new Image(reelLineTexture);
				
			var renderTexture:RenderTexture = new RenderTexture(SDContext.stageWidth,SDContext.stageWidth);
			var gridImage:Image = new Image(renderTexture);
			this.addChildAt(gridImage,0);
			
			renderTexture.drawBundled(function():void
			{
				for (var i:int = 0; i<SDContext.stageHeight; i+=10){					
					if (i % 30 != 0){
						rowLineImage.alpha = 0.8;
					}else{
						rowLineImage.alpha = 1;
					}					
					rowLineImage.y = i;
					renderTexture.draw(rowLineImage);					
				}
				for (i = 0; i<SDContext.stageWidth; i+=10){
					if (i % 30 != 0){
						reelLineImage.alpha = 0.8;
					}else{
						reelLineImage.alpha = 1;
					}
					reelLineImage.x = i;
					renderTexture.draw(reelLineImage);
				}
			});
		}
		
		private function createModeSwitchor():void{
			mButton = new Button(SiegeDuel.assets.getTexture("button_normal"), "Mode: Draw");
			mButton.x = int(SDContext.CenterX - mButton.width / 2);
			mButton.y = 15;
			mButton.addEventListener(Event.TRIGGERED, onButtonTriggered);
			addChild(mButton);
		}
		private function controlBtnBar():void{
			
		}
		
		private function onButtonTriggered():void{
			if (mButton.text == "Mode: Draw"){
				mButton.text = "Mode: Erase";
			}else{
				mButton.text = "Mode: Draw";
			}
		}
		
		public override function dispose():void{
			super.dispose();
		}
	}
	
}