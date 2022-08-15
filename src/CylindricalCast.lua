--[[
	
	Author : IdleBrick
	Contributors : Daw588, Sinlernick
--]]


local Workspace = game:GetService("Workspace")

local FULL_CIRCLE = 2 * math.pi
local CFRAME_ANGLES_AXIS_PI = CFrame.Angles(math.pi, 0, 0)

type ConfigType = {
	Quality : number,
	Size : Vector3,
	ThicknessQuality : number,
	Ignore : {Instance}
}

type SolverType = {
	Quality : number,
	Size : Vector3,
	ThicknessQuality : number,
	RaycastParams : RaycastParams
}


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
	self.Size = config.Size

	return self
end

function Solver:Solve(CF: CFrame): RaycastParams | nil
	local raycasts = table.create(self.ThicknessQuality)
	
	local i = 0
	
	for t = 1, self.ThicknessQuality do
		i = if i + 1 > self.Quality then self.Quality else i + 1 -- this is to avoid running two loops for no reason; two loops are O(n^2) in time complexity I believe
		
		local angle = i * (FULL_CIRCLE / self.Quality) -- (FULL_CIRCLE / self.Quality) this can be precomputed once the object has been created

		local ang = t * (FULL_CIRCLE / 3) -- (FULL_CIRCLE / 3) can be precomputed once the module has loaded to avoid computation in literal frames
		local newCFrame = (CF * CFrame.new(Vector3.yAxis * math.sin(ang) * (self.Size.X * 0.5)))

		local position = (newCFrame * CFrame.new(Vector3.new(math.cos(angle) * 0.1, 0, math.sin(angle) * 0.1))).Position
		local direction = (CFrame.new(position, newCFrame.Position) * CFRAME_ANGLES_AXIS_PI).LookVector

		local raycastResult = Workspace:Raycast(position, direction * ((self.Size.Y * 0.832) + 0.5), self.RaycastParams)
		
		
		if raycastResult then
			if raycastResult.Instance then
				table.insert(raycasts, raycastResult)  -- not too sure why this is here, you can just get the first ray that intersected with an object
				
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
