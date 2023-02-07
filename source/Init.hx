package;

import flixel.FlxG;
import flixel.FlxState;
import lime.app.Application;
#if windows
import Discord.DiscordClient;
#end

class Init {
	function new() {}

	public static function Initialize() {
		PlayerSettings.init();

		#if windows
		DiscordClient.initialize();

		Application.current.onExit.add(function(exitCode) {
			DiscordClient.shutdown();
		});
		#end
		
		FlxG.save.bind('kadelegacy' #if (flixel < "5.0.0"), 'goldie5' #end);

		KadeEngineData.initSave();

		KeyBinds.keyCheck();

		Highscore.load();
	}
}
