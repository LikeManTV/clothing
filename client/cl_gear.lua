-- Special outfits
CreateThread(function()
    if Config.EnableSpecialOutfits then
        local set = false
        while true do
            local outfitName, outfitLabel = clothing.isWearingOutfit()
            if DoesEntityExist(cache.ped) and not IsEntityDead(cache.ped) then
                for name, data in pairs(Config.SpecialOutfits) do
                    if outfitName or outfitLabel then
                        if data.label == outfitLabel then
                            if data.proofs then
                                if not set then
                                    SetEntityProofs(cache.ped, table.unpack(data.proofs))
                                    set = true
                                end
                                if outfitName == 'scuba' then
                                    SetEnableScuba(cache.ped, true)
                                else
                                    SetEnableScuba(cache.ped, false)
                                end
                            else
                                if set then
                                    SetEntityProofs(cache.ped, false, false, false, false, false, false, false, false)
                                    set = false
                                end
                            end
                        end
                    else
                        if set then
                            SetEntityProofs(cache.ped, false, false, false, false, false, false, false, false)
                            set = false
                        end
                    end
                end
            end
            Wait(1000)
        end
    end
end)

-- Functional gear
if Config.FunctionalGear.enabled then
    local nightvision = true
    lib.addKeybind({
        name = 'clothing_nvg',
        description = _L('toggle_nvg'),
        defaultKey = Config.FunctionalGear.useKey,
        onPressed = function(self)
            local nvg, texture = clothing.isWearingProp(0)
            if nvg then
                nightvision = not nightvision
                local isMale = IsPedModel(cache.ped, "mp_m_freemode_01")

                if nightvision and nvg == 116 or nvg == 115 then
                    if lib.progressCircle({
                        duration = Config.Animations.take_off[1].duration,
                        position = 'bottom',
                        useWhileDead = false,
                        canCancel = true,
                        disable = {
                            combat = true
                        },
                        anim = {
                            dict = Config.Animations.take_off[1].dict,
                            clip = Config.Animations.take_off[1].clip,
                            flag = Config.Animations.take_off[1].flag
                        }
                    }) then
                        if isMale then
                            SetPedPropIndex(cache.ped, 0, 117, texture, true)
                        else
                            SetPedPropIndex(cache.ped, 0, 116, texture, true)
                        end
                        SetNightvision(false)
                    end
                elseif not nightvision and nvg == 117 or nvg == 116 then
                    if lib.progressCircle({
                        duration = Config.Animations.put_on[1].duration,
                        position = 'bottom',
                        useWhileDead = false,
                        canCancel = true,
                        disable = {
                            combat = true
                        },
                        anim = {
                            dict = Config.Animations.put_on[1].dict,
                            clip = Config.Animations.put_on[1].clip,
                            flag = Config.Animations.put_on[1].flag
                        }
                    }) then
                        if isMale then
                            SetPedPropIndex(cache.ped, 0, 116, texture, true)
                        else
                            SetPedPropIndex(cache.ped, 0, 115, texture, true)
                        end
                        SetNightvision(true)
                    end
                end
            end
        end
    })
end