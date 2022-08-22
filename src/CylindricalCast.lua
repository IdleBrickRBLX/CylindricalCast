
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



local Solver = {}
Solver.__index = Solver

function Solver.new(config: ConfigType)
	local self = setmetatable(table.create(8) :: SolverType, Solver)

	local raycastParams = RaycastParams.new()
	raycastParams.FilterDescendantsInstances = config.Ignore
	raycastParams.FilterType = Enum.RaycastFilterType.Blacklist

	self.Size = config.Size
	self.RaycastParams = raycastParams
	self._Quality = config.Quality
	self._ThicknessQuality = config.ThicknessQuality
	self._CentreRadius = config.CentreRadius
	self._rays = table.create(self.ThicknessQuality * self.Quality)
	self._newCFrames = table.create(self.ThicknessQuality)
	self._positions = table.create(self.Quality)
	self._rayLength = (self.Size.Y * 0.832) + 0.5
	
	for i = 1, self.Quality do
		local angle = i * (FULL_CIRCLE /  self.Quality)
		table.insert(self._positions, CFrame.new(Vector3.new(math.cos(angle) * self.CentreRadius, 0, math.sin(angle) * self.CentreRadius)))
	end
	
	for t = 1, self.ThicknessQuality do
		table.insert(self._newCFrames, CFrame.new(Vector3.yAxis * math.sin( t * (FULL_CIRCLE / 3)) * (self.Size.X * 0.5)))
	end
	return self
end

function Solver:Solve(CF: CFrame): {RaycastResult | nil}
	local raycasts = self._rays
	local length = self._rayLength 
	
	table.clear(raycasts)

	for _, CFRAME in self._newCFrames do
		local newCFrame = (CF * CFRAME)
		
		for _, POSITION in self._positions do
			local position = (newCFrame * POSITION).Position
			local direction = (CFrame.new(position, newCFrame.Position) * CFRAME_ANGLES_AXIS_PI).LookVector

			local raycastResult = Workspace:Raycast(position, direction * length , self.RaycastParams)

			if raycastResult then
				table.insert(raycasts, raycastResult)
			end
		end
			
	end

	return raycasts
end

return Solver
