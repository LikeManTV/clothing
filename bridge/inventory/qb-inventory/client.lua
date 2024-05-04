if GetResourceState('qb-inventory') ~= 'started' then return end
local qbinventory = exports['qb-inventory']

inventory = {}

inventory.Search = function(item)
    return qbinventory:HasItem(item, 1)
end