if GetResourceState('es_extended') ~= 'started' then return end
ESX = exports.es_extended:getSharedObject()

local framework = {}

framework.getPlayerName = function(playerId)
    local player = ESX.GetPlayerFromId(playerId)

	if player then
		return player.getName()
	end

	return GetPlayerName(playerId)
end
