local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)


local CameraController = Knit.CreateController { Name = "CameraController" }

local RunService = game:GetService("RunService")
local Signal = require(Knit.Util.Signal)

CameraController.LockedChanged = Signal.new()
CameraController.RenderName = "CustomCamRender"
CameraController.Priority = Enum.RenderPriority.Camera.Value

function CameraController:LockTo(part)
	if (self.Locked) then return end -- Stop if already locked
	local cam = workspace.CurrentCamera
	self.Locked = true
	cam.CameraType = Enum.CameraType.Scriptable
	-- Bind to RenderStep:
	self.LockedChanged:Fire(true)
	RunService:BindToRenderStep(self.RenderName, self.Priority, function()
		cam.CFrame = part.CFrame * CFrame.new(0, 0, self.Distance)
	end)
end

function CameraController:Unlock()
	if (not self.Locked) then return end -- Stop if already unlocked
	local cam = workspace.CurrentCamera
	self.Locked = false
	cam.CameraType = Enum.CameraType.Custom
	self.LockedChanged:Fire(false)
	-- Unbind:
	RunService:UnbindFromRenderStep(self.RenderName)
end

function CameraController:KnitStart()
	print("CameraController KnitStart called")
end

function CameraController:KnitInit()
	print("CameraController KnitInit called")
end

CameraController.LockedChanged:Connect(function(isLocked)
	print(isLocked and "Camera is now locked" or "Camera was unlocked")
end)



return CameraController