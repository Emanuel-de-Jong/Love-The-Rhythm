local TableSystem = Class:new()

TableSystem.checkEmpty = function(t)
    for k, v in pairs(t) do
        return false
    end

    return true
end

TableSystem.getElementByPosition = function(t, position)
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

TableSystem.getKeyByPosition = function(t, position)
    local i = 1
    local key = nil

    for k, v in pairs(t) do
        if i == position then
            key = k
            break
        end
        i = i + 1
    end

    return key
end

TableSystem.getValueByPosition = function(t, position)
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