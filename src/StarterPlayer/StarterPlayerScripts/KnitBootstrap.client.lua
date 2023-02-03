local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Load Kint:
local Knit = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"))
Knit.AddControllersDeep(script.Parent:WaitForChild("Controllers"))

-- Run knit:
local startTime = os.clock()
Knit.Start() -- { ServicePromises = false } if needed
:catch(function(err)
	warn("Knit framework errored: " .. tostring(err))
end)
:andThen(function()
	warn("[Client] Knit framework started in " .. tostring(os.clock() - startTime) .. " seconds.")
end)