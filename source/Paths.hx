package;

#if neko
import neko.vm.Gc;
#elseif cpp
import cpp.vm.Gc;
#end
import flixel.FlxG;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import openfl.utils.AssetType;
import openfl.media.Sound;
import openfl.utils.Assets as OpenFlAssets;

class Paths {
	inline public static var SOUND_EXT = #if web "mp3" #else "ogg" #end;

	private static var currentTrackedAssets:Map<String, Map<String, Dynamic>> = ["graphics" => [], "sounds" => []];
	private static var localTrackedAssets:Array<String> = [];

	public static final extensions:Map<String, String> = ["image" => "png", "audio" => "ogg", "video" => "mp4"];

	public static var dumpExclusions:Array<String> = [];

	public static function excludeAsset(key:String):Void
	{
		if (!dumpExclusions.contains(key))
			dumpExclusions.push(key);
	}

	// haya I love you for the base cache dump I took to the max
	public static function clearUnusedMemory():Void
	{
		#if (cpp || neko)
		Gc.run(false);
		#end

		for (key in currentTrackedAssets["graphics"].keys())
		{
			@:privateAccess
			if (!localTrackedAssets.contains(key) && !dumpExclusions.contains(key))
			{
				var graphic:Null<FlxGraphic> = currentTrackedAssets["graphics"].get(key);
				OpenFlAssets.cache.removeBitmapData(key);
				FlxG.bitmap._cache.remove(key);
				graphic.destroy();
				currentTrackedAssets["graphics"].remove(key);
			}
		}

		for (key in currentTrackedAssets["sounds"].keys())
		{
			if (!localTrackedAssets.contains(key) && !dumpExclusions.contains(key))
			{
				OpenFlAssets.cache.removeSound(key);
				currentTrackedAssets["sounds"].remove(key);
			}
		}

		#if (cpp || neko)
		Gc.run(true);
		#end
	}

	public static function clearStoredMemory():Void
	{
		@:privateAccess
		for (key in FlxG.bitmap._cache.keys())
		{
			if (!currentTrackedAssets["graphics"].exists(key))
			{
				var graphic:Null<FlxGraphic> = FlxG.bitmap._cache.get(key);
				OpenFlAssets.cache.removeBitmapData(key);
				FlxG.bitmap._cache.remove(key);
				graphic.destroy();
			}
		}

		for (key in OpenFlAssets.cache.getSoundKeys())
			if (!currentTrackedAssets["sounds"].exists(key))
				OpenFlAssets.cache.removeSound(key);

		for (key in OpenFlAssets.cache.getFontKeys())
			OpenFlAssets.cache.removeFont(key);

		localTrackedAssets = [];
	}

	static var currentLevel:String;

	static public function setCurrentLevel(name:String) {
		currentLevel = name.toLowerCase();
	}

	static function getPath(file:String, type:AssetType, library:Null<String>) {
		if (library != null)
			return getLibraryPath(file, library);

		if (currentLevel != null) {
			var levelPath = getLibraryPathForce(file, currentLevel);
			if (OpenFlAssets.exists(levelPath, type))
				return levelPath;

			levelPath = getLibraryPathForce(file, "shared");
			if (OpenFlAssets.exists(levelPath, type))
				return levelPath;
		}

		return getPreloadPath(file);
	}

	static public function getLibraryPath(file:String, library = "preload") {
		return if (library == "preload" || library == "default") getPreloadPath(file); else getLibraryPathForce(file, library);
	}

	inline static function getLibraryPathForce(file:String, library:String) {
		return '$library:assets/$library/$file';
	}

	inline static function getPreloadPath(file:String) {
		return 'assets/$file';
	}

	inline static public function file(file:String, type:AssetType = TEXT, ?library:String) {
		return getPath(file, type, library);
	}

	inline static public function txt(key:String, ?library:String) {
		return getPath('data/$key.txt', TEXT, library);
	}

	inline static public function xml(key:String, ?library:String) {
		return getPath('data/$key.xml', TEXT, library);
	}

	inline static public function json(key:String, ?library:String) {
		return getPath('data/$key.json', TEXT, library);
	}

	static public function sound(key:String, ?library:String) {
		return returnSound('sounds/$key', library);
	}

	inline static public function soundRandom(key:String, min:Int, max:Int, ?library:String) {
		return returnSound('sounds/$key' + FlxG.random.int(min, max), library);
	}

	inline static public function music(key:String, ?library:String) {
		return returnSound('music/$key', library);
	}

	inline static public function voices(song:String) {
		var songLowercase = StringTools.replace(song, " ", "-").toLowerCase();
		switch (songLowercase) {
			case 'dad-battle':
				songLowercase = 'dadbattle';
			case 'philly-nice':
				songLowercase = 'philly';
		}
		return 'songs:assets/songs/${songLowercase}/Voices.$SOUND_EXT';
	}

	inline static public function P1voice(song:String) {
		var songLowercase = StringTools.replace(song, " ", "-").toLowerCase();
		switch (songLowercase) {
			case 'dad-battle':
				songLowercase = 'dadbattle';
			case 'philly-nice':
				songLowercase = 'philly';
		}
		return 'songs:assets/songs/${songLowercase}/playerVoice.$SOUND_EXT';
	}

	inline static public function P2voice(song:String) {
		var songLowercase = StringTools.replace(song, " ", "-").toLowerCase();
		switch (songLowercase) {
			case 'dad-battle':
				songLowercase = 'dadbattle';
			case 'philly-nice':
				songLowercase = 'philly';
		}
		return 'songs:assets/songs/${songLowercase}/enemyVoice.$SOUND_EXT';
	}

	inline static public function inst(song:String) {
		var songLowercase = StringTools.replace(song, " ", "-").toLowerCase();
		switch (songLowercase) {
			case 'dad-battle':
				songLowercase = 'dadbattle';
			case 'philly-nice':
				songLowercase = 'philly';
		}
		return 'songs:assets/songs/${songLowercase}/Inst.$SOUND_EXT';
	}

	inline static public function image(key:String, ?library:String) {
		return getPath('images/$key.png', IMAGE, library);
	}

	inline static public function font(key:String) {
		return 'assets/fonts/$key';
	}

	inline static public function getSparrowAtlas(key:String, ?library:String) {
		return FlxAtlasFrames.fromSparrow(image(key, library), file('images/$key.xml', library));
	}

	inline static public function getPackerAtlas(key:String, ?library:String) {
		return FlxAtlasFrames.fromSpriteSheetPacker(image(key, library), file('images/$key.txt', library));
	}

	public static function returnGraphic(key:String, ?library:String)
		{
			var file:String = getPath('$key.${extensions.get("image")}', IMAGE, library);
	
			if (OpenFlAssets.exists(file))
			{
				if (!currentTrackedAssets["graphics"].exists(file))
				{
					var graphic:FlxGraphic = FlxG.bitmap.add(file, false, file);
					graphic.persist = true;
					currentTrackedAssets["graphics"].set(file, graphic);
				}
	
				localTrackedAssets.push(file);
				return currentTrackedAssets["graphics"].get(file);
			}
	
			#if debug
			FlxG.log.error('oh no $file is returning null NOOOO');
			#else
			trace('oh no $file is returning null NOOOO');
			#end
			return null;
		}
	
		public static function returnSound(key:String, ?library:String)
		{
			var file:String = getPath('$key.${extensions.get("audio")}', SOUND, library);
	
			if (OpenFlAssets.exists(file))
			{
				if (!currentTrackedAssets["sounds"].exists(file))
					currentTrackedAssets["sounds"].set(file, OpenFlAssets.getSound(file));
	
				localTrackedAssets.push(file);
				return currentTrackedAssets["sounds"].get(file);
			}
	
			#if debug
			FlxG.log.error('oh no $file is returning null NOOOO');
			#else
			trace('oh no $file is returning null NOOOO');
			#end
			return null;
		}
}
