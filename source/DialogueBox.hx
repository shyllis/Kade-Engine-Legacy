package;

import Controls.Device;
import lime.ui.Gamepad;
import Controls.Control;
import sys.io.File;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup {
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;

	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>) {
		super();

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer) {
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-20, 45);

		var hasDialog = true;

		switch (PlayState.SONG.song.toLowerCase()) {
			default:
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking', 'shared');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [11], "", 24);
				box.width = 225;
				box.height = 125;
				box.x = -500;
				box.y = 375;
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;

		if (PlayState.SONG.player2 != null) {
			portraitLeft = new FlxSprite(-20, 40);
			portraitLeft.frames = Paths.getSparrowAtlas('dialogue/' + PlayState.SONG.player2 + 'Dialogue', 'shared');
			portraitLeft.animation.addByPrefix('enter', 'Dialogue Enter', 24, false);
			portraitLeft.updateHitbox();
			portraitLeft.scrollFactor.set();
			add(portraitLeft);
			portraitLeft.visible = false;
		} else {
			portraitLeft = new FlxSprite(-20, 40);
			portraitLeft.frames = Paths.getSparrowAtlas('dialogue/dadDialogue', 'shared');
			portraitLeft.animation.addByPrefix('enter', 'Dialogue Enter', 24, false);
			portraitLeft.updateHitbox();
			portraitLeft.scrollFactor.set();
			add(portraitLeft);
			portraitLeft.visible = false;
		}

		if (PlayState.SONG.player1 != null) {
			portraitRight = new FlxSprite(0, 40);
			portraitRight.frames = Paths.getSparrowAtlas('dialogue/' + PlayState.SONG.player1 + 'Dialogue', 'shared');
			portraitRight.animation.addByPrefix('enter', 'Dialogue Enter', 24, false);
			portraitRight.updateHitbox();
			portraitRight.scrollFactor.set();
			add(portraitRight);
			portraitRight.visible = false;
		} else {
            portraitRight = new FlxSprite(0, 40);
            portraitRight.frames = Paths.getSparrowAtlas('dialogue/bfDialogue', 'shared');
            portraitRight.animation.addByPrefix('enter', 'Dialogue Enter', 24, false);
            portraitRight.updateHitbox();
            portraitRight.scrollFactor.set();
            add(portraitRight);
            portraitRight.visible = false;
		}
		
		box.animation.play('normalOpen');
		box.updateHitbox();
		add(box);

		box.screenCenter(X);
		portraitLeft.screenCenter(X);

		dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'PhantomMuff 1.5';
		dropText.color = 0xFFD89494;
		dropText.visible = false;
		add(dropText);

		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'PhantomMuff 1.5';
		swagDialogue.color = 0xFF000000;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float) {
		dropText.color = FlxColor.BLACK;
		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null) {
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished) {
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted) {
			startDialogue();
			dialogueStarted = true;
		}

		if (PlayerSettings.player1.controls.BACK)
			stopDialogue();

		if (PlayerSettings.player1.controls.ACCEPT && dialogueStarted == true)
			continueDialogue();

		for (touch in FlxG.touches.list) {
			if (touch.justPressed)
				continueDialogue();
		}
		
		super.update(elapsed);

		if (portraitRight.visible && box.flipX)
			box.flipX = false;
		else if (!portraitRight.visible && !box.flipX)
			box.flipX = true;
	}

	var isEnding:Bool = false;

	function continueDialogue() {
		remove(dialogue);
				
		FlxG.sound.play(Paths.sound('clickText'), 0.8);

		if (dialogueList[1] == null && dialogueList[0] != null) {
			if (!isEnding) {
				isEnding = true;

				new FlxTimer().start(0.2, function(tmr:FlxTimer) {
					box.alpha -= 1 / 5;
					bgFade.alpha -= 1 / 5 * 0.7;
					portraitLeft.visible = false;
					portraitRight.visible = false;
					swagDialogue.alpha -= 1 / 5;
					dropText.alpha = swagDialogue.alpha;
				}, 5);

				new FlxTimer().start(1.2, function(tmr:FlxTimer) {
					finishThing();
					kill();
				});
			}
		} else {
			dialogueList.remove(dialogueList[0]);
			startDialogue();
		}
	}

	function stopDialogue()  {
		remove(dialogue);

		if (!isEnding) {
			isEnding = true;

			new FlxTimer().start(0.2, function(tmr:FlxTimer) {
				box.alpha -= 1 / 5;
				bgFade.alpha -= 1 / 5 * 0.7;
				portraitLeft.visible = false;
				portraitRight.visible = false;
				swagDialogue.alpha -= 1 / 5;
				dropText.alpha = swagDialogue.alpha;
			}, 5);

			new FlxTimer().start(1.2, function(tmr:FlxTimer) {
				finishThing();
				kill();
			});
		}
	}

	function startDialogue():Void {
		cleanDialog();
        
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter) {
			case 'dad':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				if (!portraitLeft.visible) {
					swagDialogue.color = FlxColor.RED;

					portraitLeft.frames = Paths.getSparrowAtlas('dialogue/dadDialogue', 'shared');
					portraitLeft.animation.addByPrefix('enter', 'Dialogue Enter', 24, false);
					portraitLeft.screenCenter(X);

					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			case 'bf':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				if (!portraitRight.visible) {
					swagDialogue.color = FlxColor.BLUE;
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}
			case 'gf':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				if (!portraitLeft.visible) {
					swagDialogue.color = FlxColor.RED;

					portraitLeft.frames = Paths.getSparrowAtlas('dialogue/gfDialogue', 'shared');
					portraitLeft.animation.addByPrefix('enter', 'Dialogue Enter', 24, false);
					portraitLeft.screenCenter(X);

					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
		}
	}

	function cleanDialog():Void {
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}