package view.element
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import model.vo.BlockVO;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	import utils.UICreator;

	public class BlocksCell extends Sprite
	{
		private var _blockVO:BlockVO;
		private var _numTxt:TextField;
		
		public function BlocksCell(blockVO:BlockVO)
		{
			_blockVO = blockVO;
			createChildren();
		}
		
		private function createChildren():void
		{
			var bgTexture:Texture = SiegeDuel.assets.getTexture(_blockVO.id);
			var bg:Image = UICreator.createImg(this,bgTexture,true);
			
			_numTxt = new TextField(50,50,"0");
			this.addChild(_numTxt);
			_numTxt.text = _blockVO.availableNum.toString();
				
			this.addEventListener(TouchEvent.TOUCH, onCellTouched);
		}
		
		private function onCellTouched(te:TouchEvent):void
		{
			var touch:Touch = te.getTouch(this);
			
			if(touch)
			{
				var touchPoint:Point = new Point(touch.globalX, touch.globalY);
			
				if(touch.phase == TouchPhase.BEGAN){
					
				}else if(touch.phase == TouchPhase.ENDED){
					
				}
			}
		}
	}
}