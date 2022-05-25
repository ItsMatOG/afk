local imnotafk = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if not imnotafk then
			Citizen.Wait(1000)
			playerPed = GetPlayerPed(-1)
			if playerPed then
				currentPos = GetEntityCoords(playerPed, true)
				if currentPos == prevPos and not imnotafk then
					if time > 0 then
						if time == math.ceil(900 / 4) then
							DisplayHelpText("~b~[AFK]: ~w~You will be ~r~kicked~w~ in ~y~" .. time .. " seconds  ~w~for being AFK.")
						end
						time = time - 1
					else
						TriggerServerEvent("ItsMatOG:afkKick")
					end
				else
					time = 900
				end
				prevPos = currentPos
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if imnotafk then
			Citizen.Wait(3600000)
			TriggerEvent('ItsMatOG:setNotAFK', false)
			ShowNotification('~w~Not AFK has been ~r~disabled.')
			time = 900
		end
	end
end)

AddEventHandler('playerDropped', function(source)
	TriggerEvent('ItsMatOG:setNotAFK', false)
	time = 900
end)

RegisterNetEvent('ItsMatOG:setNotAFK')
AddEventHandler('ItsMatOG:setNotAFK', function(toggle)
    imnotafk = toggle
end)

RegisterCommand('imnotafk', function()
	if imnotafk then
        TriggerEvent('ItsMatOG:setNotAFK', false)
        ShowNotification('~w~Not AFK has been ~r~disabled.')
		imnotafk = false
		time = 900
	elseif not imnotafk then
		TriggerEvent('ItsMatOG:setNotAFK', true)
        ShowNotification('~w~You have been set as ~g~not afk ~w~for ~y~60 minutes~w~.')
		imnotafk = true
	end
end, false)
TriggerEvent("chat:addSuggestion", "/imnotafk", "Set yourself as not AFK for 60 minutes.")

function DisplayHelpText(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end