if GetResourceState('ox_inventory') ~= 'started' then return end
local ox_inventory = exports.ox_inventory

inventory = {}

inventory.Search = function(item)
    local count = ox_inventory:Search('count', item)
    if count > 0 then
        return true
    end

    return false
end