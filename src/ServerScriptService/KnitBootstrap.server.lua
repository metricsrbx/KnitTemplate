local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Load Knit:
local Knit = require(ReplicatedStorage.Packages.Knit)
Knit.AddServicesDeep(script.Parent:WaitForChild("Services"))

-- Run Knit start:
local startTime = os.clock()
Knit.Start() -- { ServicePromises = false } if needed
:catch(function(errored)
	warn("Knit framework error: " .. tostring(errored))
end)
:andThen(function()
	warn("[Server] Knit framework started in " .. tostring(os.clock() - startTime) .. " seconds")
end)
