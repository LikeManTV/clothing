local inventory = exports.ox_inventory

local skinchanger = GetResourceState('skinchanger'):find('start')
local esx_skin = GetResourceState('esx_skin'):find('start')
local ox_appearance = GetResourceState('ox_appearance'):find('start')
local fivem_appearance = GetResourceState('fivem-appearance'):find('start')
local illenium_appearance = GetResourceState('illenium-appearance'):find('start')
local qb_clothing = GetResourceState('qb-clothing'):find('start')

local faceFeatures = {}
local currentHair = nil

-- █▀▄▀█ █▀▀ █▄░█ █░█
-- █░▀░█ ██▄ █░▀█ █▄█

local categories = {}
if Config.Menu.outfit then
    if Config.UseRadial then
        categories[#categories+1] = {
            label = _L('take_off_outfit'),
            icon = 'shirt',
            onSelect = function()
                TriggerEvent('clothing:cl:handleOutfit')
            end
        }
    else
        categories[#categories+1] = {
            title = _L('take_off_outfit'),
            icon = 'shirt',
            event = 'clothing:cl:handleOutfit'
        }
    end
end
if Config.Menu.outfitOther then
    if Config.UseRadial then
        categories[#categories+1] = {
            label = _L('take_off_outfit_other'),
            icon = 'shirt',
            onSelect = function()
                TriggerEvent('clothing:cl:handleOutfitPlayer')
            end
        }
    else
        categories[#categories+1] = {
            title = _L('take_off_outfit_other'),
            icon = 'shirt',
            event = 'clothing:cl:handleOutfitPlayer'
        }
    end
end
if Config.Menu.clothes.enabled then
    if Config.UseRadial then
        categories[#categories+1] = {
            label = _L('take_off_clothes'),
            icon = 'shirt',
            menu = 'clothing_menu-clothes',
        }
    else
        categories[#categories+1] = {
            title = _L('take_off_clothes'),
            icon = 'shirt',
            menu = 'clothing_menu-clothes',
            arrow = true
        }
    end
end
if Config.Menu.props.enabled then
    if Config.UseRadial then
        categories[#categories+1] = {
            label = _L('take_off_props'),
            icon = 'shirt',
            menu = 'clothing_menu-props',
        }
    else
        categories[#categories+1] = {
            title = _L('take_off_props'),
            icon = 'shirt',
            menu = 'clothing_menu-props',
            arrow = true
        }
    end
end

local cOptions = {}
local clothesData = Config.Menu.clothes.options
for i = 1, 10 do
    local data = clothesData[i]
    if data and i ~= 2 then
        if i == 5 and Config.AutomaticBackpack then
           goto continue 
        end

        if Config.UseRadial then
            cOptions[#cOptions+1] = {
                label = _L(data.title),
                icon = data.icon,
                onSelect = function()
                    TriggerEvent('clothing:cl:handleClothes', {index = i})
                end
            }
        else
            cOptions[#cOptions+1] = {
                title = _L(data.title),
                icon = data.icon,
                onSelect = function()
                    TriggerEvent('clothing:cl:handleClothes', {index = i})
                end
            }
        end
    end
    ::continue::
end

local pOptions = {}
local propData = Config.Menu.props.options
for i = 0, 2 do
    local data = propData[i]
    if data then
        if Config.UseRadial then
            pOptions[#pOptions+1] = {
                label = _L(data.title),
                icon = data.icon,
                event = 'clothing:cl:handleProps',
                args = {index = i}
            }
        else
            pOptions[#pOptions+1] = {
                title = _L(data.title),
                icon = data.icon,
                event = 'clothing:cl:handleProps',
                args = {index = i}
            }
        end
    end
end
for i = 6, 7 do
    local data = propData[i]
    if data then
        if Config.UseRadial then
            pOptions[#pOptions+1] = {
                label = _L(data.title),
                icon = data.icon,
                event = 'clothing:cl:handleProps',
                args = {index = i}
            }
        else
            pOptions[#pOptions+1] = {
                title = _L(data.title),
                icon = data.icon,
                event = 'clothing:cl:handleProps',
                args = {index = i}
            }
        end
    end
end

if Config.UseRadial then
    lib.registerRadial({
        id = 'clothing_menu',
        items = categories
    })
    lib.registerRadial({
        id = 'clothing_menu-clothes',
        items = cOptions
    })
    lib.registerRadial({
        id = 'clothing_menu-props',
        items = pOptions
    })
else
    lib.registerContext({
        id = 'clothing_menu',
        title = _L('menu_title'),
        menu = 'personal_menu',
        onExit = function()
            clothing.saveClothes()
        end,
        options = categories,
        {
            id = 'clothing_menu-clothes',
            title = _L('menu_clothing_title'),
            menu = 'clothing_menu',
            options = cOptions
        },
        {
            id = 'clothing_menu-props',
            title = _L('menu_props_title'),
            menu = 'clothing_menu',
            options = pOptions
        }
    })
end

RegisterCommand('clothing', function()
    if Config.UseRadial then return end
    lib.showContext('clothing_menu')
end)

if Config.MenuKey then
    lib.addKeybind({
        name = 'clothing',
        description = _L('menu_title'),
        defaultKey = Config.MenuKey,
        onPressed = function(self)
            lib.showContext('clothing_menu')
        end
    })
end

-- Commands
if Config.EnableCommands then
    RegisterCommand('outfit', function() TriggerEvent('clothing:cl:handleOutfit') end)
    RegisterCommand('mask', function() TriggerEvent('clothing:cl:handleClothes', {index = 1}) end)
    RegisterCommand('gloves', function() TriggerEvent('clothing:cl:handleClothes', {index = 3}) end)
    RegisterCommand('pants', function() TriggerEvent('clothing:cl:handleClothes', {index = 4}) end)
    if not Config.AutomaticBackpack then
        RegisterCommand('backpack', function() TriggerEvent('clothing:cl:handleClothes', {index = 5}) end)
        RegisterCommand('bag', function() TriggerEvent('clothing:cl:handleClothes', {index = 5}) end)
    end
    RegisterCommand('shoes', function() TriggerEvent('clothing:cl:handleClothes', {index = 6}) end)
    RegisterCommand('chain', function() TriggerEvent('clothing:cl:handleClothes', {index = 7}) end)
    RegisterCommand('top', function() TriggerEvent('clothing:cl:handleClothes', {index = 8}) end)
    RegisterCommand('shirt', function() TriggerEvent('clothing:cl:handleClothes', {index = 8}) end)
    RegisterCommand('vest', function() TriggerEvent('clothing:cl:handleClothes', {index = 9}) end)
    RegisterCommand('badges', function() TriggerEvent('clothing:cl:handleClothes', {index = 10}) end)
    RegisterCommand('decals', function() TriggerEvent('clothing:cl:handleClothes', {index = 10}) end)
    RegisterCommand('jacket', function() TriggerEvent('clothing:cl:handleClothes', {index = 11}) end)

    RegisterCommand('hat', function() TriggerEvent('clothing:cl:handleProps', {index = 0}) end)
    RegisterCommand('glasses', function() TriggerEvent('clothing:cl:handleProps', {index = 1}) end)
    RegisterCommand('earrings', function() TriggerEvent('clothing:cl:handleProps', {index = 2}) end)
    RegisterCommand('watch', function() TriggerEvent('clothing:cl:handleProps', {index = 6}) end)
    RegisterCommand('bracelet', function() TriggerEvent('clothing:cl:handleProps', {index = 7}) end)
end

-- █▀▀ █░█ █▀▀ █▄░█ ▀█▀ █▀
-- ██▄ ▀▄▀ ██▄ █░▀█ ░█░ ▄█

-- Undress handling
RegisterNetEvent('clothing:cl:handleOutfit', function()
    clothing.handleUndress('outfit', false)
    clothing.saveClothes()
end)

RegisterNetEvent('clothing:cl:handleClothes', function(data)
    if data.index == 8 or data.index == 11 then
        clothing.handleUndress('torso', false)
    else
        clothing.handleUndress('clothes', false, data.index)
    end
    clothing.saveClothes()
end)

RegisterNetEvent('clothing:cl:handleProps', function(data)
    clothing.handleUndress('prop', false, data.index)
    clothing.saveClothes()
end)

RegisterNetEvent('clothing:cl:handleOutfitPlayer', function()
    clothing.handleOutfitPlayer()
end)

RegisterNetEvent('clothing:cl:requestOutfit', function(sender)
    clothing.requestOutfit(sender)
end)

-- Item handling
exports('clothes', function(data, slot)
    exports.ox_inventory:useItem(data, function(data)
        if data then
            local part = slot.metadata.part
            if part == 'outfit' then
                if lib.progressCircle({
                    duration = 1200,
                    position = 'bottom',
                    useWhileDead = false,
                    canCancel = true,
                    disable = {
                        combat = true
                    },
                    anim = {
                        dict = 'clothingshirt',
                        clip = 'try_shirt_positive_d',
                        flag = 51
                    }
                }) then
                    clothing.applyClothing('outfit', slot)
                end
            elseif part == 'torso' then
                if lib.progressCircle({
                    duration = 1200,
                    position = 'bottom',
                    useWhileDead = false,
                    canCancel = true,
                    disable = {
                        combat = true
                    },
                    anim = {
                        dict = 'clothingshirt',
                        clip = 'try_shirt_positive_d',
                        flag = 51
                    }
                }) then
                    clothing.applyClothing('torso', slot)
                end
            elseif part == 'clothes' then
                if lib.progressCircle({
                    duration = Config.Animations.put_on[slot.metadata.index].duration,
                    position = 'bottom',
                    useWhileDead = false,
                    canCancel = true,
                    disable = {
                        combat = true
                    },
                    anim = {
                        dict = Config.Animations.put_on[slot.metadata.index].dict,
                        clip = Config.Animations.put_on[slot.metadata.index].clip,
                        flag = Config.Animations.put_on[slot.metadata.index].flag
                    }
                }) then
                    clothing.applyClothing('clothes', slot)
                end
            elseif part == 'prop' then
                if lib.progressCircle({
                    duration = Config.PropAnimations.put_on[slot.metadata.index].duration,
                    position = 'bottom',
                    useWhileDead = false,
                    canCancel = true,
                    disable = {
                        combat = true
                    },
                    anim = {
                        dict = Config.PropAnimations.put_on[slot.metadata.index].dict,
                        clip = Config.PropAnimations.put_on[slot.metadata.index].clip,
                        flag = Config.PropAnimations.put_on[slot.metadata.index].flag
                    }
                }) then
                    clothing.applyClothing('prop', slot)
                end
            end
        end
    end)
end)

-- Item apply handling
RegisterNetEvent('clothing:cl:applyOutfit', function(data, slot)
    clothing.applyClothing('outfit', data, slot)
end)

RegisterNetEvent('clothing:cl:applyTorso', function(data, slot)
    clothing.applyClothing('torso', data, slot)
end)

RegisterNetEvent('clothing:cl:applyClothes', function(data, slot)
    clothing.applyClothing('clothes', data, slot)
end)

RegisterNetEvent('clothing:cl:applyProps', function(data, slot)
    clothing.applyClothing('prop', data, slot)
end)

-- Backpacks & clipping issue fix
local hasMask, hasHat = false, false
CreateThread(function()
    if Config.PlayerWontLoseProps then
        SetPedCanLosePropsOnDamage(cache.ped, false, 0)
    end

    while true do
        if Config.AutomaticBackpack then
            local hasValidBackpack = false
            for k, v in ipairs(Config.Backpacks) do
                local bag = inventory:Search('count', v.item)
                if bag >= 1 then
                    SetPedComponentVariation(cache.ped, 5, v.drawable, v.texture, 0)
                    hasValidBackpack = true
                    break
                end
            end
        
            if not hasValidBackpack then
                SetPedComponentVariation(cache.ped, 5, 0, 0, 0)
            end
        end

        -- Fix wearing masks
        if Config.MaskFix then
            local function GetHeadBlendData()
                return Citizen.InvokeNative(0x2746BD9D88C5C5D0, cache.ped, Citizen.PointerValueIntInitialized(0), Citizen.PointerValueIntInitialized(0), Citizen.PointerValueIntInitialized(0), Citizen.PointerValueIntInitialized(0), Citizen.PointerValueIntInitialized(0), Citizen.PointerValueIntInitialized(0), Citizen.PointerValueFloatInitialized(0), Citizen.PointerValueFloatInitialized(0), Citizen.PointerValueFloatInitialized(0))
            end

            if GetPedDrawableVariation(cache.ped, 1) == 0 and hasMask then
                hasMask = false
                SetPedHeadBlendData(cache.ped, faceFeatures[1], faceFeatures[2], faceFeatures[3], faceFeatures[4], faceFeatures[5], faceFeatures[6], faceFeatures[7], faceFeatures[8], faceFeatures[9], false)
            elseif GetPedDrawableVariation(cache.ped, 1) > 0 and not hasMask then
                hasMask = true
                faceFeatures = {GetHeadBlendData()}
                SetPedHeadBlendData(cache.ped, 0, 0, 0, faceFeatures[4], faceFeatures[5], faceFeatures[6], 0, faceFeatures[8], 0, false)
            end
        end

        -- Fix wearing hats
        if Config.HatFix then
            if GetPedPropIndex(cache.ped, 0) == -1 and hasHat then
                hasHat = false
                SetPedComponentVariation(cache.ped, 2, currentHair.drawable, currentHair.texture, currentHair.palette)
            elseif GetPedPropIndex(cache.ped, 0) > -1 and not hasHat then
                hasHat = true
                currentHair = {drawable = GetPedDrawableVariation(cache.ped, 2), texture = GetPedTextureVariation(cache.ped, 2), palette = GetPedPaletteVariation(cache.ped, 2)}
                SetPedComponentVariation(cache.ped, 2, 0, 0, 0)
            end
        end

        Wait(500)
    end
end)

lib.callback.register('clothing:cl:renameOutfit', function(label)
    local input = lib.inputDialog(_L('rename_title'), {_L('rename_text')})
    if not input or not input == ' ' then
        return label
    else
        notify(_L('rename_successful'), 'success')
        return input[1]
    end
end)

lib.callback.register('clothing:cl:tearingProgress', function(label, duration, dict, clip)
    if lib.progressCircle({
        label = label,
        duration = duration,
        position = 'middle',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true
        },
        anim = {
            dict = dict,
            clip = clip
        }
    }) then
        if TearMinigameSettings.enabled then
            local success = lib.skillCheck(TearMinigameSettings.difficulty, TearMinigameSettings.keys)
            if success then
                return true
            end

            return false
        end

        return true
    end
end)

AddEventHandler('playerDropped', function()
    if hasMask then
        Config.MaskFix = false
        SetPedHeadBlendData(cache.ped, faceFeatures[1], faceFeatures[2], faceFeatures[3], faceFeatures[4], faceFeatures[5], faceFeatures[6], faceFeatures[7], faceFeatures[8], faceFeatures[9], false)
        hasMask = false
    end

    if hasHat then
        Config.HatFix = false
        SetPedComponentVariation(cache.ped, 2, currentHair.drawable, currentHair.texture, currentHair.palette)
        hasHat = false
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end

    if hasMask then
        Config.MaskFix = false
        SetPedHeadBlendData(cache.ped, faceFeatures[1], faceFeatures[2], faceFeatures[3], faceFeatures[4], faceFeatures[5], faceFeatures[6], faceFeatures[7], faceFeatures[8], faceFeatures[9], false)
        hasMask = false
    end

    if hasHat then
        Config.HatFix = false
        SetPedComponentVariation(cache.ped, 2, currentHair.drawable, currentHair.texture, currentHair.palette)
        hasHat = false
    end
end)  
