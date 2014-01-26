package view.scenes
{
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.utils.getQualifiedClassName;
	
	import editor.ModeChanger;
	import editor.commonData.DrawingType;
	import editor.drawingObject.BaseObject;
	import editor.drawingObject.JointObject;
	import editor.ui.NativeDrawSprite;
	
	import feathers.dragDrop.DragData;
	import feathers.dragDrop.DragDropManager;
	import feathers.events.DragDropEvent;
	
	import model.DataManager;
	import model.vo.BlockVO;
	
	import starling.display.Button;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	import utils.NativeUtil;
	
	import view.component.buildScene.BlockTypeBar;
	import view.component.buildScene.ConstructionArea;
	import view.component.buildScene.DrawTypeBar;
	import view.element.BlocksCell;

	/**
	 *@author: wanghe
	 *@data: Jan 14, 2014
	 */
	
	public class BuildScene extends Scene
	{		
		private var _modeChanger:ModeChanger;
		private var _blockSelectBar:BlockTypeBar;
		private var _drawTypeBar:DrawTypeBar;
		
		private var constructionArea:ConstructionArea;
		private var _modeSwitchBtn:Button;
		private var _constructionCompleteBtn:Button;
		
		private var _nativeDrawSprite:NativeDrawSprite;
		public function BuildScene()
		{
			super();
			init();
		}	
		private function init():void{			
			createNativeSprite();
		}
		
		override protected function createChildren():void{			
			constructionArea = new ConstructionArea();
			this.addChild(constructionArea);
			constructionArea.x = (SDContext.stageWidth - constructionArea.width)/2;
			constructionArea.y = (SDContext.stageHeight - constructionArea.height)/2;
			constructionArea.addEventListener(DragDropEvent.DRAG_ENTER,onDragEnter);
			constructionArea.addEventListener(DragDropEvent.DRAG_DROP,onDragDrop);
			constructionArea.addEventListener(DragDropEvent.DRAG_COMPLETE,onDragComplete);
			
			_blockSelectBar = new BlockTypeBar();
			_blockSelectBar.x = (SDContext.stageWidth - _blockSelectBar.width)/2;
			_blockSelectBar.y = SDContext.stageHeight - _blockSelectBar.height;
			this.addChild(_blockSelectBar);
			
			_modeChanger = ModeChanger.getInstance();
			_drawTypeBar = new DrawTypeBar(_modeChanger);
			_drawTypeBar.x = (SDContext.stageWidth - _drawTypeBar.width)/2 -400;
			_drawTypeBar.y = SDContext.stageHeight - _drawTypeBar.height -50;
			this.addChild(_drawTypeBar);	
			_drawTypeBar.visible = false;
			
			createModeSwitchor();
			controlBtnBar();
		}	
		private function onDragEnter(e:DragDropEvent):void{
			var dragData:DragData = e.dragData;
			var constructionArea:ConstructionArea = e.currentTarget as ConstructionArea;
			if(dragData.hasDataForFormat("display-object-drag-format"))
			{
				DragDropManager.acceptDrag(constructionArea);
				dragData.getDataForFormat("display-object-drag-format")
			}
		}
		private function onDragDrop(e:DragDropEvent):void{
			var localPoint:Point = new Point(e.localX,e.localY);
			var resultPoint:Point = new Point();
			constructionArea.localToGlobal(localPoint,resultPoint);
			
			var dataManager:DataManager = DataManager.getInstance();
			var blockAry:Array = dataManager.blockAry;
			var blockVO:BlockVO = blockAry[4];
			var blockCell:BlocksCell = new BlocksCell(blockVO);
			blockCell._numTxt.visible = false;
			constructionArea.addChild(blockCell);
			blockCell.x = localPoint.x;
			blockCell.y = localPoint.y;			
			blockCell.addEventListener(TouchEvent.TOUCH, onCellTouched);
		}
		private function onCellTouched(te:TouchEvent):void{
			var basetouch:Touch = te.getTouch(this);
			if(basetouch){
				if(basetouch.phase == TouchPhase.MOVED){
					
					var blockCell:BlocksCell = te.currentTarget as BlocksCell;
					var touch:Touch = te.getTouch(constructionArea);
					var localPoint:Point = new Point();
					var globalPoint:Point = new Point(touch.globalX,touch.globalY);
					constructionArea.globalToLocal(globalPoint,localPoint);
					blockCell.x = localPoint.x;
					blockCell.y = localPoint.y; 
				}
			}			
		}
		private function onDragComplete(e:DragDropEvent):void{
			trace("-------------------onDragComplete");			
		}
		
		//=========Control Bar=================================
		private function controlBtnBar():void{
			_constructionCompleteBtn = new Button(SiegeDuel.assets.getTexture("button_normal"), "Complete");
			_constructionCompleteBtn.x = SDContext.stageWidth - _modeSwitchBtn.width;
			_constructionCompleteBtn.y = SDContext.stageHeight - _modeSwitchBtn.height;
			_constructionCompleteBtn.addEventListener(Event.TRIGGERED, onControlBtnTriggered);
			_constructionCompleteBtn.name = getQualifiedClassName(SiegeScene);
			addChild(_constructionCompleteBtn);
		}
		
		private function onControlBtnTriggered(event:Event):void{			
			var blockAry:Array = prepareBlockAry();
			DataManager.getInstance().encodeAry2JSON(blockAry);		
			
			getCommandFromObjects();
		}
		private function prepareBlockAry():Array{
			var blockAry:Array = [];
			var itemNum:int = constructionArea.numChildren;
			for (var i:int = 0; i < itemNum; i++) 
			{
				var child:* = constructionArea.getChildAt(i);
				if(child is BlocksCell){
					var block:BlocksCell = child as BlocksCell;
					var blockObj:Object = new Object();
					blockObj.id = block._blockVO.id;
					blockObj.x = block.x;
					blockObj.y = block.y;
					blockObj.width = block.width;
					blockObj.height = block.height;
					blockAry.push(blockObj);
				}
			}
			return blockAry;
		}
		private function getCommandFromObjects():String{
			var str:String = "";
			for (var i:int = 0; i<_nativeDrawSprite.numChildren; i++){
				var e:BaseObject = _nativeDrawSprite.getChildAt(i) as BaseObject;
				if (e){
					if (!(e is JointObject)){//for no joint
						str += e.objectDef + "\n";
					}
				}
			}
			str += "// joints:\n";
			for (i = 0; i<_nativeDrawSprite.numChildren; i++){
				e = _nativeDrawSprite.getChildAt(i) as BaseObject;
				if (e){
					if ((e is JointObject)){//for joint
						str += e.objectDef + "\n";
					}
				}
			}			
			trace(str);
			return str;
		}
		//=========Mode Change=================================
		private function createModeSwitchor():void{
			_modeSwitchBtn = new Button(SiegeDuel.assets.getTexture("button_normal"), "Mode: Select");
			_modeSwitchBtn.x = int(SDContext.CenterX - _modeSwitchBtn.width / 2);
			_modeSwitchBtn.y = 15;
			_modeSwitchBtn.addEventListener(Event.TRIGGERED, onModeBtnTriggered);
			addChild(_modeSwitchBtn);
		}
		private function onModeBtnTriggered(event:Event):void{	
			if (_modeSwitchBtn.text == "Mode: Draw"){
				_modeSwitchBtn.text = "Mode: Select";
				removeDrawListener();
				_drawTypeBar.visible = false;
				_blockSelectBar.visible = true;
			}else{
				_modeSwitchBtn.text = "Mode: Draw";
				initDrawListener();
				_drawTypeBar.visible = true;
				_blockSelectBar.visible = false;
			}
		}
		//=========Draw Function=================================
		private function initDrawListener():void{
			this.addEventListener(TouchEvent.TOUCH, onDrawTouched);
		}
		private function removeDrawListener():void{
			this.removeEventListener(TouchEvent.TOUCH, onDrawTouched);
		}
		private function onDrawTouched(te:TouchEvent):void{
			var basetouch:Touch = te.getTouch(constructionArea);
			if(basetouch){
				if(basetouch.phase == TouchPhase.BEGAN){					
					var mousePoint:Point = new Point(basetouch.globalX, basetouch.globalY);					
					startDraw(mousePoint);
				}
				if(basetouch.phase == TouchPhase.ENDED){
					_modeChanger.mode.end();
					this.removeEventListener(Event.ENTER_FRAME, onDrawing);
				}
			}			
		}
		private function startDraw(mousePoint:Point):void{
			
			if (_modeChanger.mode.toString() == DrawingType.DRAG){
				if (_nativeDrawSprite.drawingObject){
					if (_nativeDrawSprite.drawingObject.hitTestPoint(mousePoint.x, mousePoint.y, true)){						
						_nativeDrawSprite.drawingObject.startDrag();
					}
				}
			}else if (_modeChanger.mode.toString() == DrawingType.ROTATE){
				if (_nativeDrawSprite.drawingObject){
					_modeChanger.mode.start(_nativeDrawSprite);
					this.addEventListener(Event.ENTER_FRAME, onDrawing);
				} 
			}else{
				_modeChanger.mode.start(_nativeDrawSprite);
				this.addEventListener(Event.ENTER_FRAME, onDrawing);
			}
		}
		private function onDrawing(evt:Event):void {
			_modeChanger.mode.run();
		}
		
		//=========Native Sprite=================================
		private function createNativeSprite():void{
			_nativeDrawSprite = new NativeDrawSprite();
			NativeUtil.nativeSpriteContainer.addChild(_nativeDrawSprite);
		}
		public override function dispose():void{
			super.dispose();
		}
	}	
}