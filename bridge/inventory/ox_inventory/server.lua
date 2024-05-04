if GetResourceState('ox_inventory') ~= 'started' then return end
local ox_inventory = exports.ox_inventory

inventory = {}

inventory.AddItem = function(source, item, amount, metadata)
    if metadata then
        ox_inventory:AddItem(source, item, amount, metadata)
    else
        ox_inventory:AddItem(source, item, amount)
    end
end

inventory.RemoveItem = function(source, item, amount, metadata, slot)
    ox_inventory:RemoveItem(source, item, amount, metadata, slot)
end

inventory.GetSlot = function(source, slot)
    return ox_inventory:GetSlot(source, slot)
end

inventory.SetMetadata = function(source, slot, metadata)
    ox_inventory:SetMetadata(source, slot, metadata)
end

inventory.GetActiveInventory = function()
    return 'ox_inventory'
end