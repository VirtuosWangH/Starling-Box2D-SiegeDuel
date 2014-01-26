﻿package editor.modes{		import flash.display.Sprite;		import editor.commonData.DrawingType;	import editor.commonData.Restrictions;	import editor.drawingObject.BaseObject;	import editor.events.CommonEvent;	import editor.ui.NativeDrawSprite;
		public class PolyMode extends BaseMode {			    private var _poly:BaseObject;		private var _started:Boolean;		private var _points:Array;		private var _index:int;				public function PolyMode(){						_index = 0;			 _points = new Array();		}				override public function reset():void{			trace("Poly Reset");						// trace(_poly.x, _poly.y);			//_poly.shapeData.verts =			 _index++;			 _started = false;			// calculateCenter();		}		//this will be invoke when mouse down, so it's not like others		override public function start(main:NativeDrawSprite):void{						 trace("poly start");			 if (!_started){				 _main = main;				_points[_index] = new Array();				if (_index == 0){				 _poly =  new BaseObject("Poly");				 _main.addChild(_poly);				 _poly.dispatchEvent(new CommonEvent(CommonEvent.START_CREATE,true));				}				 _started = true;			 }			 _poly.x = 0;			 _poly.y = 0;			  if (Restrictions._isGridSnapping){				 _points[_index].push(int(_main.mouseX / 10) * 10);			     _points[_index].push(int(_main.mouseY / 10) * 10);			 }else{			     _points[_index].push(_main.mouseX);			     _points[_index].push(_main.mouseY);			 }			//trace(_points[_index].length);			// force render			run();		}				override public function run():void{			 _poly.graphics.clear();						 			 for (var j:int = 0; j<_points.length; j++){				 _poly.graphics.lineStyle(0, 0x000000);				 _poly.graphics.beginFill(0xCCCCCC);				 _poly.graphics.moveTo(_points[j][0], _points[j][1]);				 					 for(var i:int = 2; i<_points[j].length; i+=2){						 _poly.graphics.lineTo(_points[j][i], _points[j][i + 1]);					 }				 				 _poly.graphics.endFill();			 }		}				override public function end():void{			calculateCenter()			trace(_points.length);			if (_points.length < 6){				//_poly.parent.removeChild(_poly);				//trace(_poly.parent);			}			 // remove if too few points					}		private function calculateCenter():void{			_poly.graphics.clear();			  			  var nx:Array = new Array();			  var ny:Array = new Array();			   for (var j:int = 0; j<_points.length; j++){				    for(var i:int= 0; i<_points[j].length; i+=2){						nx.push(_points[j][i]);						ny.push(_points[j][i + 1]);					}			   }						   nx.sort(Array.NUMERIC);			   ny.sort(Array.NUMERIC);			/*      trace(_points);			   trace(nx);			   trace(ny);*/			 _poly.x =nx[0];			 _poly.y = ny[0];			_poly.shapeData.verts = new Array();			for (j = 0; j<_points.length; j++){			 _poly.graphics.lineStyle(0, 0x000000);			 _poly.graphics.beginFill(0xFFCCCC);			 _poly.shapeData.verts[j] = new Array();			 _poly.shapeData.verts[j][0] = _points[j][0] - _poly.x;			 _poly.shapeData.verts[j][1] = _points[j][1] - _poly.y;			 _poly.graphics.moveTo(_poly.shapeData.verts[j][0] ,    _poly.shapeData.verts[j][1]);			     				 for(i= 2; i<_points[j].length; i+=2){					  _poly.shapeData.verts[j][i] = _points[j][i] - _poly.x;					  _poly.shapeData.verts[j][i + 1] = _points[j][i + 1] - _poly.y;					  _poly.graphics.lineTo(_poly.shapeData.verts[j][i], _poly.shapeData.verts[j][i + 1]);				 }			 			  _poly.graphics.endFill();			 }			 _poly.graphics.beginFill(0xFF0000);			 _poly.graphics.drawCircle(0,0,3);			 			//_points = _poly.shapeData.verts;		}				override public function toString():String {			return DrawingType.PLOY;		}	}}/*package com.actionsnippet.qbox.editor.modes{		import com.actionsnippet.qbox.editor.*;		import flash.display.*	import flash.events.*;		public class PolyMode extends DrawingMode {			    private var _poly:CreatorObject;		private var _started:Boolean;		private var _points:Array;				public function PolyMode(){					}				override public function start(app:DrawingCreator):void{						 trace("poly start");			 if (!_started){				 _app = app;				 _points = new Array();				 _poly =  new CreatorObject();				 _app.main.addChild(_poly);				 _poly.dispatchEvent(new CommonEvent(CommonEvent.START_CREATE,true));				 _started = true;			 }			  if (_app.modifiers["grid snapping"]){				 _points.push(int(_app.main.mouseX / 10) * 10);			     _points.push(int(_app.main.mouseY / 10) * 10);			 }else{			     _points.push(_app.main.mouseX);			     _points.push(_app.main.mouseY);			 }		}				override public function run():void{			 _poly.graphics.clear();			 _poly.graphics.lineStyle(0, 0x000000);			 _poly.graphics.beginFill(0xCCCCCC);			 			 _poly.graphics.moveTo(_points[0], _points[1]);			 for(var i:int = 2; i<_points.length; i+=2){				 _poly.graphics.lineTo(_points[i], _points[i + 1]);			 }		}				override public function end():void{			trace("poly end");					}				override public function toString():String {			return "Poly";		}	}}*/