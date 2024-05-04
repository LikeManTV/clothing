if GetResourceState('ox_appearance') ~= 'started' then return end

appearance = {}

appearance.saveSkin = function()
    local appearance = exports['fivem-appearance']:getPedAppearance(cache.ped)
    if appearance then
        TriggerServerEvent('ox_appearance:save', appearance)
        return true
    end

    return false
end