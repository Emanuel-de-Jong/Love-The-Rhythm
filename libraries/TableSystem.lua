local TableSystem = Class:new()

TableSystem.checkEmpty = function(t)
    for k in pairs(t) do
        return false
    end

    return true
end

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