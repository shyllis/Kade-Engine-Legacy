import openfl.Lib;
import flixel.FlxG;

class KadeEngineData {
	public static function initSave() {
		if (FlxG.save.data.middleScroll == null)
			FlxG.save.data.middleScroll = false;
		
		if (FlxG.save.data.cutscenesInFreeplay == null)
			FlxG.save.data.cutscenesInFreeplay = false;

		if (FlxG.save.data.downscroll == null)
			FlxG.save.data.downscroll = false;

		if (FlxG.save.data.bgNotesAlpha == null)
			FlxG.save.data.bgNotesAlpha = 0;

		if (FlxG.save.data.accuracyDisplay == null)
			FlxG.save.data.accuracyDisplay = true;

		if (FlxG.save.data.noteSplashes == null)
			FlxG.save.data.noteSplashes = true;

		if (FlxG.save.data.ratingCounter == null)
			FlxG.save.data.ratingCounter = true;

		if (FlxG.save.data.timer == null)
			FlxG.save.data.timer = true;

		if (FlxG.save.data.GPUInfo == null)
			FlxG.save.data.GPUInfo = false;

		if (FlxG.save.data.MEMInfo == null)
			FlxG.save.data.MEMInfo = true;

		if (FlxG.save.data.fps == null)
			FlxG.save.data.fps = false;

		if (FlxG.save.data.fpsCap == null)
			FlxG.save.data.fpsCap = 120;

		if (FlxG.save.data.fpsCap > 285 || FlxG.save.data.fpsCap < 60)
			FlxG.save.data.fpsCap = 120;

		if (FlxG.save.data.ghost == null)
			FlxG.save.data.ghost = true;

		if (FlxG.save.data.resetButton == null)
			FlxG.save.data.resetButton = false;

		if (FlxG.save.data.botplay == null)
			FlxG.save.data.botplay = false;

		if (FlxG.save.data.useGL == null)
			FlxG.save.data.useGL = true;

		if (FlxG.save.data.strumline == null)
			FlxG.save.data.strumline = false;

		if (FlxG.save.data.changedHit == null) {
			FlxG.save.data.changedHitX = -1;
			FlxG.save.data.changedHitY = -1;
			FlxG.save.data.changedHit = false;
		}

		if (FlxG.save.data.customStrumLine == null)
			FlxG.save.data.customStrumLine = 0;

		if (FlxG.save.data.volume != null)
			FlxG.sound.volume = FlxG.save.data.volume;

		if (FlxG.save.data.mute != null)
			FlxG.sound.muted = FlxG.save.data.mute;

		Conductor.recalculateTimings();
		PlayerSettings.player1.controls.loadKeyBinds();
		KeyBinds.keyCheck();

		(cast(Lib.current.getChildAt(0), Main)).setFPSCap(FlxG.save.data.fpsCap);
	}
}
