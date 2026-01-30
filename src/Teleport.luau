local Players = game:GetService("Players")

local module = {}

function module.tp(username1, username2)
	local plr1 = Players:FindFirstChild(username1)
	local plr2 = Players:FindFirstChild(username2)
	if not plr1 or not plr2 then
		print("No such player.")
		return
	end
	local char1 = plr1.Character
	local char2 = plr2.Character
	if not char1 or not char2 then
		print("One or both players have no character.")
		return
	end
	local hrp1 = char1:FindFirstChild("HumanoidRootPart")
	local hrp2 = char2:FindFirstChild("HumanoidRootPart")
	if not hrp1 or not hrp2 then
		print("Missing HumanoidRootPart.")
		return
	end
	hrp1.CFrame = hrp2.CFrame
end

return module
