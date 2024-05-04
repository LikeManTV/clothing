Language = {}

function _L(name, args)
    if name then 
        local str = Language[Config.Language][name]
        if str then
            return string.format(str, (args ~= nil and table.unpack(args) or nil))
        else    
            return "ERR_TRANSLATE_"..(name).."_404"
        end
    else
        return "ERR_TRANSLATE_404"
    end
end