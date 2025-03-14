local lastArms = false
local armsData = lib.loadJson('data/arms')
local glovesData = lib.loadJson('data/gloves')
local torsoData = {
    Male = lib.loadJson('data/torso_male'),
    Female = lib.loadJson('data/torso_female')
}

utils = {
    getPedSex = function()
        if IsPedModel(cache.ped, "mp_m_freemode_01") then 
            return "Male"
        else
            return "Female"
        end
    end,

    isNaked = function()
        local gender = utils.getPedSex(cache.ped)
        local player = {
            comps = {},
            props = {}
        }

        for i = 0, 11 do
            if i ~= 2 then
                player.comps[i] = { d = GetPedDrawableVariation(cache.ped, i), t = GetPedTextureVariation(cache.ped, i) }
            end
        end

        for i = 0, 2 do
            player.props[i] = { d = GetPedPropIndex(cache.ped, i), t = GetPedPropTextureIndex(cache.ped, i) }
        end

        for i = 6, 7 do
            player.props[i] = { d = GetPedPropIndex(cache.ped, i), t = GetPedPropTextureIndex(cache.ped, i) }
        end
    
        local defaultOutfit = Config.DefaultPlayerClothes[gender]
        for index, data in pairs(defaultOutfit.Components) do
            if player.comps[index].d ~= data.drawable or player.comps[index].t ~= data.texture then
                return false
            end
        end
        
        for index, data in pairs(defaultOutfit.Props) do
            if player.props[index].d ~= data.drawable or player.props[index].t ~= data.texture then
                return false
            end
        end
    
        return true
    end
}

clothing = {
    applyClothing = function(_type, slot)
        local data = slot.metadata
        local gender = utils.getPedSex(cache.ped)
        if data.sex ~= gender then
            return notify(_L('error_fitcheck', 'error'))
        end

        if _type == 'outfit' then
            local hair = GetPedDrawableVariation(cache.ped, 2)
            local hairTexture = GetPedTextureVariation(cache.ped, 2)
            local isNaked = utils.isNaked()

            if not isNaked then clothing.handleUndress('outfit', true) end
            for _, v in pairs(data.comps) do
                SetPedComponentVariation(cache.ped, v.index, v.drawable, v.texture, v.palette)
            end
            for _, v in pairs(data.props) do
                SetPedPropIndex(cache.ped, v.index, v.drawable, v.texture)
            end
            SetPedComponentVariation(cache.ped, 2, hair, hairTexture, 0)
            appearance.saveSkin()
            TriggerServerEvent('clothing:sv:removeItem', data, slot)
        elseif _type == 'torso' then
            -- local bestTorso = torsoData[gender][tostring(data.Jacket.drawable)][tostring(data.Jacket.texture)]
            -- if bestTorso and bestTorso.BestTorsoDrawable ~= -1 then
            --     SetPedComponentVariation(cache.ped, 3, bestTorso.BestTorsoDrawable, bestTorso.BestTorsoTexture, 2)
            -- end

            if clothing.checkCurrent('torso') then
                if lastArms then
                    SetPedComponentVariation(cache.ped, 3, lastArms.d, lastArms.t, 2)
                end

                for _,v in pairs(data) do
                    SetPedComponentVariation(cache.ped, v.index, v.drawable, v.texture, v.palette)
                    appearance.saveSkin()
                    TriggerServerEvent("clothing:sv:removeItem", data, slot)
                end
            end
        elseif _type == 'clothes' then
            if clothing.checkCurrent('clothes', data.index) then
                SetPedComponentVariation(cache.ped, data.index, data.drawable, data.texture, data.palette)
                appearance.saveSkin()
                TriggerServerEvent("clothing:sv:removeItem", data, slot)
            end
        elseif _type == 'prop' then
            if clothing.checkCurrent('prop', data.index) then
                SetPedPropIndex(cache.ped, data.index, data.drawable, data.texture, true)
                appearance.saveSkin()
                TriggerServerEvent("clothing:sv:removeItem", data, slot)
            end
        end
    end,

    handleUndress = function(_type, changing, index)
        local gender = utils.getPedSex(cache.ped)

        if _type == 'outfit' then
            local hair = GetPedDrawableVariation(cache.ped, 2)
            local hairTexture = GetPedTextureVariation(cache.ped, 2)
            local outfitData = {
                sex = gender,
                outfit = {
                    comps = {},
                    props = {}
                }
            }

            for i = 0, 11 do
                if i ~= 2 then
                    outfitData.outfit.comps[i] = {
                        index = i,
                        drawable = GetPedDrawableVariation(cache.ped, i),
                        texture = GetPedTextureVariation(cache.ped, i),
                        pallete = GetPedPaletteVariation(cache.ped, drawable)
                    }
                end
            end
            
            for i = 0, 2 do
                outfitData.outfit.props[i] = {
                    index = i,
                    drawable = GetPedPropIndex(cache.ped, i),
                    texture = GetPedPropTextureIndex(cache.ped, i)
                }
            end
            for i = 6, 7 do
                outfitData.outfit.props[i] = {
                    index = i,
                    drawable = GetPedPropIndex(cache.ped, i),
                    texture = GetPedPropTextureIndex(cache.ped, i)
                }
            end
        
            local outfitName, outfitLabel = clothing.isWearingOutfit()
            if clothing.isAbleToUndress('Components', 8, GetPedDrawableVariation(cache.ped, 8)) or clothing.isAbleToUndress('Components', 4, GetPedDrawableVariation(cache.ped, 4)) or clothing.isAbleToUndress('Components', 6, GetPedDrawableVariation(cache.ped, 6)) then
                clothing.setDefaultVariation({ isAnimated = true, sex = gender, index = 8, isChangingClothes = changing })
                clothing.setDefaultVariation({ isAnimated = false, sex = gender, index = 1 })
                clothing.setDefaultVariation({ isAnimated = false, sex = gender, index = 3 })
                clothing.setDefaultVariation({ isAnimated = false, sex = gender, index = 4 })
                if not Config.AutomaticBackpack then
                    clothing.setDefaultVariation({ isAnimated = false, sex = gender, index = 5 })
                end
                clothing.setDefaultVariation({ isAnimated = false, sex = gender, index = 6 })
                clothing.setDefaultVariation({ isAnimated = false, sex = gender, index = 7 })
                clothing.setDefaultVariation({ isAnimated = false, sex = gender, index = 9 })
                clothing.setDefaultVariation({ isAnimated = false, sex = gender, index = 10 })
                clothing.setDefaultVariation({ isAnimated = false, sex = gender, index = 11 })
                clothing.setDefaultPropVariation({ isAnimated = false, sex = gender, index = 0 })
                clothing.setDefaultPropVariation({ isAnimated = false, sex = gender, index = 1 })
                clothing.setDefaultPropVariation({ isAnimated = false, sex = gender, index = 2 })
                clothing.setDefaultPropVariation({ isAnimated = false, sex = gender, index = 6 })
                clothing.setDefaultPropVariation({ isAnimated = false, sex = gender, index = 7 })
                SetPedComponentVariation(cache.ped, 2, hair, hairTexture, 0)
                TriggerServerEvent("clothing:sv:giveOutfit", outfitData, outfitLabel)
            else
                notify(_L('error_no_clothes'), "error")
            end
        elseif _type == 'torso' then
            local torsoData = {
                sex = gender,
                torso = {
                    Tshirt = {
                        index = 8,
                        drawable = GetPedDrawableVariation(cache.ped, 8),
                        texture = GetPedTextureVariation(cache.ped, 8),
                        palette = GetPedPaletteVariation(cache.ped, 8)
                    },
                    Jacket = {
                        index = 11,
                        drawable = GetPedDrawableVariation(cache.ped, 11),
                        texture = GetPedTextureVariation(cache.ped, 11),
                        palette = GetPedPaletteVariation(cache.ped, 11)
                    },
                }
            }

            if clothing.isAbleToUndress('Components', 8, GetPedDrawableVariation(cache.ped, 8)) or clothing.isAbleToUndress('Components', 11, GetPedDrawableVariation(cache.ped, 11)) then
                clothing.setDefaultVariation({ isAnimated = true, sex = gender, index = 8, isChangingClothes = changing })
                clothing.setDefaultVariation({ isAnimated = false, sex = gender, index = 11 })

                local currentDrawable = GetPedDrawableVariation(cache.ped, 3)
                local currentTexture = GetPedTextureVariation(cache.ped, 3)
                local arms = armsData[gender][tostring(currentDrawable)]
                lastArms = {d = currentDrawable, t = currentTexture}
                if arms then
                    SetPedComponentVariation(cache.ped, 3, arms, currentTexture, 2)
                else
                    clothing.setDefaultVariation({ isAnimated = false, sex = gender, index = 3 })
                end
                TriggerServerEvent("clothing:sv:giveTorso", torsoData)
            else
                notify(_L('error_no_clothes'), "error")
            end
        elseif _type == 'clothes' then
            local currentDrawable = GetPedDrawableVariation(cache.ped, index)
            local currentTexture = GetPedTextureVariation(cache.ped, index)
            local clothingData = {
                sex = gender,
                index = index,
                drawable = currentDrawable,
                texture  = currentTexture,
            }

            if clothing.isAbleToUndress('Components', index, currentDrawable) then
                clothing.setDefaultVariation({ isAnimated = true, sex = gender, index = index, isChangingClothes = changing })
                if index == 3 then
                    local gloves = glovesData[gender][tostring(currentDrawable)]
                    if gloves then
                        SetPedComponentVariation(cache.ped, 3, gloves, currentTexture, 2)
                    end
                end
                TriggerServerEvent("clothing:sv:giveClothes", clothingData)
            else
                notify(_L('error_no_clothes'), "error")
            end
        elseif _type == 'prop' then
            local currentProp = GetPedPropIndex(cache.ped, index)
            local propData = {
                sex = gender,
                index = index,
                drawable = currentProp,
                texture  = GetPedPropTextureIndex(cache.ped, index)
            }

            if clothing.isAbleToUndress('Props', index, currentProp) then
                clothing.setDefaultPropVariation({ isAnimated = true, sex = gender, index = index, isChangingClothes = changing })
                TriggerServerEvent("clothing:sv:giveProp", propData)
            else
                notify(_L('error_no_clothes'), "error")
            end
        end
    end,

    handleOutfitPlayer = function()
        local player = lib.getClosestPlayer(GetEntityCoords(cache.ped), 3.0, false)
        if player and player ~= cache.playerId then
            local serverId = GetPlayerServerId(player)
            if serverId then
                TriggerServerEvent('clothing:sv:requestOutfit', serverId)
                notify(_L('request_sent'), "success")
            end
        else
            notify(_L('error_nobody_around'), "error")
        end
    end,

    requestOutfit = function(sender)
        SetTimeout(15000, function()
            lib.closeAlertDialog()
        end)
    
        local alert = lib.alertDialog({
            header = _L('new_request_title'),
            content = _L('new_request_desc'),
            centered = true,
            cancel = true
        })
    
        if alert == 'confirm' then
            clothing.handleUndress('outfit', false)
            appearance.saveSkin()
        end
    end,

    isAbleToUndress = function(_type, index, drawable)
        local gender = utils.getPedSex(cache.ped)

        if drawable == Config.DefaultPlayerClothes[gender][_type][index].drawable then
            return false
        end

        return true
    end,

    checkCurrent = function(_type, index)
        if _type == 'torso' then
            local gender = utils.getPedSex(cache.ped)
            local shirt = GetPedDrawableVariation(cache.ped, 8)
            local jacket = GetPedDrawableVariation(cache.ped, 11)
            
            if shirt ~= Config.DefaultPlayerClothes[gender].Components[8].drawable or jacket ~= Config.DefaultPlayerClothes[gender].Components[11].drawable then
                clothing.handleUndress('torso', true, nil)
            end
        
            return true
        elseif _type == 'clothes' then
            local gender = utils.getPedSex(cache.ped)
            local clothes = GetPedDrawableVariation(cache.ped, index)
            
            if clothes ~= Config.DefaultPlayerClothes[gender].Components[index].drawable then
                clothing.handleUndress('clothes', true, index)
            end
        
            return true
        elseif _type == 'prop' then
            local prop = GetPedPropIndex(cache.ped, index)

            if prop ~= -1 then
                clothing.handleUndress('prop', true, index)
            end
        
            return true
        end
    end,

    setDefaultVariation = function(data)
        if data.isAnimated then
            if not data.isChangingClothes then
                if lib.progressCircle({
                    duration = Config.Animations.take_off[data.index].duration,
                    position = 'bottom',
                    useWhileDead = false,
                    canCancel = true,
                    disable = {
                        combat = true
                    },
                    anim = {
                        dict = Config.Animations.take_off[data.index].dict,
                        clip = Config.Animations.take_off[data.index].clip,
                        flag = Config.Animations.take_off[data.index].flag
                    }
                }) then
                    SetPedComponentVariation(cache.ped, data.index, Config.DefaultPlayerClothes[data.sex].Components[data.index].drawable, Config.DefaultPlayerClothes[data.sex].Components[data.index].texture, 0)
                    return
                end
            end
        end

        SetPedComponentVariation(cache.ped, data.index, Config.DefaultPlayerClothes[data.sex].Components[data.index].drawable, Config.DefaultPlayerClothes[data.sex].Components[data.index].texture, 0)
    end,

    setDefaultPropVariation = function(data)
        if data.isAnimated then
            if not data.isChangingClothes then
                if lib.progressCircle({
                    duration = Config.PropAnimations.take_off[data.index].duration,
                    position = 'bottom',
                    useWhileDead = false,
                    canCancel = true,
                    disable = {
                        combat = true
                    },
                    anim = {
                        dict = Config.PropAnimations.take_off[data.index].dict,
                        clip = Config.PropAnimations.take_off[data.index].clip,
                        flag = Config.PropAnimations.take_off[data.index].flag
                    }
                }) then
                    ClearPedProp(cache.ped, data.index)
                    SetPedPropIndex(cache.ped, data.index, -1, 0, 0)
                    return
                end
            end
        end

        ClearPedProp(cache.ped, data.index)
        SetPedPropIndex(cache.ped, data.index, -1, 0, 0)
    end,

    isWearingOutfit = function(name)
        local gender = utils.getPedSex(cache.ped)
        local player = {
            comps = {},
            props = {}
        }

        for i = 0, 11 do
            if i ~= 2 then
                player.comps[i] = { d = GetPedDrawableVariation(cache.ped, i), t = GetPedTextureVariation(cache.ped, i) }
            end
        end

        for i = 0, 2 do
            player.props[i] = { d = GetPedPropIndex(cache.ped, i), t = GetPedPropTextureIndex(cache.ped, i) }
        end
        for i = 6, 7 do
            player.props[i] = { d = GetPedPropIndex(cache.ped, i), t = GetPedPropTextureIndex(cache.ped, i) }
        end
    
        local outfits = {}
        for outfitName, outfitData in pairs(Config.SpecialOutfits) do
            for index, data in pairs(outfitData[gender].comps) do
                if player.comps[index].d ~= data.d and player.comps[index].t ~= data.t then
                    outfits[outfitName] = true
                end
            end
    
            if not outfits[outfitName] then
                return outfitName, outfitData.label
            end
        end
        
        return false
    end,

    isWearing = function(index)
        local comp = GetPedDrawableVariation(cache.ped, index)
        local text = GetPedTextureVariation(cache.ped, index)
        if comp == 0 then
            return false
        else
            return prop, text
        end
    end,

    isWearingProp = function(index)
        local prop = GetPedPropIndex(cache.ped, index)
        local text = GetPedPropTextureIndex(cache.ped, index)
        if prop == 0 or prop == -1 then
            return false
        else
            return prop, text
        end
    end,
}

exports('isWearingOutfit', clothing.isWearingOutfit)
exports('isWearingClothes', clothing.isWearing)
exports('isWearingProp', clothing.isWearingProp)
exports('isNaked', utils.isNaked)
exports('getPedSex', utils.getPedSex)
-- exports('giveClothes', )
-- exports('giveProp', )
