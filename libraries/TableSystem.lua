local TableSystem = Class:new()

TableSystem.checkEmpty = function(t)
    for k, v in pairs(t) do
        return false
    end
    return true
end

TableSystem.getData = function(t, index)
    local i = 1
    local data = nil
    for k, v in pairs(t) do
        if i == index then
            data[k] = v
            break
        end
        i = i + 1
    end
    return data
end

TableSystem.getDataKey = function(t, index)
    local i = 1
    local key = nil
    for k, v in pairs(t) do
        if i == index then
            key = k
            break
        end
        i = i + 1
    end
    return key
end

TableSystem.getDataValue = function(t, index)
    local i = 1
    local value = nil
    for k, v in pairs(t) do
        if i == index then
            value = v
            break
        end
        i = i + 1
    end
    return value
end

return TableSystem