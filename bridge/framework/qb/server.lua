if GetResourceState('qb-core') ~= 'started' then return end
QBCore = exports['qb-core']:GetCoreObject()

local framework = {}

framework.getPlayerName = function(playerId)
    local player = QBCore.Functions.GetPlayer(playerId)

	if player then
		return player.PlayerData.charinfo.firstname .. ' ' .. player.PlayerData.charinfo.lastname
	end

	return GetPlayerName(playerId)
end