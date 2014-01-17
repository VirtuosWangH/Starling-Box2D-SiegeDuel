package utils
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	/**
	 *@author: wanghe
	 *@data: Jan 17, 2014
	 */
	
	public class UICreator
	{
		public function UICreator()
		{
		}
		public static function createImg(container:Sprite,texture:Texture,isVisible:Boolean=false):Image{
			var image:Image = new Image(texture);
			image.pivotX = image.width>>1;
			image.pivotY = image.height>>1;
			image.visible = isVisible;
			container.addChild(image);
			return image;
		}
	}
}