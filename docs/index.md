[devhub/raycasts]: https://developer.roblox.com/en-us/api-reference/function/WorldRoot/Raycast
[devhub/replicatedstorage]: https://developer.roblox.com/en-us/api-reference/class/ReplicatedStorage

[rblx/CylindricalCast]: https://www.roblox.com/library/10540083895/CylindricalCast
[rblx/rojo]: https://www.roblox.com/library/6415005344/Rojo-7
[web/rojo]: https://rojo.space/

[latest release]: https://github.com/IdleBrickRBLX/CylindricalCast/releases/latest

# CylindricalCast

CylindricalCast is the only Open-Source solution to cylindrical casting tasks on Roblox. The API makes use of the updated Roblox [Raycast][devhub/raycasts] engine, It has a simple and easily readable API for casting cylinders!

## Getting Started

It's simple to start using CylindricalCast in your projects:

!!! note "Tip"

    It's best if you place the module somewhere like [ReplicatedStorage][devhub/replicatedstorage] because you can use it both on the client and server!

## Manual Installation

You can either take the toolbox [Asset][rblx/CylindricalCast] or download the latest [Release][latest release] and insert it into studio.

### [Rojo Installation][web/rojo]

You can use git submodules to clone this repo into your project:

```sh
$ git submodule add https://github.com/IdleBrickRBLX/CylindricalCast packages/CylindricalCast
```

Once inserted, Sync Roblox Studio and Rojo using the Rojo studio [Plugin][rblx/rojo]

## Example

```lua
local RunService = game:GetService("RunService")
local CylindricalCast = require(CylindricalCast_PATH_HERE)

local Cylinder = CylindricalCast.new({
    Quality = 30, -- The higher the quality the more precision you have. Recommended 15, 50
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
        print(Cast.Instance)
        print(Cast.Position)
    end
end)
```
