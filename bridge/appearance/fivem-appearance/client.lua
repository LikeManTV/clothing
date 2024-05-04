if GetResourceState('fivem-appearance') ~= 'started' then return end

appearance = {}

appearance.saveSkin = function()
    local appearance = exports['fivem-appearance']:getPedAppearance(cache.ped)
    if appearance then
        TriggerServerEvent('fivem-appearance:save', appearance)
        return true
    end

    return false
end