package editor.ui
{
	import flash.display.Sprite;
	
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
		}
	}
}