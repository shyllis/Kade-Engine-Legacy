package;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

class CharacterSetting {
	public var x(default, null):Int;
	public var y(default, null):Int;
	public var scale(default, null):Float;
	public var flipped(default, null):Bool;

	public function new(x:Int = 0, y:Int = 0, scale:Float = 1.0, flipped:Bool = false) {
		this.x = x;
		this.y = y;
		this.scale = scale;
		this.flipped = flipped;
	}
}

class MenuCharacter extends FlxSprite {
	private static var settings:Map<String, CharacterSetting> = [
		'bf' => new CharacterSetting(-25, -55, 1.1, true),
		'gf' => new CharacterSetting(-50, -10, 1.0, true),
		'dad' => new CharacterSetting(-125, 40, 1.0)
	];

	private var flipped:Bool = false;

	public function new(x:Int, y:Int, scale:Float, flipped:Bool) {
		super(x, y);
		this.flipped = flipped;
		setGraphicSize(Std.int(width * scale));
		updateHitbox();
	}

	public function setCharacter(character:String):Void {
		if (character == '') {
			visible = false;
			return;
		} else {
			visible = true;

			frames = Paths.getSparrowAtlas('storymenu/menucharacters/' + character);
			var idleAnim:String = null;
			switch (character) {
				case 'bf':
					idleAnim = 'M BF Idle';
				case 'gf':
					idleAnim = 'M GF Idle';
				case 'dad':
					idleAnim = 'M Dad Idle';
			}

			animation.addByPrefix('idle', idleAnim, 24);
			var confirmAnim:String = null;
			switch (character) {
				case 'bf':
					confirmAnim = 'M bf HEY';
			}
			if (confirmAnim != null)
				animation.addByPrefix('confirm', confirmAnim, 24, false);
			else
				animation.addByPrefix('confirm', idleAnim, 24, false);
		}

		animation.play('idle');

		var setting:CharacterSetting = settings[character];
		offset.set(setting.x, setting.y);
		setGraphicSize(Std.int(width * setting.scale));
		flipX = setting.flipped != flipped;
	}
}
