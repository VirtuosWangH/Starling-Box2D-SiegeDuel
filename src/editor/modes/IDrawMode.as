﻿package editor.modes{	import editor.ui.NativeDrawSprite;
		public interface IDrawMode{				function reset():void;		function start(nativeSprite:NativeDrawSprite):void;		function run():void;		function end():void;		function toString():String;	}}