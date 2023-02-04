package;

import lime.app.Application;
import flixel.FlxG;
import openfl.Lib;

class Option {
	public function new() {
		display = updateDisplay();
	}

	private var description:String = "";
	private var display:String;
	private var acceptValues:Bool = false;

	public var acceptType:Bool = false;

	public var waitingType:Bool = false;

	public final function getDisplay():String {
		return display;
	}

	public final function getAccept():Bool {
		return acceptValues;
	}

	public final function getDescription():String {
		return description;
	}

	public function getValue():String {
		return updateDisplay();
	};

	public function onType(text:String) {}

	// Returns whether the label is to be updated.
	public function press():Bool {
		return true;
	}

	private function updateDisplay():String {
		return "";
	}

	public function left():Bool {
		return false;
	}

	public function right():Bool {
		return false;
	}
}

class DFJKOption extends Option {
	public function new() {
		super();
	}

	public override function press():Bool {
		OptionsMenu.instance.openSubState(new KeyBindMenu());
		return false;
	}

	private override function updateDisplay():String {
		return "Key Bindings";
	}
}

class DownscrollOption extends Option {
	public function new(desc:String) {
		super();
		description = desc;
	}

	public override function left():Bool {
		FlxG.save.data.downscroll = !FlxG.save.data.downscroll;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool {
		left();
		return true;
	}

	private override function updateDisplay():String {
		return "Scroll: < " + (FlxG.save.data.downscroll ? "Downscroll" : "Upscroll") + " >";
	}
}

class GhostTapOption extends Option {
	public function new(desc:String) {
		super();
		description = desc;
	}

	public override function left():Bool {
		FlxG.save.data.ghost = !FlxG.save.data.ghost;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool {
		left();
		return true;
	}

	private override function updateDisplay():String {
		return "Ghost Tapping: < " + (FlxG.save.data.ghost ? "Enabled" : "Disabled") + " >";
	}
}

class AccuracyOption extends Option {
	public function new(desc:String) {
		super();
		description = desc;
	}

	public override function left():Bool {
		FlxG.save.data.accuracyDisplay = !FlxG.save.data.accuracyDisplay;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool {
		left();
		return true;
	}

	private override function updateDisplay():String {
		return "Accuracy Display < " + (!FlxG.save.data.accuracyDisplay ? "Disabled" : "Enabled") + " >";
	}
}

class NPSOption extends Option {
	public function new(desc:String) {
		super();
		description = desc;
	}

	public override function left():Bool {
		FlxG.save.data.npsDisplay = !FlxG.save.data.npsDisplay;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool {
		left();
		return true;
	}

	private override function updateDisplay():String {
		return "NPS Display < " + (!FlxG.save.data.npsDisplay ? "Disabled" : "Enabled") + " >";
	}
}

class ResetButtonOption extends Option {
	public function new(desc:String) {
		super();
		description = desc;
	}

	public override function left():Bool {
		FlxG.save.data.resetButton = !FlxG.save.data.resetButton;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool {
		left();
		return true;
	}

	private override function updateDisplay():String {
		return "Reset Button: < " + (!FlxG.save.data.resetButton ? "Disabled" : "Enabled") + " >";
	}
}

class OverlayOption extends Option {
	public function new(desc:String) {
		super();
		description = desc;
	}

	public override function left():Bool {
		FlxG.save.data.fps = !FlxG.save.data.fps;
		(cast(Lib.current.getChildAt(0), Main)).toggleFPS(FlxG.save.data.fps);
		display = updateDisplay();
		return true;
	}

	public override function right():Bool {
		left();
		return true;
	}

	private override function updateDisplay():String {
		return "Overlay: < " + (!FlxG.save.data.fps ? "Disabled" : "Enabled") + " >";
	}
}

class NotesBGAlpha extends Option {
	public function new(desc:String) {
		super();
		description = desc;
		acceptValues = true;
	}

	public override function press():Bool {
		return false;
	}

	private override function updateDisplay():String {
		return "Notes BG Alpha: < " + FlxG.save.data.bgNotesAlpha + " >";
	}

	override function right():Bool {
		if (FlxG.save.data.bgNotesAlpha >= 1)
			FlxG.save.data.bgNotesAlpha = 1;
		else
			FlxG.save.data.bgNotesAlpha = FlxG.save.data.bgNotesAlpha + 0.1;

		return true;
	}

	override function left():Bool {
		if (FlxG.save.data.bgNotesAlpha <= 0)
			FlxG.save.data.bgNotesAlpha = 0;
		else
			FlxG.save.data.bgNotesAlpha = FlxG.save.data.bgNotesAlpha - 0.1;

		return true;
	}

	override function getValue():String {
		return updateDisplay();
	}
}

class FPSCapOption extends Option {
	public function new(desc:String) {
		super();
		description = desc;
		acceptValues = true;
	}

	public override function press():Bool {
		return false;
	}

	private override function updateDisplay():String {
		return "FPS Cap: < " + FlxG.save.data.fpsCap + " >";
	}

	override function right():Bool {
		if (FlxG.save.data.fpsCap >= 290) {
			FlxG.save.data.fpsCap = 290;
			(cast(Lib.current.getChildAt(0), Main)).setFPSCap(290);
		} else
			FlxG.save.data.fpsCap = FlxG.save.data.fpsCap + 10;
		(cast(Lib.current.getChildAt(0), Main)).setFPSCap(FlxG.save.data.fpsCap);

		return true;
	}

	override function left():Bool {
		if (FlxG.save.data.fpsCap > 290)
			FlxG.save.data.fpsCap = 290;
		else if (FlxG.save.data.fpsCap < 60)
			FlxG.save.data.fpsCap = Application.current.window.displayMode.refreshRate;
		else
			FlxG.save.data.fpsCap = FlxG.save.data.fpsCap - 10;
				(cast(Lib.current.getChildAt(0), Main)).setFPSCap(FlxG.save.data.fpsCap);
		return true;
	}

	override function getValue():String {
		return updateDisplay();
	}
}

class CustomizeGameplay extends Option {
	public function new(desc:String) {
		super();
		description = desc;
	}

	public override function press():Bool {
		trace("switch");
		FlxG.switchState(new GameplayCustomizeState());
		return false;
	}

	private override function updateDisplay():String {
		return "Customize Gameplay";
	}
}

class NoteSplashes extends Option {
	public function new(desc:String) {
		super();
		description = desc;
	}

	public override function left():Bool {
		FlxG.save.data.noteSplashes = !FlxG.save.data.noteSplashes;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool {
		left();
		return true;
	}

	private override function updateDisplay():String {
		return "Note Splashes < " + (FlxG.save.data.noteSplashes ? "Enabled" : "Disabled") + " >";
	}
}

class RatingCounterOption extends Option {
	public function new(desc:String) {
		super();
		description = desc;
	}

	public override function left():Bool {
		FlxG.save.data.ratingCounter = !FlxG.save.data.ratingCounter;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool {
		left();
		return true;
	}

	private override function updateDisplay():String {
		return "Rating Counter < " + (FlxG.save.data.ratingCounter ? "Enabled" : "Disabled") + " >";
	}
}

class TimerOption extends Option {
	public function new(desc:String) {
		super();
		description = desc;
	}

	public override function left():Bool {
		FlxG.save.data.timer = !FlxG.save.data.timer;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool {
		left();
		return true;
	}

	private override function updateDisplay():String {
		return "Song Timer < " + (FlxG.save.data.timer ? "Enabled" : "Disabled") + " >";
	}
}

class BotPlay extends Option {
	public function new(desc:String) {
		super();
		description = desc;
	}

	public override function left():Bool {
		FlxG.save.data.botplay = !FlxG.save.data.botplay;
		trace('BotPlay : ' + FlxG.save.data.botplay);
		display = updateDisplay();
		return true;
	}

	public override function right():Bool {
		left();
		return true;
	}

	private override function updateDisplay():String
		return "BotPlay: < " + (FlxG.save.data.botplay ? "Enabled" : "Disabled") + " >";
}

class MiddleScrollOption extends Option {
	public function new(desc:String) {
		super();
		description = desc;
	}

	public override function left():Bool {
		FlxG.save.data.middleScroll = !FlxG.save.data.middleScroll;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool {
		left();
		return true;
	}

	private override function updateDisplay():String {
		return "Middle Scroll: < " + (FlxG.save.data.middleScroll ? "Enabled" : "Disabled") + " >";
	}
}

class GLRenderOption extends Option {
	public function new(desc:String) {
		super();
		description = desc;
	}

	public override function left():Bool {
		FlxG.save.data.useGL = !FlxG.save.data.useGL;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool {
		left();
		return true;
	}

	private override function updateDisplay():String {
		return "GPU Rendering: < " + (FlxG.save.data.useGL ? "Enabled" : "Disabled") + " >";
	}
}

class GPUInfo extends Option {
	public function new(desc:String) {
		super();
		description = desc;
	}

	public override function left():Bool {
		FlxG.save.data.GPUInfo = !FlxG.save.data.GPUInfo;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool {
		left();
		return true;
	}

	private override function updateDisplay():String {
		return "GPU Info: < " + (FlxG.save.data.GPUInfo ? "Enabled" : "Disabled") + " >";
	}
}

class MemoryInfo extends Option {
	public function new(desc:String) {
		super();
		description = desc;
	}

	public override function left():Bool {
		FlxG.save.data.MEMInfo = !FlxG.save.data.MEMInfo;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool {
		left();
		return true;
	}

	private override function updateDisplay():String {
		return "Memory Info: < " + (FlxG.save.data.MEMInfo ? "Enabled" : "Disabled") + " >";
	}
}

class ResetSettings extends Option {
	var confirm:Bool = false;

	public function new(desc:String) {
		super();
		description = desc;
	}

	public override function press():Bool {
		if (!confirm) {
			confirm = true;
			display = updateDisplay();
			return true;
		}
		FlxG.save.data.downscroll = null;
		FlxG.save.data.dfjk = null;
		FlxG.save.data.accuracyDisplay = null;
		FlxG.save.data.fps = null;
		FlxG.save.data.fpsRain = null;
		FlxG.save.data.fpsCap = null;
		FlxG.save.data.ghost = null;
		FlxG.save.data.resetButton = null;
		FlxG.save.data.botplay = null;
		FlxG.save.data.upBind = null;
		FlxG.save.data.downBind = null;
		FlxG.save.data.rightBind = null;
		FlxG.save.data.leftBind = null;
		FlxG.save.data.killBind = null;

		KadeEngineData.initSave();
		confirm = false;
		trace('All settings have been reset');
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String {
		return confirm ? "Confirm Settings Reset" : "Reset Settings";
	}
}
