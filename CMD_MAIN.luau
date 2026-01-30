-- CMD_MAIN

for _, r in pairs(script.Parent.rep:GetChildren()) do
	r.Parent = game.ReplicatedStorage
end

--[[
		Do we keep the bad !damage part, sure,
	it stinks though.
	- Edenns_altacc 01-30-2026 3:10-PM
]]

THING = "!" -- you shall not change the variable name from this
src = script.Parent:WaitForChild("src")
temp = script.Parent:WaitForChild("temp")
TeleportService = game:GetService("TeleportService") -- for !game
AUDIO_TEMP_FOLDER = temp:FindFirstChild("!audio")
SONGTEMPNUMBER = 1
KillPlayer = require(src.KillPlayer)
Invisible = require(src.Invisible)
Visible = require(src.Visible)
Damage = require(src.Damage)
Gear = require(src.Gear)
Transparency = require(src.Transparency)
Ghost = require(src.Ghost)
Teleport = require(src.Teleport)

function parseArgs(str)
	local args = {}
	for word in string.gmatch(str, "%S+") do
		table.insert(args, word)
	end
	return args
end

game.Players.PlayerAdded:Connect(function(plr)
	plr.Chatted:Connect(function(msg)
		local Args = parseArgs(msg)  -- Args[1] is the command
		
		-- Get ready to witness the longest if statement ever
		-- idk how to make it shorter
		
		if Args[1] == THING .. "kill" then
			if Args[2] == "me" then
				KillPlayer.kill(plr.Name)
			elseif Args[2] == "all" then
				for _, gbl_plr in pairs(game.Players:GetChildren()) do
					KillPlayer.kill(gbl_plr.Name)
				end
			else
				KillPlayer.kill(Args[2])
			end
		elseif Args[1] == THING .. "invisible" then
			if Args[2] == "me" then
				Invisible.invisible(plr.Name)
			elseif Args[2] == "all" then
				for _, gbl_plr in pairs(game.Players:GetChildren()) do
					Invisible.invisible(gbl_plr.Name)
				end
			else
				Invisible.invisible(Args[2])
			end
		elseif Args[1] == THING .. "visible" then
			if Args[2] == "me" then
				Visible.visible(plr.Name)
			elseif Args[2] == "all" then
				for _, gbl_plr in pairs(game.Players:GetChildren()) do
					Visible.visible(gbl_plr.Name)
				end
			else
				Visible.visible(Args[2])
			end
		elseif Args[1] == THING .. "damage" then
			if Args[2] == "me" then
				if tonumber(Args[3]) then
					Damage.damage(plr.Name, tonumber(Args[3]))
				else
					print("Second argument should be a number")
				end
			elseif Args[2] == "all" then
				if tonumber(Args[3]) then
					for _, gbl_plr in pairs(game.Players:GetChildren()) do
						Damage.damage(gbl_plr.Name, tonumber(Args[3]))
					end
				else
					print("Second argument should be a number")
				end
			else
				if tonumber(Args[3]) then
					Damage.damage(Args[2], Args[3])
				else
					print("Second argument should be a number")
				end
			end
		elseif Args[1] == THING .. "sword" then
			-- We dont make a module for sword, right?
			local sword = game.ReplicatedStorage:WaitForChild("Sword")
			if Args[2] == "me" then
				local sword_clone = sword:Clone()
				sword_clone.Parent = plr.Backpack
			elseif Args[2] == "all" then
				for _, glb_plr in pairs(game.Players:GetChildren()) do
					local sword_clone = sword:Clone()
					sword_clone.Parent = glb_plr.Backpack
				end
			else
				local sword_clone = sword:Clone()
				local lcl_plr = game.Players:FindFirstChild(Args[2])
				if lcl_plr then
					sword_clone.Parent = lcl_plr.Backpack
				else
					print("No such player " .. Args[2])
				end
			end
		elseif Args[1] == THING .. "gear" then
			if tonumber(Args[3]) then
				if Args[2] == "me" then
					Gear.gear(plr.Name, tonumber(Args[3]))
				elseif Args[2] == "all" then
					for _, gbl_plr in pairs(game.Players:GetChildren()) do
						Gear.gear(gbl_plr.Name, tonumber(Args[3]))
					end
				else
					Gear.gear(Args[2], tonumber(Args[3]))
				end
			else
				print("No such ID: " .. Args[3])
			end
		elseif Args[1] == THING .. "transparency" then
			if tonumber(Args[3]) then
				if Args[2] == "me" then
					Transparency.tp(plr.Name, tonumber(Args[3]))
				elseif Args[2] == "all" then
					for _, gbl_plr in pairs(game.Players:GetChildren()) do
						Transparency.tp(gbl_plr.Name, tonumber(Args[3]))
					end
				else
					Transparency.tp(Args[2], tonumber(Args[3]))
				end
			else
				print("Second argument expects a number.")
			end
		elseif Args[1] == THING .. "ghost" then
			if Args[2] == "me" then
				Ghost.ghost(plr.Name)
			elseif Args[2] == "all" then
				for _, gbl_plr in pairs(game.Players:GetChildren()) do
					Ghost.ghost(gbl_plr.Name)
				end
			else
				Ghost.ghost(Args[2])
			end
		elseif Args[1] == THING .. "audio" then
			--[[
			SINCE IM BAD AT PROGRAMMING NO TEMP AUDIO WILL BE REMOVED SINCE IDK HOW
			]]
			if tonumber(Args[2]) then
				local SOUNDASSET = "rbxassetid://" .. Args[2]
				local SOUND = Instance.new("Sound", AUDIO_TEMP_FOLDER)
				SOUND.SoundId = SOUNDASSET
				SOUND.Name = "sound_temp_" .. tostring(SONGTEMPNUMBER)
				SONGTEMPNUMBER += 1
				SOUND:Play()
			else
				print("First argument expects a number.")
			end
		elseif Args[1] == THING .. "teleport" then
			if tonumber(Args[3]) then
				if Args[2] == "me" then
					TeleportService:Teleport(tonumber(Args[3]), plr)
				elseif Args[2] == "all" then
					for _, gbl_plr in pairs(game.Players:GetChildren()) do
						TeleportService:Teleport(tonumber(Args[3]), gbl_plr)
					end
				else
					local lcl_plr = game.Players:FindFirstChild(Args[2])
					if lcl_plr then
						TeleportService:Teleport(tonumber(Args[3]), lcl_plr)
					else
						print("No such username: " .. Args[2])
					end
				end
			else
				print("Second argument expects a number.")
			end
		elseif Args[1] == THING .. "speed" then
			if tonumber(Args[3]) then
				if Args[2] == "me" then
					local character = plr.Character
					if not character then return end
					local humanoid = character:FindFirstChild("Humanoid")
					if not humanoid then return end
					humanoid.WalkSpeed = tonumber(Args[3])
				elseif Args[2] == "all" then
					for _, gbl_plr in pairs(game.Players:GetChildren()) do
						local character = gbl_plr.Character
						if not character then return end
						local humanoid = character:FindFirstChild("Humanoid")
						if not humanoid then return end
						humanoid.WalkSpeed = tonumber(Args[3])
					end
				else
					local character = workspace:FindFirstChild(Args[2])
					if not character then print("No such username: " .. Args[2]) return end
					local humanoid = character:FindFirstChild("Humanoid")
					if not humanoid then return end
					humanoid.WalkSpeed = tonumber(Args[3])
				end
			else
				print("Second argument expects a number.")
			end
		elseif Args[1] == THING .. "jump" then
			if tonumber(Args[3]) then
				if Args[2] == "me" then
					local character = plr.Character
					if not character then return end
					local humanoid = character:FindFirstChild("Humanoid")
					if not humanoid then return end
					humanoid.JumpHeight = tonumber(Args[3])
				elseif Args[2] == "all" then
					for _, gbl_plr in pairs(game.Players:GetChildren()) do
						local character = gbl_plr.Character
						if not character then return end
						local humanoid = character:FindFirstChild("Humanoid")
						if not humanoid then return end
						humanoid.JumpHeight = tonumber(Args[3])
					end
				else
					local character = workspace:FindFirstChild(Args[2])
					if not character then print("No such username: " .. Args[2]) return end
					local humanoid = character:FindFirstChild("Humanoid")
					if not humanoid then return end
					humanoid.JumpHeight = tonumber(Args[3])
				end
			else
				print("Second argument expects a number.")
			end
		elseif Args[1] == THING .. "tp" or Args[1] == THING .. "teleport" then
			if Args[2] == "me" then
				Teleport.tp(plr.Name, Args[3])
			elseif Args[2] == "all" then
				for _, gbl_plr in pairs(game.Players:GetChildren()) do
					Teleport.tp(gbl_plr.Name, Args[3])
				end
			else
				Teleport.tp(Args[2], Args[3])
			end
		elseif Args[1] == THING .. "game" then
			if tonumber(Args[3]) then
				if Args[2] == "me" then
					TeleportService:Teleport(tonumber(Args[3]), plr)
				elseif Args[2] == "all" then
					for _, gbl_plr in pairs(game.Players:GetChildren()) do
						TeleportService:Teleport(tonumber(Args[3]), gbl_plr)
					end
				else
					local lcl_plr = game.Players:FindFirstChild(Args[2])
					if not lcl_plr then print("No such username: " .. Args[2]) return end
					TeleportService:Teleport(tonumber(Args[3]), lcl_plr)
				end
			else
				print("Second argument expects a number.")
			end
		elseif Args[1] == THING .. "" then
		end
	end)
end)
