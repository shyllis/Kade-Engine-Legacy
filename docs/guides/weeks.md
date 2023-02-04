# Creating A Custom Week

## Requirements
1. The ability to compile Kade Engine Legacy from the source code. All information related to building Kade Engine Legacy is listed [here.](https://github.com/Goldie5fnf/Kade-Engine-Legacy/blob/main/docs/building.md)
2. A text editor. Some form of IDE that can support Haxe is recommended, such as Visual Studio Code.

---
### Step 1. Navigation
Navigate to your Kade Engine Legacy source code. In the `source` folder, look for `StoryMenuState.hx`. Open it in your text editor.

### Step 2. Songlist

Scroll down to Line 25, or Search (Windows/Linux: `Ctrl+F`, Mac: `Cmd+F`) for "weekData". You should find an Array that looks like this:

---

```haxe
var weekData:Array<Dynamic> = [
		
    ['Tutorial'],

    ['Bopeebo', 'Fresh', 'Dadbattle']

];
```

---

Copy `['Bopeebo', 'Fresh', 'Dadbattle']` into an empty line below it, and change the song names to the song names you want to use.
Don't forget to add a comma at the end of the previous Week, and you have your songlist for the week completed!

Example
---

---

```haxe
var weekData:Array<Dynamic> = [
		
    ['Tutorial'],
		
    ['Bopeebo', 'Fresh', 'Dadbattle'],
		
    ['Song1', 'Song2', 'Song3']
    
];
```
 
---
 
### Step 3. Week Characters
Directly below the songlist should be an Array titled `weekCharacters`. This array tells the game what characters to display in the top yellow bar when a certain week is selected.
It's not very useful unless you followed the Characters guide (will link to it once it's actually done). If you have, though, you can insert the name of your character into the first pair of quotes in a new "week". Example:

Example
---

---

```haxe
var weekCharacters:Array<Dynamic> = [
		
    ['', 'bf', 'gf'],
		
    ['dad', 'bf', 'gf'],

    ['customchar', 'bf', 'gf']
	
  ];
```

---

### Step 4. Week Names

Underneath the song list, there should be another array called `weekNames`. Creating a new line in that array, just enter a string that represents what you want the week to be called.

Example
---

---
```haxe
var weekNames:Array<String> = [
		
	"How to Funk",
		
	"Daddy dearest",

        "Epic rap battle!"

];
```

---
  
### Step 5. Graphics
  
Displaying a week icon for your custom week is as simple as dropping a .png into `assets/images/storymenu/weeks`. Rename the file to `week2.png`, `week3.png`, etc.

### Conclusion

If you followed all of the steps correctly, you have successfully created a new week in the Story Mode.
