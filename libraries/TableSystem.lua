local TableSystem = Class:new()

TableSystem.checkEmpty = function(t)
    -- if it loops at least once, there is something in it
    for k in pairs(t) do
        return false
    end

    return true
end

-- the next get functions are for tables that don't have an index in numerical order
-- for example if you want the second index of {speed = 8, fullscreen = true, color = "red"}
TableSystem.getElementWithPosition = function(t, position)
    local i = 1

    for k, v in pairs(t) do
        if i == position then
            return {[k] = v}
        end
        i = i + 1
    end
end

TableSystem.getKeyWithPosition = function(t, position)
    local i = 1

    for k in pairs(t) do
        if i == position then
            return k
        end
        i = i + 1
    end
end

TableSystem.getValueWithPosition = function(t, position)
    local i = 1
    
    for k, v in pairs(t) do
        if i == position then
            return v
        end
        i = i + 1
    end
end

return TableSystem