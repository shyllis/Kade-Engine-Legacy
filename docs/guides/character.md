# Creating A Custom Character

## Requirements
1. The ability to compile Kade Engine Legacy from the source code. All information related to building Kade Engine Legacy is listed [here.](https://github.com/dolpshy/Kade-Engine-Legacy/blob/main/docs/building.md)
2. A text editor. Some form of IDE that can support Haxe is recommended, such as Visual Studio Code (should intall Haxe extension).

---
### Step 1. Navigation
Navigate to your Kade Engine Legacy source code. In the `source` folder, look for `Character.hx`. Open it in your text editor or IDE.

### Step 2. Editing files without using source
Choose a folder where you want to add your character assets.
Add a .png and .xml files of your character with the same names.

Add your character to the characterList.txt file located in assets/preload/data/.
That should look like this:
`
bf
gf
dad
whitty
`

Add your icons in the directory `YourMod/assets/preload/images/icons/` with the name `icon-<char>.png`, replacing <char> with your character name (!!NOTE!! Use the SAME name you used in the .txt file).
It should look like this: `icon-whitty.png`
  
### Step 3. Adding Your Character
Scroll down to Line 26, or Search (Windows/Linux: `Ctrl+F`, Mac: `Cmd+F`) for "switch (curCharacter)". You should find a switch that looks like this:

---

```haxe
switch (curCharacter) {
			case 'gf':
				frames = Paths.getSparrowAtlas('characters/GF_assets', 'shared');
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');

				barColor = 0xFFA2044B;
			case 'dad':
				frames = Paths.getSparrowAtlas('characters/DADDY_DEAREST', 'shared');
				animation.addByPrefix('idle', 'Dad idle dance', 24);
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);

				addOffset('idle');
				addOffset("singUP", -6, 50);
				addOffset("singRIGHT", 0, 27);
				addOffset("singLEFT", -10, 10);
				addOffset("singDOWN", 0, -30);

				playAnim('idle');

				barColor = 0xFFaf66ce;
			case 'bf':
				frames = Paths.getSparrowAtlas('characters/BOYFRIEND', 'shared');

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);

				playAnim('idle');

				flipX = true;

				barColor = 0xFF31b0d1;
}
```

---

Add `case '<yourCharacter>':` after `barColor = 0xFF31b0d1;` (line 114), replacing <yourCharacter> with your characters name (!!NOTE!! Use the SAME name you used in the .txt file).
After, add directory to your character `frames = Paths.getSparrowAtlas('<path>', '<library>');`, replace <path> with your characters picture and XML name and replace <library> with library you used (`shared`, `preload`, etc.).
You'll get something like this: `frames = Paths.getSparrowAtlas('characters/whitty_assets', 'shared');`.
After, add all the animations like that: `animation.addByPrefix('<Name Used In The Game>', '<XML name>', <FPS>, false);`, raplacing <Name Used In The Game> with the anim name used in the code (`idle`, `singLEFT`, `singUP`, `singDOWN`, `singRIGHT`, etc.) and replacing <XML name> with the name of anim in XML file (name given in Adobe Animate or Adobe Flash).
We will skip setting offsets for now, so just do addOffset('<anim>');, replacing <anim> with animations you added before.
Add `playAnim('idle');`.
Also, add `flipX = true;` if the character should be flipped.
Add health bar color by using `barColor = <HEX Color>;`, replacing <HEX Color> with your color (0xFFFFFFFF(black), 0xFF000000(white), etc.).

This will look like that:

---

```haxe
case 'whitty':
	frames = Paths.getSparrowAtlas('characters/whitty_assets', 'shared');
	animation.addByPrefix('singLEFT', 'leftNote', 24, false);
	animation.addByPrefix('singRIGHT', 'rightNote', 24, false);
	animation.addByPrefix('singUP', 'upNote', 24, false);
  animation.addByPrefix('singDOWN', 'downNote', 24, false);
	animation.addByPrefix('idle', 'idleAnim', 24, false);

	addOffset("idle");
	addOffset("singUP");
	addOffset("singRIGHT");
	addOffset("singLEFT");
	addOffset("singDOWN");

	playAnim('idle');

	barColor = 0xFF040404;
```
 
---

### Step 4. Compile the game to fix offsets
After the game is compiled, go to Chart Editor by pressing 7 on any song and choose your character as player 2, or as player 1 if it should replace bf and press Enter.
Press 9 to use Animation Debug Menu.
Setup the character, press Crtl+S, and paste it instead of `addOffset();` lines.
It'll look like that:

---

```haxe
case 'whitty':
	frames = Paths.getSparrowAtlas('characters/whitty_assets', 'shared');
	animation.addByPrefix('singLEFT', 'leftNote', 24, false);
	animation.addByPrefix('singRIGHT', 'rightNote', 24, false);
	animation.addByPrefix('singUP', 'upNote', 24, false);
	animation.addByPrefix('singDOWN', 'downNote', 24, false);
	animation.addByPrefix('idle', 'idleAnim', 24, false);

  // paste it here
	addOffset("idle");
  addOffset("singUP", 50, 32);
	addOffset("singRIGHT", 37, 12);
	addOffset("singLEFT", -12, 52);
	addOffset("singDOWN", -63, 21);
  //

	playAnim('idle');

	barColor = 0xFF040404;
```
 
---

### Step 5. Setup Character and Camera Positions
If your character/camera is floating, or it's not in the place you want, you can fix it.

// Fixing Character position:
Go to PlayState.hx and scroll down to Line 270, or Search (Windows/Linux: `Ctrl+F`, Mac: `Cmd+F`) for "switch (SONG.player2)". You should find a switch that looks like this:

---

```haxe
switch (SONG.player2) {
	case 'gf':
		dad.setPosition(gf.x, gf.y);
		gf.visible = false;
		if (isStoryMode) {
			camPos.x += 600;
			tweenCamIn();
		}
	case 'dad':
		camPos.x += 400;
}
```

---

Add a new case, same way you did in Character.hx and change character position with 
`dad.x += or -= <amount>;` // left/right
`dad.y += or -= <amount>;` // up/down

It will look like this:

---

```haxe
switch (SONG.player2) {
	case 'gf':
		dad.setPosition(gf.x, gf.y);
		gf.visible = false;
		if (isStoryMode) {
			camPos.x += 600;
			tweenCamIn();
		}
	case 'dad':
		camPos.x += 400;
	case 'whitty':
		dad.x += 400;
		dad.y += 320;
}
```

---
// Fixing Camera position:
In the same case we added before add:
`camPos.x += or -= <amount>;` // left/right
`camPos.y += or -= <amount>;` // up/down

It will look like this:

---

```haxe
switch (SONG.player2) {
	case 'gf':
		dad.setPosition(gf.x, gf.y);
		gf.visible = false;
		if (isStoryMode) {
			camPos.x += 600;
			tweenCamIn();
		}
	case 'dad':
		camPos.x += 400;
	case 'whitty':
		dad.x += 400;
		dad.y += 320;

		camPos.x += 400;
		camPos.y += 200;
}
```

---
After, scroll down to Line 1013, or Search (Windows/Linux: `Ctrl+F`, Mac: `Cmd+F`) for "if (generatedMusic && PlayState.SONG.notes[Std.int(curStep / 16)] != null)". You should find an if() that looks like this:

---

```haxe
if (generatedMusic && PlayState.SONG.notes[Std.int(curStep / 16)] != null) {
	if (camFollow.x != dad.getMidpoint().x + 150 && !PlayState.SONG.notes[Std.int(curStep / 16)].mustHitSection) {
		var offsetX = 0;
		var offsetY = 0;
		camFollow.setPosition(dad.getMidpoint().x + 150 + offsetX, dad.getMidpoint().y - 100 + offsetY);
	}

	if (PlayState.SONG.notes[Std.int(curStep / 16)].mustHitSection && camFollow.x != boyfriend.getMidpoint().x - 100) {
		var offsetX = 0;
    var offsetY = 0;
	  camFollow.setPosition(boyfriend.getMidpoint().x - 100 + offsetX, boyfriend.getMidpoint().y - 100 + offsetY);
	}
}

```

---
If your character is BF use the second if() inside, if it's an opponent use the first.
Add a switch, with "SONG.player2" if it's an opponent or "SONG.player1" if it's a BF, a case '<yourCharacter>', and edit offsets by using `offsetX = 0;` and `offsetY = 0;`

It will look like that:

---

```haxe
if (generatedMusic && PlayState.SONG.notes[Std.int(curStep / 16)] != null) {
	if (camFollow.x != dad.getMidpoint().x + 150 && !PlayState.SONG.notes[Std.int(curStep / 16)].mustHitSection) {
		var offsetX = 0;
		var offsetY = 0;

    switch (SONG.player2) {
      case 'whitty':
        offsetX = 400;
		    offsetY = 200;
    }
		camFollow.setPosition(dad.getMidpoint().x + 150 + offsetX, dad.getMidpoint().y - 100 + offsetY);
	}

	if (PlayState.SONG.notes[Std.int(curStep / 16)].mustHitSection && camFollow.x != boyfriend.getMidpoint().x - 100) {
		var offsetX = 0;
    var offsetY = 0;
	  camFollow.setPosition(boyfriend.getMidpoint().x - 100 + offsetX, boyfriend.getMidpoint().y - 100 + offsetY);
	}
}

```

---


### Conclusion
Congratulations! If you followed all of the steps correctly, you have successfully created a new character in the game. You may use it in chart editor.
