package view.component
{
	import model.DataManager;
	import model.vo.BlockVO;
	
	import view.element.BlocksCell;

	/**
	 *@author: wanghe
	 *@data: Jan 17, 2014
	 */
	
	public class BlockBar extends BaseUI
	{
		public function BlockBar()
		{
			super();
		}
		override public function createChildren():void
		{
			var dataManager:DataManager = DataManager.getInstance();
			var blockAry:Array = dataManager.blockAry;
			for(var i:int; i < blockAry.length; i++)
			{
				var blockVO:BlockVO = blockAry[i];
				var blockCell:BlocksCell = new BlocksCell(blockVO);
				addChild(blockCell);
				if(i == 4){
					blockCell.visible = true;
				}else{
					blockCell.visible = false;
				}
			}		
		}
	}
}