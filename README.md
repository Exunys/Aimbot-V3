# ☄️ Aimbot V3 [![Visitors](https://visitor-badge.laobi.icu/badge?page_id=Exunys.Aimbot-V3)](https://exunys.gitbook.io/aimbot-v3-documentation)

This project is a universal aim-locking module that works with all games using the default character. This version includes several improvements over [Aimbot V2](https://github.com/Exunys/Aimbot-V2), with key enhancements being optimization and numerous rewritten parts for maximum efficiency.

The source of this project is optimized, organized, and simplified to the highest level to ensure it is efficient, fast, stable, and precise.

This project is currently in beta testing. Feel free to create pull requests (you will be credited), report issues, or contact me through any of my linked platforms.

This module is used in [AirHub V2](https://github.com/Exunys/AirHub-V2). If you want to use it personally instead of integrating it for development purposes, I recommend using AirHub.

### 📜 License
This project is completely free and open source. However, that does not mean you own the rights to it. Please read this [document](https://github.com/Exunys/Aimbot-V3/blob/main/LICENSE) for more information.
You can reuse or integrate this script or any system from this project into your own repositories, as long as you credit the developer, [Exunys](https://github.com/Exunys) (me).

### ❗ Notice
This project has been written and tested with Synapse X and Electron. However, I will do my best to modularize support for every exploit. So far, the required functions for this module to run are listed below:

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

### The documentation for the interactive methods of this module can be found by clicking [here](https://exunys.gitbook.io/aimbot-v3-documentation/).

More detailed information for this project will be documented by time in this README.md document but mostly on the gitbook page.

# 👋 Introduction

First of all, to implement the module in your script's environment you must use the function `loadstring` like below:
```lua
local Aimbot = loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/Aimbot-V3/main/src/Aimbot.lua"))()
Aimbot.Load()
```

The code above loads the module's environment in your script executor's global environment meaning it will be achivable across every script.

The identificator for the environment is `ExunysDeveloperAimbot` which is a table that has configurable settings and interactive methods.

The table loaded into the exploit's global environment by the module has a [*metatable*](https://create.roblox.com/docs/scripting/luau/metatables) set to it with a **__call** metamethod, meaning you can call the table which would load the Aimbot.

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/Aimbot-V3/main/src/Aimbot.lua"))()()
```
or
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/Aimbot-V3/main/src/Aimbot.lua"))()
ExunysDeveloperAimbot()
```
This is equivalent to the `Load` method, which is a faster alternative for loading the module.
```lua
ExunysDeveloperAimbot.Load()
```

This module has customizable settings and other miscellaneous properties. You can see the configurable settings below.

<details> <summary> The module's configurable settings </summary>

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

		OffsetToMoveDirection = false, -- Prediction
		OffsetIncrement = 15, -- Min: 1; Max: 30 -- Amplitude

		Sensitivity = 0, -- Animation length (in seconds) before fully locking onto target / CFrame Sensitivity
		Sensitivity2 = 3.5, -- mousemoverel Sensitivity

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

### NOTE: Do not execute this code, it is attached here as an example, executing this would rewrite the environment and critical core data for the aimbot to function. Instead if you want to change some setting make sure you use the example below:

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/Aimbot-V3/main/src/Aimbot.lua"))()
ExunysDeveloperAimbot.Settings.Enabled = false
```

</details>

<details> <summary> Previews </summary>

### The video below showcases the stability and strength of the aim lock and how its perfect for HvH scenarios.

https://github.com/Exunys/Aimbot-V3/assets/76539058/408a4c1e-39fc-4499-9e1d-41aabd4429a0

### The videos below showcases the smoothness of the aim lock and its adjustable style engineered to assist for aiming in any type of game.

https://github.com/Exunys/Aimbot-V3/assets/76539058/8238183a-1594-4ca4-a146-c55c0cf76106

https://github.com/Exunys/Aimbot-V3/assets/76539058/b77fe625-aecc-41ed-9543-47460ca2703d

### The video below showcases the `Blacklist` and `Whitelist` methods.

https://github.com/Exunys/Aimbot-V3/assets/76539058/5e202703-d86d-4563-af52-f757e43fde39

</details>
