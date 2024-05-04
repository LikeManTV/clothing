if GetResourceState('illenium-appearance') ~= 'started' then return end

appearance = {}

appearance.saveSkin = function()
    local appearance = exports['illenium-appearance']:getPedAppearance(cache.ped)
    if appearance then
        TriggerServerEvent('illenium-appearance:server:saveAppearance', appearance)
        return true
    end

    return false
end