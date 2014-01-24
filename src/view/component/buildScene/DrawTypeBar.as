package view.component.buildScene
{
	import editor.ModeChanger;
	import editor.commonData.Restrictions;
	import editor.modes.BoxMode;
	import editor.modes.CircleMode;
	import editor.modes.DragMode;
	import editor.modes.JointMode;
	import editor.modes.PolyMode;
	import editor.modes.RotateMode;
	
	import feathers.controls.Check;
	import feathers.controls.Radio;
	import feathers.core.ToggleGroup;
	
	import starling.events.Event;
	
	import view.component.BaseUI;

	/**
	 *@author: wanghe
	 *@data: Jan 24, 2014
	 */
	
	public class DrawTypeBar extends BaseUI
	{
		private var _radioGroup:ToggleGroup;
		private var _radioAry:Array;
		private var _drawType:Array = ["BOX","CIRCLE","POLY","JOINT"];
		private var _checkAry:Array;
		private var _drawMode:Array = ["Drag","Rotate","GridSnapping","ConstrainSquare"];
		
		public static var _currentTypeID:int;
		private var _modeChanger:ModeChanger;
		public function DrawTypeBar(modeChanger:ModeChanger)
		{
			_modeChanger = modeChanger;
			super();			
		}
		
		override public function createChildren():void
		{
			_radioAry = [];
			_checkAry = [];
			this._radioGroup = new ToggleGroup();
			this._radioGroup.addEventListener(Event.CHANGE, radioGroup_changeHandler);
			for(var i:int; i < 4; i++)
			{
				var radio:Radio = new Radio();
				_radioAry.push(radio);
				radio.label = _drawType[i];				
				this._radioGroup.addItem(radio);
				this.addChild(radio);							
			}	
			
			for(var j:int; j < 4; j++)
			{
				var check:Check = new Check();
				_checkAry.push(check);
				check.label = _drawMode[j];					
				this.addChild(check);
				if(j == 3){
					check.addEventListener(Event.ADDED_TO_STAGE, layout);					
				}
				check.addEventListener(Event.CHANGE, check_changeHandler );
			}
		}
		private function layout():void{
			for (var i:int = 0; i < _radioAry.length; i++) 
			{
				var radio:Radio =  _radioAry[i];
				radio.validate();
				if(i){
					radio.x = _radioAry[i-1].x + _radioAry[i-1].width + 10 ;
				}else{
					radio.x = 0;
				}				
			}
			
			for (var j:int = 0; j < _checkAry.length; j++) 
			{
				var check:Check = _checkAry[j];
				check.validate();
				if(j){
					check.x = _checkAry[j-1].x + _checkAry[j-1].width + 10 ;
				}else{
					check.x = _radioAry[3].x + _radioAry[3].width + 50;
				}
			}			
		}
		private function radioGroup_changeHandler(event:Event):void
		{
			var typeID:int = this._radioGroup.selectedIndex;
			_currentTypeID = typeID;
			switch(typeID)
			{
				case 0:
				{
					_modeChanger.change(new BoxMode());
					break;
				}
				case 1:
				{
					_modeChanger.change(new CircleMode());
					break;
				}
				case 2:
				{
					_modeChanger.change(new PolyMode());
					break;
				}
				case 3:
				{
					_modeChanger.change(new JointMode());
					break;
				}
				default:
				{
					_modeChanger.change(new BoxMode());
					break;
				}
			}
		}
		private function check_changeHandler(e:Event):void{
			var check:Check = e.currentTarget as Check;
			var checkID:String = check.label;
			switch(checkID)
			{
				case _drawMode[0]:{
					_modeChanger.change(new DragMode());
					break;
				}
				case _drawMode[1]:{
					_modeChanger.change(new RotateMode());
					break;
				}
				case _drawMode[2]:{
					Restrictions._isConstrainSquare = check.isSelected;
					break;
				}
				case _drawMode[3]:{
					Restrictions._isGridSnapping = check.isSelected;
					break;
				}
				default:
				{
					break;
				}
			}
		}
		private function switchCheck(isCheck:Boolean):void{
			
		}
	}
}