<!-- Project Link References -->

[latest release]: https://github.com/IdleBrickRBLX/CylindricalCast/releases/latest
[library url]: https://www.roblox.com/library/5023525481
[docs]: https://idlebrickrblx.github.io/CylindricalCast/

<!-- Depends -->

[devhub/raycasts]: https://developer.roblox.com/en-us/api-reference/function/WorldRoot/Raycast
[rblx/CylindricalCast]: https://www.roblox.com/library/10540083895/CylindricalCast
[rblx/rojo]: https://www.roblox.com/library/6415005344/Rojo-7
[web/rojo]: https://rojo.space/

<!-- Images -->

[release]: https://img.shields.io/github/v/release/IdleBrickRBLX/CylindricalCast?label=latest+release&style=flat

[splash]: .github/Assets/cylindrical_splash.png

[![CylindricalCast][splash]][docs]

[![GitHub release (latest by date)][release]][latest release]

CylindricalCast is the only Open-Source solution to cylindrical casting tasks on Roblox. The API makes use of the updated Roblox [Raycast][devhub/raycasts] engine, It has a simple and easily readable API for casting cylinders!

## Installation

### Manual Installation

You can either take the toolbox [Asset][rblx/CylindricalCast] or download the latest [Release][latest release] and insert it into studio.

### [Rojo][web/rojo]

You can use git submodules to clone this repo into your project:

```sh
$ git submodule add https://github.com/IdleBrickRBLX/CylindricalCast packages/CylindricalCast
```

Once inserted, Sync Roblox Studio and Rojo using the Rojo studio [Plugin][rblx/rojo]

## Usage

```lua
local RunService = game:GetService("RunService")
local CylindricalCast = require(CylindricalCast_PATH_HERE)

local Cylinder = CylindricalCast.new({
        Quality = 30, -- The higher the quality the more precision you have. Recommended 15, 50
	CentreRadius = 0.1, -- Controls the Radius where the rays are emitted from
	Size = Vector3.new(1, 2, 2), -- (Thicknes, RadiusY, RadiusZ)
	Ignore = {},
	ThicknessQuality = 2 -- Quality on the X axis. Recommended 2, 3
})

RunService.RenderStepped:Connect(function()
    local yourCFrame = CFrame.new(0,5,0)

    Cylinder.Size = Vector3.new(1, 3, 3)
    Cylinder.RaycastParams.FilterDescendantsInstances = {}
    local Cast = Cylinder:Solve(yourCFrame)

    if Cast then
        print(Cast) -- Prints a table of what was hit
    end
end)
```

## Documentation

For a full overview of the API please head over to the [Docs][docs] website
