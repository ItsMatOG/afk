RegisterServerEvent("ItsMatOG:afkKick")
AddEventHandler("ItsMatOG:afkKick", function()
	if IsPlayerAceAllowed(source, "ItsMatOG.AFKBypass") then
	else
		DropPlayer(source, "[AFK]: You were kicked for being AFK for too long.")
	end
end)