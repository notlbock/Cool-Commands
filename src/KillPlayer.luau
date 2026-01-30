local module = {}

function module.kill(username)
	if typeof(username) == "string" then
		local character = workspace:FindFirstChild(username)
		if character then
			local humanoid = character:FindFirstChild("Humanoid")
			if humanoid and humanoid:IsA("Humanoid") then
				humanoid.Health = 0
			else
				print("Failed to find humanoid or wrong humanoid is a wrong class in " .. username)
			end
		else
			print("Failed to find playername: " .. username)
		end
	else
		print("!kill requires 1 argument")
	end
end

return module
