# Documentation
[rblx/RaycastResult]: https://developer.roblox.com/en-us/api-reference/datatype/RaycastResult
[rblx/Metatable]: https://developer.roblox.com/en-us/articles/Metatables

## `CylindricalCast.new()`

---

Creates a new CylindricalCast config. Returns [Metatable][rblx/Metatable]
### Syntax

`CylindricalCast.new(config: type({Quality : number, Size : Vector3, CentreRadius : number, ThicknessQuality : number, Ignore : {Instance}}))`

## `CylindricalCast:Solve()`

---

Casts the cylinder. Returns [RaycastResult][rblx/RaycastResult]
### Syntax

`CylindricalCast:Solve(CF: CFrame): RaycastParams | nil`
