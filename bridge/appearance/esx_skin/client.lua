if GetResourceState('skinchanger') ~= 'started' or GetResourceState('esx_skin') ~= 'started' and GetResourceState('fivem-appearance') ~= 'started' then return end

appearance = {}

appearance.saveSkin = function()
    TriggerEvent('skinchanger:getSkin', function(getSkin)
        TriggerServerEvent('esx_skin:save', getSkin)
        return true
    end)

    return false
end