# How to build Kade Engine Legacy

**Note**: You should be familiar with the commandline. If not, read this [quick guide by ninjamuffin](https://ninjamuffin99.newgrounds.com/news/post/1090480).

**Another note**: To build for *Windows*, you need to be on *Windows*. To build for *Linux*, you need to be on *Linux*. Same goes for macOS. You can build for html5/browsers/android on any platform.

## Dependencies
 1. [Install Haxe](https://haxe.org/download/).
 2. After, install `git`.
	 - Windows: install from the [git-scm](https://git-scm.com/downloads) website.
	 - Linux: install the `git` package: `sudo apt install git` (ubuntu), `sudo pacman -S git` (arch), etc... (you probably already have it)
 3. So, you installed stuff. Now you need to install all the the necessary libraries:
	 - `haxelib install lime`
	 - `haxelib install openfl`
	 - `haxelib install flixel`
	 - `haxelib run lime setup`
	 - `haxelib run lime setup flixel`
	 - `haxelib install flixel-tools`
	 - `haxelib run flixel-tools setup`
	 - `haxelib install flixel-addons`
	 - `haxelib install flixel-ui`
	 - `haxelib install hscript`
	 - `haxelib install linc_luajit`
	 - `haxelib install hxCodec`
	 - `haxelib git faxe https://github.com/uhrobots/faxe`
	 - `haxelib git discord_rpc https://github.com/Aidan63/linc_discord-rpc`

### Windows-only dependencies (only for building *to* Windows. Building html5 on Windows does not require this)
If you are planning to build for Windows, you also need to install **Visual Studio 2019**.
While installing it, *don't click on any of the options to install workloads*. Instead, go to the **individual components** tab and choose the following:
-   MSVC v142 - VS 2019 C++ x64/x86 build tools
-   Windows SDK (10.0.18362.0)

### macOS-only dependencies (these are required for building on macOS at all, including html5.)
If you are running macOS, you'll need to install Xcode. You can download it from the macOS App Store or from the [Xcode website](https://developer.apple.com/xcode/).

If you get an error telling you that you need a newer macOS version, you need to download an older version of Xcode from the [More Software Downloads](https://developer.apple.com/download/more/) section of the Apple Developer website. (You can check which version of Xcode you need for your macOS version on [Wikipedia's comparison table (in the `min macOS to run` column)](https://en.wikipedia.org/wiki/Xcode#Version_comparison_table).)

## Cloning the repository

### 1st Method
We'll use `git`, that we intalled in the previous step, to clone the repository.
1. Open Terminal.
2. `cd` to where you want to store the source code (i.e. `C:\Users\username\Desktop` or `~\Desktop`).
3. `git clone (https://github.com/Goldie5fnf/Kade-Engine-Legacy.git`.
4. `cd` into the source code: `cd Kade-Engine`.
5. (optional) If you want to build a specific version of Kade Engine, you can use `git checkout` to switch to it (i.e. `git checkout 1.4-KE`) (remember that versions 1.4 and older cannot build to Linux or HTML5)

**Note**: You should **not** do this if you are planning to contribute the engine.

### 2nd Method
If you have installed `Github Desktop`, you can clone repository with it.
1. Open the `Github Desktop`.
2. Press `Ctrl+Shift+O` and choose `URl`.
3. Paste `https://github.com/Goldie5fnf/Kade-Engine-Legacy/` and choose the path it's going to be.

### 3rd Method
Just download source code from [Github](https://github.com/Goldie5fnf/Kade-Engine-Legacy/), and put it in the folder you want.

**Note**: You can upload the source code on Github with the website or `Github Desktop`

## Building
So, we can build the game for now

- Run `lime build <target>`, replacing `<target>` with the platform you want to build to (`windows`, `mac`, `linux`, `html5`) (i.e. `lime build windows`)
- The build will be in `ModFolder/export/<target>/bin`, `<target>` will be the platform you built the game for. (i.e. `'ModFolder/export/windows/bin`)
- Only the `bin` folder is necessary to run the game. The other ones in `export/<target>` are not.

**Note**: if you want to build the game faster, delete ONLY `bin` folder before building.
