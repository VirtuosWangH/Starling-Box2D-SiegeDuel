package view.element
{
	import feathers.dragDrop.IDragSource;
	
	import model.vo.BlockVO;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	import utils.UICreator;

	public class BlocksCell extends Sprite implements IDragSource
	{
		public var _blockVO:BlockVO;
		public var _numTxt:TextField;
		
		public function BlocksCell(blockVO:BlockVO)
		{
			_blockVO = blockVO;
			createChildren();
		}
		
		private function createChildren():void
		{
//			var bgTexture:Texture = SiegeDuel.assets.getTexture(_blockVO.id);
			var bgTexture:Texture = SiegeDuel.assets.getTexture("button_normal");
			var bg:Image = UICreator.createImg(this,bgTexture,true);
			
			_numTxt = new TextField(50,30,"0");
			this.addChild(_numTxt);
			_numTxt.text = _blockVO.availableNum.toString();		
		}
	}
}