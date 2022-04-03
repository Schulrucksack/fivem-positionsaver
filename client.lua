
AddEventHandler('playerSpawned', function()
	TriggerServerEvent('century:spawnPlayer')
end)

RegisterNetEvent('century:lastPosition')
AddEventHandler('century:lastPosition', function(PosX, PosY, PosZ)
	Citizen.Wait(2000)
	SetEntityCoords(GetPlayerPed(-1), PosX, PosY, PosZ, 1, 0, 0, 1)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		LastX, LastY, LastZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
		TriggerServerEvent('century:saveLastPosition', LastX, LastY, LastZ)
	end
end)