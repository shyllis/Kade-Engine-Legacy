package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.util.FlxTimer;

class ExitState extends MusicBeatState {
    override function create() {
        super.create();

        #if desktop
        DiscordClient.changePresence("leave", "so sad");
        #end

        new FlxTimer().start(0.5, function(timer:FlxTimer) { Sys.exit(0); });
    }
}