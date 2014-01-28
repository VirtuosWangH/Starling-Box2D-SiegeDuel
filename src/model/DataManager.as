package model
{
	import com.maccherone.json.JSON;
	
	import flash.events.Event;
	import flash.net.FileReference;
	
	import model.vo.BlockVO;
	
	import starling.events.EventDispatcher;

	/**
	 *@author: wanghe
	 *@data: Jan 14, 2014
	 */
	
	public class DataManager extends EventDispatcher
	{
		private static var _instance:DataManager;
		private var file:FileReference;
		private var _data:String;
		
		public var cellAry:Array; 
		public var _blockAry:Array;
		public function DataManager(singleton:SingletonClass)
		{
			super();
			
			cellAry = [];
			
			file = new FileReference();
			file.browse();
			file.addEventListener(Event.SELECT, onSelected);			
		}
		public static function getInstance():DataManager{
			if(_instance == null){
				var singleton:SingletonClass = new SingletonClass();
				_instance = new DataManager(singleton);
			}
			return _instance;			
		}
		private function onSelected(evt:Event):void{
			trace("SELECTED", file.name);
			file.load();
			file.addEventListener(Event.COMPLETE, onComplete);
		}
		private function onComplete(evt:Event):void {
			_data = String(file.data);
			
			var _tempObj:Object = com.maccherone.json.JSON.decode(_data);
			parseData(_tempObj);

		}
		private function parseData(blockObj:Object):void{			
			for each (var blocksItem:Object in blockObj) 
			{
				var blockVO:BlockVO = new BlockVO();
				blockVO.id = blocksItem.id;
				blockVO.availableNum = blocksItem.availableNum;
				cellAry.push(blockVO);				
			}	
		}
		
		public function encodeAry2JSON(ary:Array):String{
			var jsonStr:String = com.maccherone.json.JSON.encode(ary);
			
			trace("--------"+jsonStr)
			return jsonStr;
		}
	}
}
class SingletonClass{}