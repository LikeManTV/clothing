if GetResourceState('qb-inventory') ~= 'started' then return end
local qbinventory = exports['qb-inventory']

inventory = {}

inventory.AddItem = function(source, item, amount, metadata)
    local player = QBCore.Functions.GetPlayer(source)
    if metadata then
        player.Functions.AddItem(source, item, amount, metadata)
    else
        player.Functions.AddItem(source, item, amount)
    end
    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[item], "add")
end

inventory.RemoveItem = function(source, item, amount, metadata, slot)
    local player = QBCore.Functions.GetPlayer(source)
    player.Functions.RemoveItem(source, item, amount, metadata, slot)
    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[item], "remove")
end

inventory.GetSlot = function(source, slot)
    return qbinventory:GetItemBySlot(source, slot)
end

inventory.SetMetadata = function(source, slot, metadata)
    qbinventory:SetItemData(source, slot, 'label', metadata)
end

inventory.GetActiveInventory = function()
    return 'qb-inventory'
end