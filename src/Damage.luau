local module = {}

function module.damage(username, damage)
	if typeof(username) == "string" then
		local character = workspace:FindFirstChild(username)
		if character then
			local humanoid = character:FindFirstChild("Humanoid")
			if humanoid and humanoid:IsA("Humanoid") then
				humanoid.Health -= damage
			else
				print("Failed to find humanoid or wrong humanoid is a wrong class in " .. username)
			end
		else
			print("Failed to find playername: " .. username)
		end
	else
		print("!damage requires 1 argument")
	end
end

return module
