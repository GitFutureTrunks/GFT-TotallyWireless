local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('justbiz:server:giveitem', function(item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem(item)
end)

RegisterServerEvent('justbiz:server:takeitem', function(item, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem(item, amount)
end)

RegisterServerEvent('justbiz:server:cash', function(amount)
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.AddMoney('cash', amount)
end)

RegisterServerEvent('justbiz:server:bank', function(amount)
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.AddMoney('bank', amount)
end)


QBCore.Functions.CreateCallback('justbiz:itemcheck', function(source, cb, item)
	local xPlayer = QBCore.Functions.GetPlayer(source)
    local itemcount = xPlayer.Functions.GetItemByName(item)
	if itemcount ~= nil then
		cb(true)
	else
        cb(false)
	end
end)
