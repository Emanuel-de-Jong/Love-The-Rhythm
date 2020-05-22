local TableSystem = Class:new()

TableSystem.checkEmpty = function(t)
    for k in pairs(t) do
        return false
    end

    return true
end

TableSystem.getElementWithPosition = function(t, position)
    local i = 1
    local element = {}
    local elementEmpty = true

    for k, v in pairs(t) do
        if i == position then
            elementEmpty = false
            element[k] = v
            break
        end
        i = i + 1
    end

    if elementEmpty then
        return nil
    else
        return element
    end
end

TableSystem.getKeyWithPosition = function(t, position)
    local i = 1
    local key = nil

    for k in pairs(t) do
        if i == position then
            key = k
            break
        end
        i = i + 1
    end

    return key
end

TableSystem.getValueWithPosition = function(t, position)
    local i = 1
    local value = nil

    for k, v in pairs(t) do
        if i == position then
            value = v
            break
        end
        i = i + 1
    end

    return value
end

return TableSystem