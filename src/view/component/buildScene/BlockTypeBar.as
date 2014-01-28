package view.component.buildScene
{
	import feathers.dragDrop.DragData;
	import feathers.dragDrop.DragDropManager;
	
	import model.DataManager;
	import model.vo.BlockVO;
	
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	import utils.UICreator;
	
	import view.component.BaseUI;
	import view.element.BlocksCell;

	/**
	 *@author: wanghe
	 *@data: Jan 17, 2014
	 */
	
	public class BlockTypeBar extends BaseUI
	{
		public function BlockTypeBar()
		{
			super();
		}
		override public function createChildren():void
		{
			var dataManager:DataManager = DataManager.getInstance();
			var blockAry:Array = dataManager.cellAry;
			for(var i:int; i < blockAry.length; i++)
			{
				var blockVO:BlockVO = blockAry[i];
				var blockCell:BlocksCell = new BlocksCell(blockVO);
				addChild(blockCell);
				blockCell.x = i*blockCell.width+10;
				blockCell.addEventListener(TouchEvent.TOUCH, onCellTouched);
			}		
		}
		private function onCellTouched(te:TouchEvent):void{
			var basetouch:Touch = te.getTouch(this);
			if(basetouch){
				if(basetouch.phase == TouchPhase.BEGAN){					
					var blockCell:BlocksCell = te.currentTarget as BlocksCell;
					var dragData:DragData = new DragData();
					dragData.setDataForFormat("display-object-drag-format", blockCell);					
					var touch:Touch = te.getTouch(stage);
					var bgTexture:Texture = SiegeDuel.assets.getTexture("button_normal");
					var dragAvator:Image = UICreator.createImg(this,bgTexture,true);
					DragDropManager.startDrag(blockCell,touch,dragData,dragAvator);
				}
			}
			
		}
		
	}
}