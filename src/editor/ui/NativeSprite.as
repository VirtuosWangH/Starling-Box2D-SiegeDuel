package editor.ui
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Rectangle;
	
	import editor.ModeChanger;
	import editor.commonData.DrawingType;
	import editor.commonData.Restrictions;
	import editor.drawingObject.BaseObject;
	
	/**
	 *@author: wanghe
	 *@data: Jan 24, 2014
	 */
	
	public class NativeSprite extends Sprite
	{
		private var _drawingObject:BaseObject;
		public function get drawingObject():BaseObject{ return _drawingObject;}	
		
		public function NativeSprite()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE,initListener);
		}
		
		private function initListener(e:Event):void{
			this.stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			this.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		private function onMouseDown(evt:MouseEvent):void{
			if (evt.target is BaseObject){ 
				setCurrentShape(evt.target);
			}
		}
		private function onMouseUp(evt:MouseEvent):void {
			this.stopDrag();
			var _modeChanger:ModeChanger = ModeChanger.getInstance();
			if (_modeChanger.mode.toString() == DrawingType.DRAG){
				if (_drawingObject){
					if (Restrictions._isGridSnapping){
						var b:Rectangle = _drawingObject.getRect(this);
						// check rotation
						while(int(b.left) % 10 != 0){
							_drawingObject.x -= 1;
							b = _drawingObject.getRect(this);
						}
						while(int(b.top) % 10 != 0){
							_drawingObject.y -= 1;
							b = _drawingObject.getRect(this);
						}
						// _drawingObject.x = int(_drawingObject.x / 10) * 10;
						//_drawingObject.y = int(_drawingObject.y / 10) * 10;
						trace("_drawingObject.x="+_drawingObject.x)
						
					}
				}
			}
		}
		private function setCurrentShape(sp:Object):void{
			if(_drawingObject){
				_drawingObject.filters=[]
			}
			_drawingObject = sp as BaseObject;
			
			if (_drawingObject){
				_drawingObject.filters = [new GlowFilter()];			
			}
		}
	}
}