package;

import flixel.addons.transition.FlxTransitionableState;
import flixel.FlxSubState;
import flixel.input.gamepad.FlxGamepad;
import Options;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class OptionCata extends FlxSprite {
	public var title:String;
	public var options:Array<Option>;

	public var optionObjects:FlxTypedGroup<FlxText>;

	public var titleObject:FlxText;

	public var middle:Bool = false;

	public function new(x:Float, y:Float, _title:String, _options:Array<Option>, middleType:Bool = false) {
		super(x, y);
		title = _title;
		middle = middleType;
		if (!middleType)
			makeGraphic(295, 64, FlxColor.BLACK);
		alpha = 0.4;

		options = _options;

		optionObjects = new FlxTypedGroup();

		titleObject = new FlxText((middleType ? 1180 / 2 : x), y + (middleType ? 0 : 16), 0, title);
		titleObject.setFormat(Paths.font("vcr.ttf"), 35, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		titleObject.borderSize = 3;

		if (middleType)
			titleObject.x = 50 + ((1180 / 2) - (titleObject.fieldWidth / 2));
		else
			titleObject.x += (width / 2) - (titleObject.fieldWidth / 2);

		titleObject.scrollFactor.set();

		scrollFactor.set();

		for (i in 0...options.length) {
			var opt = options[i];
			var text:FlxText = new FlxText((middleType ? 1180 / 2 : 72), titleObject.y + 54 + (46 * i), 0, opt.getValue());
			if (middleType) {
				text.screenCenter(X);
			}
			text.setFormat(Paths.font("vcr.ttf"), 35, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			text.borderSize = 3;
			text.borderQuality = 1;
			text.scrollFactor.set();
			optionObjects.add(text);
		}
	}

	public function changeColor(color:FlxColor) {
		makeGraphic(295, 64, color);
	}
}

class OptionsMenu extends MusicBeatState {
	public static var instance:OptionsMenu;

	public var background:FlxSprite;

	public var selectedCat:OptionCata;

	public var selectedOption:Option;

	public var selectedCatIndex = 0;
	public var selectedOptionIndex = 0;

	public var isInCat:Bool = false;

	public var options:Array<OptionCata>;

	public var shownStuff:FlxTypedGroup<FlxText>;

	public var acceptInput:Bool = true;

	public static var visibleRange = [114, 640];

	public function new() {
		super();
	}

	public var menu:FlxTypedGroup<FlxSprite>;

	public var descText:FlxText;
	public var descBack:FlxSprite;

	override function create() {
		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = true;

		var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image("menuDesat"));
		menuBG.color = 0xFFea71fd;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);

		options = [
			new OptionCata(50, 40, "Gameplay", [
				new GhostTapOption("Toggle counting pressing a directional input when no arrow is there as a miss."),
				new DownscrollOption("Toggle making the notes scroll down rather than up."),
				//new FreeplayCutscenesOption("Cutscenes like videos and dialogues in Freeplay."),
				new ResetButtonOption("Toggle pressing R to gameover."),
				new ChangeKeyBindsOption(),
				new CustomizeGameplay("Drag and drop gameplay modules to your prefered positions!"),
				new BotPlay("A bot plays for you! (skill issue)")
			]),
			new OptionCata(345, 40, "Appearance", [
				new MiddleScrollOption("Put your lane in the center or on the right."),
				new NoteSplashes("Adds splashes at sick note hit."),
				new AccuracyOption("Display accuracy information on the info bar."),
				new NotesBGAlpha("Alpha Of The Lane Transparency."),
				new RatingCounterOption("Display note hit ratings information."),
				new TimerOption("Display song timer.")
			]),
			new OptionCata(640, 40, "Perfomance", [
				new OverlayOption("Show The FPS And Other Debug Info"),
				new GPUInfo("Shows GPU Info And System Info."),
				new MemoryInfo("Toggle Memory info for overlay"),
				new FPSCapOption("Change your FPS Cap."),
				new GLRenderOption("Loads Sprites Into VRAM On The GPU."),
			]),
			new OptionCata(935, 40, "Saves", [
				new ResetScoreOption("Reset your score on all songs and weeks. This is irreversible!"),
				new ResetSettings("Reset ALL your settings. This is irreversible!")
			]),
			new OptionCata(-1, 125, "Editing Keybinds", [
				new LeftKeybind("The left note's keybind"), new DownKeybind("The down note's keybind"), new UpKeybind("The up note's keybind"),
				new RightKeybind("The right note's keybind"), new ResetBind("The keybind used to die instantly"), 
			], true)
		];

		instance = this;

		menu = new FlxTypedGroup<FlxSprite>();

		shownStuff = new FlxTypedGroup<FlxText>();

		background = new FlxSprite(50, 40).makeGraphic(1180, 640, FlxColor.BLACK);
		background.alpha = 0.5;
		background.scrollFactor.set();
		menu.add(background);

		descBack = new FlxSprite(50, 640).makeGraphic(1180, 38, FlxColor.BLACK);
		descBack.alpha = 0.3;
		descBack.scrollFactor.set();
		menu.add(descBack);

		selectedCat = options[0];

		selectedOption = selectedCat.options[0];

		add(menu);

		add(shownStuff);

		for (i in 0...options.length) {
			if (i >= 4)
				continue;
			var cat = options[i];
			add(cat);
			add(cat.titleObject);
		}

		descText = new FlxText(62, 648);
		descText.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		descText.borderSize = 2;

		add(descBack);
		add(descText);

		isInCat = true;

		switchCat(selectedCat);

		selectedOption = selectedCat.options[0];

		super.create();
	}

	public function switchCat(cat:OptionCata, checkForOutOfBounds:Bool = true) {
		try {
			visibleRange = [114, 640];
			if (cat.middle)
				visibleRange = [Std.int(cat.titleObject.y), 640];
			if (selectedOption != null) {
				var object = selectedCat.optionObjects.members[selectedOptionIndex];
				object.text = selectedOption.getValue();
			}

			if (selectedCatIndex > options.length && checkForOutOfBounds)
				selectedCatIndex = 0;

			if (selectedCat.middle)
				remove(selectedCat.titleObject);

			selectedCat.changeColor(FlxColor.BLACK);
			selectedCat.alpha = 0.3;

			for (i in 0...selectedCat.options.length) {
				var opt = selectedCat.optionObjects.members[i];
				opt.y = selectedCat.titleObject.y + 54 + (46 * i);
			}

			while (shownStuff.members.length != 0) {
				shownStuff.members.remove(shownStuff.members[0]);
			}
			selectedCat = cat;
			selectedCat.alpha = 0.2;
			selectedCat.changeColor(FlxColor.WHITE);

			if (selectedCat.middle)
				add(selectedCat.titleObject);

			for (i in selectedCat.optionObjects)
				shownStuff.add(i);

			selectedOption = selectedCat.options[0];

			if (selectedOptionIndex > options[selectedCatIndex].options.length - 1) {
				for (i in 0...selectedCat.options.length) {
					var opt = selectedCat.optionObjects.members[i];
					opt.y = selectedCat.titleObject.y + 54 + (46 * i);
				}
			}

			selectedOptionIndex = 0;

			if (!isInCat)
				selectOption(selectedOption);

			for (i in selectedCat.optionObjects.members) {
				if (i.y < visibleRange[0] - 24)
					i.alpha = 0;
				else if (i.y > visibleRange[1] - 24)
					i.alpha = 0;
				else {
					i.alpha = 0.4;
				}
			}
		} catch (e) {
			selectedCatIndex = 0;
		}
	}

	public function selectOption(option:Option) {
		var object = selectedCat.optionObjects.members[selectedOptionIndex];

		selectedOption = option;

		if (!isInCat) {
			object.text = "> " + option.getValue();

			descText.text = option.getDescription();
		}
	}

	override function update(elapsed:Float) {
		super.update(elapsed);

		var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

		var accept = false;
		var right = false;
		var left = false;
		var up = false;
		var down = false;
		var any = false;
		var escape = false;

		accept = controls.ACCEPT;
		right = controls.RIGHT_P;
		left = controls.LEFT_P;
		up = controls.UP_P;
		down = controls.DOWN_P;
		escape = controls.BACK;
		any = FlxG.keys.justPressed.ANY || (gamepad != null ? gamepad.justPressed.ANY : false);

		if (selectedCat != null && !isInCat) {
			for (i in selectedCat.optionObjects.members) {
				if (selectedCat.middle) {
					i.screenCenter(X);
				}

				// I wanna die!!!
				if (i.y < visibleRange[0] - 24)
					i.alpha = 0;
				else if (i.y > visibleRange[1] - 24)
					i.alpha = 0;
				else {
					if (selectedCat.optionObjects.members[selectedOptionIndex].text != i.text)
						i.alpha = 0.4;
					else
						i.alpha = 1;
				}
			}
		}

		try {
			if (isInCat) {
				descText.text = "Please select a category";
				if (right) {
					FlxG.sound.play(Paths.sound('scrollMenu'));
					selectedCat.optionObjects.members[selectedOptionIndex].text = selectedOption.getValue();
					selectedCatIndex++;

					if (selectedCatIndex > options.length - 2)
						selectedCatIndex = 0;
					if (selectedCatIndex < 0)
						selectedCatIndex = options.length - 2;

					switchCat(options[selectedCatIndex]);
				} else if (left) {
					FlxG.sound.play(Paths.sound('scrollMenu'));
					selectedCat.optionObjects.members[selectedOptionIndex].text = selectedOption.getValue();
					selectedCatIndex--;

					if (selectedCatIndex > options.length - 2)
						selectedCatIndex = 0;
					if (selectedCatIndex < 0)
						selectedCatIndex = options.length - 2;

					switchCat(options[selectedCatIndex]);
				}

				if (accept) {
					FlxG.sound.play(Paths.sound('scrollMenu'));
					selectedOptionIndex = 0;
					isInCat = false;
					selectOption(selectedCat.options[0]);
				}

				if (escape) {
					FlxG.switchState(new MainMenuState());
				}
			} else {
				if (selectedOption != null) {
					if (selectedOption.acceptType) {
						if (escape && selectedOption.waitingType) {
							FlxG.sound.play(Paths.sound('scrollMenu'));
							selectedOption.waitingType = false;
							var object = selectedCat.optionObjects.members[selectedOptionIndex];
							object.text = "> " + selectedOption.getValue();
							return;
						} else if (any) {
							var object = selectedCat.optionObjects.members[selectedOptionIndex];
							selectedOption.onType(gamepad == null ? FlxG.keys.getIsDown()[0].ID.toString() : gamepad.firstJustPressedID());
							object.text = "> " + selectedOption.getValue();
						}
					}
				}

				if (selectedOption.acceptType || !selectedOption.acceptType) {
					if (accept) {
						var prev = selectedOptionIndex;
						var object = selectedCat.optionObjects.members[selectedOptionIndex];
						selectedOption.press();

						if (selectedOptionIndex == prev) {
							FlxG.save.flush();

							object.text = "> " + selectedOption.getValue();
						}
					}

					if (down) {
						if (selectedOption.acceptType)
							selectedOption.waitingType = false;
						FlxG.sound.play(Paths.sound('scrollMenu'));
						selectedCat.optionObjects.members[selectedOptionIndex].text = selectedOption.getValue();
						selectedOptionIndex++;

						if (selectedOptionIndex > options[selectedCatIndex].options.length - 1) {
							selectedOptionIndex = 0;
						}
						selectOption(options[selectedCatIndex].options[selectedOptionIndex]);
					} else if (up) {
						if (selectedOption.acceptType)
							selectedOption.waitingType = false;
						FlxG.sound.play(Paths.sound('scrollMenu'));
						selectedCat.optionObjects.members[selectedOptionIndex].text = selectedOption.getValue();
						selectedOptionIndex--;

						if (selectedOptionIndex < 0) {
							selectedOptionIndex = options[selectedCatIndex].options.length - 1;
						}
						selectOption(options[selectedCatIndex].options[selectedOptionIndex]);
					}

					if (right) {
						FlxG.sound.play(Paths.sound('scrollMenu'));
						var object = selectedCat.optionObjects.members[selectedOptionIndex];
						selectedOption.right();

						FlxG.save.flush();

						object.text = "> " + selectedOption.getValue();
					} else if (left) {
						FlxG.sound.play(Paths.sound('scrollMenu'));
						var object = selectedCat.optionObjects.members[selectedOptionIndex];
						selectedOption.left();

						FlxG.save.flush();

						object.text = "> " + selectedOption.getValue();
					}

					if (escape) {
						FlxG.sound.play(Paths.sound('scrollMenu'));

						if (selectedCatIndex >= 4)
							selectedCatIndex = 0;

						PlayerSettings.player1.controls.loadKeyBinds();

						for (i in 0...selectedCat.options.length) {
							var opt = selectedCat.optionObjects.members[i];
							opt.y = selectedCat.titleObject.y + 54 + (46 * i);
						}
						selectedCat.optionObjects.members[selectedOptionIndex].text = selectedOption.getValue();
						isInCat = true;
						if (selectedCat.optionObjects != null)
							for (i in selectedCat.optionObjects.members) {
								if (i != null) {
									if (i.y < visibleRange[0] - 24)
										i.alpha = 0;
									else if (i.y > visibleRange[1] - 24)
										i.alpha = 0;
									else {
										i.alpha = 0.4;
									}
								}
							}
						if (selectedCat.middle)
							switchCat(options[0]);
					}
				}
			}
		} catch (e) {
			selectedCatIndex = 0;
			selectedOptionIndex = 0;
			FlxG.sound.play(Paths.sound('scrollMenu'));
			if (selectedCat != null) {
				for (i in 0...selectedCat.options.length) {
					var opt = selectedCat.optionObjects.members[i];
					opt.y = selectedCat.titleObject.y + 54 + (46 * i);
				}
				selectedCat.optionObjects.members[selectedOptionIndex].text = selectedOption.getValue();
				isInCat = true;
			}
		}
	}
}