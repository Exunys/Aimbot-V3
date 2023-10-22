# ☄️ Aimbot V3 [![Visitors](https://visitor-badge.laobi.icu/badge?page_id=Exunys.Aimbot-V3)](https://exunys.gitbook.io/aimbot-v3-documentation)

This project is a universal aim-locking module. Works on all games which use the default character. This version has a couple of improvements from [Aimbot V2](https://github.com/Exunys/Aimbot-V2), one of the most important ones are optimization and a bunch of rewritten parts for maximal efficiency.

This project's source is optimized, organized and simplified to the maximal level to be executive, fast, stable and precise.

This project is in beta testing, feel free to create pull requests (you will get credited), issues or just contact me on any of my linked platforms.

This module is used in [AirHub V2](https://github.com/Exunys/AirHub-V2), if you want to use it to exploit for personal use instead of embedding for development purposes, I recommend you use AirHub.

### 📜 License
This project is completely free and open sourced. But, that does not mean you own rights to it. Read this [document](https://github.com/Exunys/Aimbot-V3/blob/main/LICENSE) for more information.
You can re-use / stitch this script or any system of this project into any of your repositories, as long as you credit the developer [Exunys](https://github.com/Exunys).

### ❗ Notice
This project has been written and tested with [Synapse X](https://x.synapse.to) and [Electron](https://ryos.lol) however, I will attempt my best to modulize support for every exploit. So far, the required functions for this module to run will be listed below:

<details> <summary> Dependencies (required functions & libraries): </summary>

- Libraries:
    - **Drawing**
        - Drawing.new *(function)*
        - Drawing.Fonts *(table)*
    - **debug**
        - debug.getupvalue *(function)*
    - **Input**
        - Input.MouseMove *(function)* - Alternative to **mousemoverel**

- Functions:
    - **getgenv**
    - **getrawmetatable**
    - **mousemoverel** / **Input.MouseMove**
</details>

# 📋 Documentation

### The documentation for the interactive functions of this module can be found by clicking [here](https://exunys.gitbook.io/aimbot-v3-documentation/) or at the following link:
### https://exunys.gitbook.io/aimbot-v3-documentation/

More detailed information for this project will be documented by time in this README.md document.

# 👋 Introduction

First of all, to implement the module in your script's environment you must use the function `loadstring` like below:
```lua
local Aimbot = loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/Aimbot-V3/main/src/Aimbot.lua"))()
Aimbot.Load()
```

The code above loads the module's environment in your script executor's global environment meaning it will be achivable across every script.

The identificator for the environment is `ExunysDeveloperAimbot` which is a table that has configurable settings and interactive user functions.

The table loaded into the exploit's global environment by the module has a [*metatable*](https://create.roblox.com/docs/scripting/luau/metatables) set to it with a **__call** metamethod, meaning you can call the table which would load the Aimbot.

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/Aimbot-V3/main/src/Aimbot.lua"))()()
```
or
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/Aimbot-V3/main/src/Aimbot.lua"))()
ExunysDeveloperAimbot()
```
This is equivalent to the `Load` function (which would be more optimized and faster).
```lua
ExunysDeveloperAimbot.Load()
```

This module has customizable settings and other miscellaneous properties. You can see the configurable settings below.

<details> <summary> The script's configurable settings </summary>

```lua
getgenv().ExunysDeveloperAimbot = {
	DeveloperSettings = {
		UpdateMode = "RenderStepped",
		TeamCheckOption = "TeamColor",
		RainbowSpeed = 1 -- Bigger = Slower
	},

	Settings = {
		Enabled = true,

		TeamCheck = false,
		AliveCheck = true,
		WallCheck = false,

		OffsetToMoveDirection = false,
		OffsetIncrement = 15, -- Min: 1; Max: 30

		Sensitivity = 0, -- Animation length (in seconds) before fully locking onto target
		Sensitivity2 = 3, -- mousemoverel Sensitivity

		LockMode = 1, -- 1 = CFrame; 2 = mousemoverel
		LockPart = "Head", -- Body part to lock on

		TriggerKey = Enum.UserInputType.MouseButton2,
		Toggle = false
	},

	FOVSettings = {
		Enabled = true,
		Visible = true,

		Radius = 90, -- Field Of View
		NumSides = 60,

		Thickness = 1,
		Transparency = 1,
		Filled = false,

		RainbowColor = false,
		RainbowOutlineColor = false,
		Color = Color3.fromRGB(255, 255, 255),
		OutlineColor = Color3.fromRGB(0, 0, 0),
		LockedColor = Color3.fromRGB(255, 150, 150)
	}
}
```

</details>

<details> <summary> Previews </summary>

### The video below shows how stable and strong the aim lock is and that It's perfect for HvH.

https://github.com/Exunys/Aimbot-V3/assets/76539058/408a4c1e-39fc-4499-9e1d-41aabd4429a0

### The videos below shows how smooth the aim lock is and that It's adjustable to assist for aiming in any type of game.

https://github.com/Exunys/Aimbot-V3/assets/76539058/8238183a-1594-4ca4-a146-c55c0cf76106

https://github.com/Exunys/Aimbot-V3/assets/76539058/b77fe625-aecc-41ed-9543-47460ca2703d

### The video below shows how the `Blacklist` and `Whitelist` functions work.

https://github.com/Exunys/Aimbot-V3/assets/76539058/5e202703-d86d-4563-af52-f757e43fde39

</details>

### GITBOOK DOCUMENTATION & MORE INFORMATION SOON...
