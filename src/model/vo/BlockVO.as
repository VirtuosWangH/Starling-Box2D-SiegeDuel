package model.vo
{
	/**
	 *@author: wanghe
	 *@data: Jan 17, 2014
	 */
	
	public class BlockVO
	{
		private var _id:String;
		private var _availableNum:int;
		public function BlockVO()
		{
		}

		public function get id():String
		{
			return _id;
		}

		public function set id(value:String):void
		{
			_id = value;
		}

		public function get availableNum():int
		{
			return _availableNum;
		}

		public function set availableNum(value:int):void
		{
			_availableNum = value;
		}

	}
}