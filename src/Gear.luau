local module = {}
local InsertService = game:GetService("InsertService")

function assetExists(assetId)
	local success = pcall(function()
		InsertService:LoadAsset(assetId)
	end)

	return success
end

function module.gear(username, gearid)
	if typeof(username) == "string" and typeof(gearid) == "number" then
		if assetExists(gearid) then
			local player = game.Players:FindFirstChild(username)
			local gear = InsertService:LoadAsset(gearid):GetChildren()[1]
			if player then
				gear.Parent = player.Backpack
			else
				print("No such player: " .. username)
			end
		else
			print("No such asset id: " .. gearid)
			return
		end
	else
		print("Failed to load.")
		return
	end
end

return module
