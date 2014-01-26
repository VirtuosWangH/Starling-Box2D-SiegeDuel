﻿package editor.modes{		import flash.geom.Point;		import editor.commonData.DrawingType;	import editor.commonData.Restrictions;	import editor.drawingObject.BaseObject;	import editor.drawingObject.JointObject;	import editor.events.CommonEvent;	import editor.ui.NativeDrawSprite;
		public class JointMode extends BaseMode {	    private var _joint:BaseObject;				public function JointMode(){		}				override public function start(main:NativeDrawSprite):void{						 trace("joint start");			 _main = main;			 _joint =  new JointObject();			 if (Restrictions._isGridSnapping){				 _joint.x = int(_main.mouseX / 10) * 10;				 _joint.y = int(_main.mouseY / 10) * 10;			 }else{			   _joint.x = _main.mouseX;			   _joint.y = _main.mouseY;			 }			 			 			 _main.addChild(_joint);			 _joint.dispatchEvent(new CommonEvent(CommonEvent.START_CREATE,true));		}				override public function run():void{			 _joint.graphics.clear();			 _joint.graphics.lineStyle(3, 0xFFCC00);			 			 var dx:Number =  _main.mouseX - _joint.x;			 var dy:Number =  _main.mouseY- _joint.y;			 if (Restrictions._isGridSnapping){				  dx = int(dx / 10) * 10;				  dy = int(dy / 10) * 10;			 }			 _joint.graphics.lineTo(dx, dy);			 _joint.shapeData.pointB = new Point(dx, dy);					}				 		override public function end():void{			_joint.shapeData.pointA = new Point(0,0);			 			//trace(_joint.shapeData.pointA, _joint.shapeData.pointB);			//trace("joint end");			var w:Number = _joint.width;			var h:Number = _joint.height;			if (w == 0 || h == 0){				_joint.parent.removeChild(_joint);							}			/*			_joint.shapeData.width = w;			_joint.shapeData.height = h;			var b:Rectangle= _joint.getRect(_joint.parent);			var nx:Number = b.left + _joint.width / 2;			var ny:Number = b.top + _joint.height / 2;			 _joint.graphics.clear();			 _joint.graphics.lineStyle(0, 0x000000);			 _joint.graphics.beginFill(0xCCCCCC);			 _joint.graphics.drawRect(-w/2, -h/2, w, h);			 _joint.x = nx;			 _joint.y = ny;*/		}		 				override public function toString():String {			return DrawingType.JOINT;		}		 	}}