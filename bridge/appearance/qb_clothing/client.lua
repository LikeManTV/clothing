if GetResourceState('qb-clothing') ~= 'started' then return end
error('qb_clothing is not supported!')

appearance = {}

appearance.saveSkin = function()
    local appearance = exports['fivem-appearance']:getPedAppearance(cache.ped)
    local model = IsPedMale(cache.ped) and 'mp_m_freemode_01' or 'mp_f_freemode_01'
    if appearance and model then
        TriggerServerEvent('qb-clothing:saveSkin', model , appearance)
        return true
    end

    return false
end