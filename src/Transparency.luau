local module = {}

function module.tp(username, tp)
	if typeof(username) == "string" then
		local character = workspace:FindFirstChild(username)
		if character then
			for _, v in character:GetChildren() do
				if v:IsA("MeshPart") then
					v.Transparency = tp
				end
			end
		else
			print("No such player: " .. username)
		end
	else
		print("!transparency requires 1 argument")
	end
end

return module
