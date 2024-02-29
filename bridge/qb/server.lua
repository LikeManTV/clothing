if GetResourceState('qb-core') ~= 'started' then return end
QBCore = exports['qb-core']:GetCoreObject()

function getPlayerName(playerId)
    local player = QBCore.Functions.GetPlayer(playerId)

	if player then
		return player.firstname .. ' ' .. player.lastname
	end

	return GetPlayerName(playerId)
end
