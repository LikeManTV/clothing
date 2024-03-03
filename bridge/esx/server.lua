if GetResourceState('es_extended') ~= 'started' then return end
ESX = exports.es_extended:getSharedObject()

function getPlayerName(playerId)
    local player = ESX.GetPlayerFromId(playerId)

	if player then
		return player.getName()
	end

	return GetPlayerName(playerId)
end
