package view.component.buildScene
{
	import feathers.dragDrop.IDropTarget;
	
	import starling.display.Image;
	import starling.textures.RenderTexture;
	import starling.textures.Texture;
	import view.component.BaseUI;

	/**
	 *@author: wanghe
	 *@data: Jan 21, 2014
	 */
	
	public class ConstructionArea extends BaseUI implements IDropTarget
	{
		public function ConstructionArea()
		{
			super();
		}
		override public function createChildren():void
		{						
			createGridBG();
		}
		private function createGridBG():void{
			var areaWidth:int = SDContext.stageWidth -151;
			var areaHeight:int = SDContext.stageHeight -148;
			
			var rowLineTexture:Texture = SiegeDuel.assetsManager.getTexture("row");
			var reelLineTexture:Texture = SiegeDuel.assetsManager.getTexture("reel");
			var rowLineImage:Image = new Image(rowLineTexture);
			var reelLineImage:Image = new Image(reelLineTexture);
			rowLineImage.width = areaWidth;
			reelLineImage.height = areaHeight;
			
			var renderTexture:RenderTexture = new RenderTexture(areaWidth,areaHeight);
			var gridImage:Image = new Image(renderTexture);
			this.addChildAt(gridImage,0);			

			renderTexture.drawBundled(function():void
			{
			
				for (var i:int = 0; i<areaHeight; i+=10){					
					if (i % 30 != 0){
						rowLineImage.alpha = 0.1;
					}else{
						rowLineImage.alpha = 1;
					}					
					rowLineImage.y = i;
					renderTexture.draw(rowLineImage);					
				}
				for (var j:int = 0; j<areaWidth; j+=10){
					if (j % 30 != 0){
						reelLineImage.alpha = 0.1;
					}else{
						reelLineImage.alpha = 1;
					}
					reelLineImage.x = j;
					renderTexture.draw(reelLineImage);
				}
			});
		}
	}
}