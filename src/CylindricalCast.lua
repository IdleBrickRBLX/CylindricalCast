local Workspace = game:GetService("Workspace")

local FULL_CIRCLE = 2 * math.pi
local CFRAME_ANGLES_AXIS_PI = CFrame.Angles(math.pi, 0, 0)

type ConfigType = {
	Quality : number,
	Size : Vector3,
	ThicknessQuality : number,
	CentreRadius : number,
	Ignore : {Instance}
}

type SolverType = {
	Quality : number,
	Size : Vector3,
	ThicknessQuality : number,
	CentreRadius : number,
	RaycastParams : RaycastParams
}

--[[
	
	Author : IdleBrick
	Contributors : Daw588

--]]

local Solver = {}
Solver.__index = Solver

function Solver.new(config: ConfigType)
	local self = setmetatable({} :: SolverType, Solver)

	local raycastParams = RaycastParams.new()
	raycastParams.FilterDescendantsInstances = config.Ignore
	raycastParams.FilterType = Enum.RaycastFilterType.Blacklist

	self.RaycastParams = raycastParams
	self.Quality = config.Quality
	self.ThicknessQuality = config.ThicknessQuality
	self.CentreRadius = config.CentreRadius
	self.Size = config.Size

	return self
end

function Solver:Solve(CF: CFrame): RaycastParams | nil
	local raycasts = {}

	for t,_ in pairs(table.create(self.ThicknessQuality, "")) do
		for i,_ in pairs(table.create(self.Quality, "")) do
			local angle = i * (FULL_CIRCLE / self.Quality)

			local ang = t * (FULL_CIRCLE / 3)
			local newCFrame = (CF * CFrame.new(Vector3.yAxis * math.sin(ang) * (self.Size.X * 0.5)))

			local position = (newCFrame * CFrame.new(Vector3.new(math.cos(angle) * self.CentreRadius, 0, math.sin(angle) * self.CentreRadius))).Position
			local direction = (CFrame.new(position, newCFrame.Position) * CFRAME_ANGLES_AXIS_PI).LookVector

			local raycastResult = Workspace:Raycast(position, direction * ((self.Size.Y * 0.832) + 0.5), self.RaycastParams)

			if raycastResult then
				if raycastResult.Instance then
					table.insert(raycasts, raycastResult)
				end
			end
		end
	end

	if next(raycasts) then
		table.sort(raycasts, function(a, b)
			return (a.Position - CF.Position).Magnitude < (b.Position - CF.Position).Magnitude
		end)
		return raycasts[1]
	end

	return nil
end

return Solver
