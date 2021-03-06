package view.scenes
{
	import com.maccherone.json.JSON;
	
	import flash.display.Sprite;
	
	import EasyBox2D.EasyBox2D;
	import EasyBox2D.ui.NativeB2DSprite;
	
	import editor.parsers.StringToObject;
	
	import model.DataManager;
	
	import utils.NativeUtil;

	/**
	 *@author: wanghe
	 *@data: Jan 26, 2014
	 */
	
	public class SiegeScene extends Scene
	{
		public function SiegeScene()
		{
			super();
			var nativeSprite:Sprite = new NativeB2DSprite();
			NativeUtil.nativeSpriteContainer.addChild(nativeSprite);
			var params:Object = new Object();
			params.debug = true;
			var easyB2D:EasyBox2D = new EasyBox2D(nativeSprite,params);
			easyB2D.createStageWalls();
			
			var dataManager:DataManager = DataManager.getInstance();
			
//			var objString:String = "{x:2, y:2, width:2, height:2, angle: 0, density:1, restitution:0.4, friction:0.5}";
			
			for (var i:int = 0; i < dataManager._blockAry.length; i++) 
			{
//				var objString:String = com.maccherone.json.JSON.encode(dataManager._blockAry[i])
//				var property:Object = StringToObject.parse(objString);
				var property:Object = dataManager._blockAry[i];
				easyB2D.addBox(property);
			}
			
			
			easyB2D.start();
		}
	}
}