local module = {}

function module.ghost(username)
	if typeof(username) == "string" then
		local character = workspace:FindFirstChild(username)
		if character then
			for _, v in character:GetChildren() do
				if v:IsA("MeshPart") then
					v.Transparency = 0.5
					v.Color = Color3.fromRGB(255,255,255)
				end
			end
		else
			print("No such player: " .. username)
		end
	else
		print("!ghost requires 1 argument")
	end
end

return module
