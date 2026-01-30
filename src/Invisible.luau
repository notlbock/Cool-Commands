local module = {}

function module.invisible(username)
	if typeof(username) == "string" then
		local character = workspace:FindFirstChild(username)
		if character then
			for _, v in character:GetChildren() do
				if v:IsA("MeshPart") then
					v.Transparency = 1
				end
			end
		else
			print("No such player: " .. username)
		end
	else
		print("!invisible requires 1 argument")
	end
end

return module
