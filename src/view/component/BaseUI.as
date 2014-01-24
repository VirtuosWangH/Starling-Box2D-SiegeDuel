package view.component
{
	import starling.display.Sprite;
	
	import view.interfaces.IBaseUI;
	
	/**
	 *@author: wanghe
	 *@data: Jan 17, 2014
	 */
	
	public class BaseUI extends Sprite implements IBaseUI
	{
		public function BaseUI()
		{
			super();
			createChildren();
		}
		public function createChildren():void
		{
		}
	}
}