package;

import openfl.display.BlendMode;
import openfl.text.TextFormat;
import openfl.display.Application;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxState;
import openfl.Assets;
import openfl.Lib;
import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.events.Event;
import flixel.graphics.FlxGraphic;
import openfl.utils.AssetCache;

#if cpp
import cpp.vm.Gc;	
#end

#if hl
import hl.Gc;
#elseif java
import java.vm.Gc;
#elseif neko
import neko.vm.Gc;
#end
using StringTools;

class Main extends Sprite {
	var game = {
		width: 1280, // WINDOW width
		height: 720, // WINDOW height
		initialState: TitleState, // initial game state
		zoom: -1.0, // game state bounds
		framerate: 60, // default framerate
		skipSplash: true, // if the default flixel splash screen should be skipped
		startFullscreen: false // if the game should start at fullscreen mode
	};

	var fpsCounter:Overlay;

	public static function main():Void {
		Lib.current.addChild(new Main());
	}

	public function new() {
		super();

		if (stage != null) {
			init();
		} else {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
	}

	private function init(?E:Event):Void {
		if (hasEventListener(Event.ADDED_TO_STAGE)) {
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}

		setupGame();
	}

	private function setupGame():Void {
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		if (game.zoom == -1.0) {
			var ratioX:Float = stageWidth / game.width;
			var ratioY:Float = stageHeight / game.height;
			game.zoom = Math.min(ratioX, ratioY);
			game.width = Math.ceil(stageWidth / game.zoom);
			game.height = Math.ceil(stageHeight / game.zoom);
		}
		
		#if cpp
		Gc.enable(true);
		#end

		#if !debug
		game.initialState = TitleState;
		#end

		addChild(new FlxGame(game.width, game.height, game.initialState, #if (flixel < "5.0.0") game.zoom, #end game.framerate, game.framerate,
			game.skipSplash, game.startFullscreen));

		FlxGraphic.defaultPersist = false;	

		FlxG.signals.preStateSwitch.add(function() {
			Paths.clearStoredMemory();
			FlxG.bitmap.dumpCache();

			var cache = cast(Assets.cache, AssetCache);
			for (key => font in cache.font)
				cache.removeFont(key);
			for (key => sound in cache.sound)
				cache.removeSound(key);

			gc();
		});

		FlxG.signals.postStateSwitch.add(function() {
			Paths.clearUnusedMemory();
			gc();
		});

		fpsCounter = new Overlay(10, 3, game.width, game.height);
		addChild(fpsCounter);
		if (fpsCounter != null)
			fpsCounter.visible = FlxG.save.data.fps;
	}

	public static function gc() {
		#if cpp
		Gc.run(true);
		#elseif hl
		Gc.major();
		#elseif (java || neko)
		Gc.run(true);
		#else
		openfl.system.System.gc();
		#end
		
	}

	public function toggleFPS(fpsEnabled:Bool):Void {
		fpsCounter.visible = fpsEnabled;
	}

	public function setFPSCap(cap:Float)
	{
		var framerate = Std.int(cap);
		openfl.Lib.current.stage.frameRate = cap;
		if (framerate > FlxG.drawFramerate) {
			FlxG.updateFramerate = framerate;
			FlxG.drawFramerate = framerate;
		} else {
			FlxG.drawFramerate = framerate;
			FlxG.updateFramerate = framerate;
		}
	}

	public function getFPSCap():Float {
		return openfl.Lib.current.stage.frameRate;
	}

	public function getFPS():Float {
		return fpsCounter.currentFrames;
	}
}
