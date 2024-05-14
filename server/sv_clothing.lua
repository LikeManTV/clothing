-- █▀▀ █░█ █▀▀ █▄░█ ▀█▀ █▀
-- ██▄ ▀▄▀ ██▄ █░▀█ ░█░ ▄█

RegisterServerEvent('clothing:sv:giveOutfit', function(data, outfit)
    local source = source
    local gender = data.sex == 'Male' and _L('male_outfit') or _L('female_outfit')
    local metadata = {label = _L('default_outfit_label'), part = 'outfit', image = 'outfit', sex = data.sex, description = string.format('%s', gender)}

    if outfit then
        metadata = {label = outfit, part = 'outfit', image = 'outfit', sex = data.sex}
    end

    if Config.CreatedByDesc then
        local name = framework.getPlayerName(source)
        metadata['description'] = string.format('%s  \n%s', gender, _L('created_by')..' '..name)
    end

    if Config.MarkUnnamedOutfits then
        metadata['type'] = Config.MarkText
    end

    metadata.comps = {}
    metadata.props = {}
    for _,v in pairs(data.outfit.comps) do
        metadata.comps[v.index] = {}
        metadata.comps[v.index]['index'] = v.index
        metadata.comps[v.index]['drawable'] = v.drawable
        metadata.comps[v.index]['texture']  = v.texture
        metadata.comps[v.index]['palette']  = v.palette
    end
    for _,v in pairs(data.outfit.props) do
        metadata.props[v.index] = {}
        metadata.props[v.index]['index'] = v.index
        metadata.props[v.index]['drawable'] = v.drawable
        metadata.props[v.index]['texture']  = v.texture
    end
    Wait(100)

    inventory.AddItem(source, 'outfit', 1, metadata)
end)

RegisterServerEvent('clothing:sv:giveTorso', function(data)
    local source = source
    local gender = data.sex == 'Male' and _L('male_clothes') or _L('female_clothes')
    local metadata = {label = _L('top_label'), part = 'torso', image = 'shirt', sex = data.sex, description = string.format('%s', gender)}

    if Config.CreatedByDesc then
        local name = framework.getPlayerName(source)
        metadata['description'] = string.format('%s  \n%s', gender, _L('created_by')..' '..name)
    end
    
    for _,v in pairs(data.torso) do
        metadata[v.index] = {}
        metadata[v.index]['index'] = v.index
        metadata[v.index]['drawable'] = v.drawable
        metadata[v.index]['texture']  = v.texture
        metadata[v.index]['palette']  = v.palette
    end
    Wait(100)

    inventory.AddItem(source, 'clothes', 1, metadata)
end)

RegisterServerEvent('clothing:sv:giveClothes', function(data)
    local source = source
    local gender = data.sex == 'Male' and _L('male_clothes') or _L('female_clothes')
    local metadata = {part = 'clothes', sex = data.sex, description = string.format('%s', gender), index = data.index, drawable = data.drawable, texture = data.texture}

    if Config.CreatedByDesc then
        local name = framework.getPlayerName(source)
        metadata['description'] = string.format('%s  \n%s', gender, _L('created_by')..' '..name)
    end

    if Config.ClothingIdDesc then
        metadata['type'] = string.format('%s | %s', data.drawable, data.texture)
    end
    
    local items = {
        [1] = { label = _L('mask_label'), image = 'mask' },
        [3] = { label = _L('gloves_label'), image = 'gloves' },
        [4] = { label = _L('pants_label'), image = 'pants' },
        [5] = { label = _L('backpack_label'), image = 'bag' },
        [6] = { label = _L('shoes_label'), image = 'shoes' },
        [7] = { label = _L('chain_label'), image = 'chain' },
        [9] = { label = _L('vest_label'), image = 'armour' },
        [10] = { label = _L('badges_label'), image = 'badges' }
    }
    local mapping = items[data.index]

    if mapping then
        metadata['label'] = mapping.label
        metadata['image'] = mapping.image
        inventory.AddItem(source, 'clothes', 1, metadata)
    end
end)

RegisterServerEvent('clothing:sv:giveProp', function(data)
    local source = source
    local gender = data.sex == 'Male' and _L('male_prop') or _L('female_prop')
    local metadata = {part = 'prop', sex = data.sex, description = string.format('%s', gender), index = data.index, drawable = data.drawable, texture = data.texture}

    if Config.CreatedByDesc then
        local name = framework.getPlayerName(source)
        metadata['description'] = string.format('%s  \n%s', gender, _L('created_by')..' '..name)
    end

    if Config.ClothingIdDesc then
        metadata['type'] = string.format('%s | %s', data.drawable, data.texture)
    end

    local items = {
        [0] = { label = _L('hat_label'), image = 'hat' },
        [1] = { label = _L('glasses_label'), image = 'glasses' },
        [2] = { label = _L('earrings_label'), image = 'ears' },
        [6] = { label = _L('watch_label'), image = 'watch' },
        [7] = { label = _L('bracelet_label'), image = 'bracelet' }
    }
    local mapping = items[data.index]

    if mapping then
        metadata['label'] = mapping.label
        metadata['image'] = mapping.image
        inventory.AddItem(source, 'clothes', 1, metadata)
    end
end)

RegisterServerEvent('clothing:sv:removeItem', function(metadata, slot)
    local source = source
    inventory.RemoveItem(source, 'clothes', 1, metadata, slot)
end)

RegisterServerEvent('clothing:sv:requestOutfit', function(target)
    TriggerClientEvent('clothing:cl:requestOutfit', target)
end)

RegisterServerEvent('clothing:sv:tearClothes', function(slot)
    local source = source
    
    if Config.TearClothes then
        local progress = lib.callback.await('clothing:cl:tearingProgress', source, _L('tearing_clothes'), data.duration, 'amb@prop_human_parking_meter@male@base', 'base')
        if progress then
            local slotData = inventory.GetSlot(source, slot)

            if inventory.GetActiveInventory() == 'ox_inventory' then
                for _type, data in pairs(Config.Tearing) do
                    if slotData.metadata.part and slotData.metadata.part == _type then
                        inventory.RemoveItem(source, slotData.name, 1, slotData.metadata, slot)
                        inventory.AddItem(source, data.give, data.amount)
                    end
                end
            else
                for _type, data in pairs(Config.Tearing) do
                    if slotData.info.part and slotData.info.part == _type then
                        inventory.RemoveItem(source, slotData.name, 1, slotData.info, slot)
                        inventory.AddItem(source, data.give, data.amount)
                    end
                end
            end
        end
    end
end)

RegisterServerEvent('clothing:sv:renameOutfit', function(slot)
    if Config.OutfitRenaming then
        local source = source
        local slotData = inventory.GetSlot(source, slot)

        if inventory.GetActiveInventory() == 'ox_inventory' then
            local newName = lib.callback.await('clothing:cl:renameOutfit', source, slotData.metadata.label)
            TriggerClientEvent('ox_inventory:closeInventory', source)
            slotData.metadata.label = newName
            inventory.SetMetadata(source, slot, slotData.metadata)
        else
            local newName = lib.callback.await('clothing:cl:renameOutfit', source, slotData.label)
            inventory.SetMetadata(source, slot, newName)
        end
    end
end)
