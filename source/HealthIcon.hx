package;

import flixel.FlxSprite;
import sys.FileSystem;
import sys.io.File;

class HealthIcon extends FlxSprite {
	public var sprTracker:FlxSprite;
	public var isPlayer:Bool;
	public var isOldIcon:Bool;
	public var character:String;

	public function new(char:String = 'bf', isPlayer:Bool = false) {
		super();
		this.isPlayer = this.isOldIcon = false;
		this.character = "";
		this.isPlayer = isPlayer;
		changeIcon(char);
		antialiasing = true;
		scrollFactor.set();
	}

	public function swapOldIcon() {
		this.isOldIcon = !this.isOldIcon;
		this.isOldIcon ? changeIcon("bf-old") : changeIcon("bf");
	}

	public function changeIcon(char:String) {
		if("bf-pixel" != char && "bf-old" != char && "senpai-angry" != char && "senpai-pissed" != char)
			char = char.split("-")[0];

		if(char != this.character) {
			if(FileSystem.exists(Paths.imageIcon("icons/icon-" + char))) {
				if(loadGraphic(Paths.imageIcon("icons/icon-" + char)).width >= 450) {
					loadGraphic(Paths.imageIcon("icons/icon-" + char), true, 150, 150);
					animation.add(char, [0, 1, 2], 0, false, this.isPlayer);
				} else if (loadGraphic(Paths.imageIcon("icons/icon-" + char)).width <= 300) {
					loadGraphic(Paths.imageIcon("icons/icon-" + char), true, 150, 150);
					animation.add(char, [0, 1], 0, false, this.isPlayer);
				}
				animation.play(char);
				this.character = char;
			} else
				changeIcon("face");
		}
	}

	override function update(elapsed:Float) {
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}