--[[
functions to check if two objects overlap.
--]]

local CollisionSystem = Class:new()

CollisionSystem.checkBoxBox = function(x1,y1,w1,h1, x2,y2,w2,h2)
    return x1 < x2+w2 and
           x2 < x1+w1 and
           y1 < y2+h2 and
           y2 < y1+h1
end

CollisionSystem.checkBoxBoxX = function(x1,w1, x2,w2)
    return x1 < x2+w2 and
           x2 < x1+w1
end

CollisionSystem.checkBoxBoxY = function(y1,h1, y2,h2)
    return y1 < y2+h2 and
           y2 < y1+h1
end

CollisionSystem.checkPointBox = function(x1,y1, x2,y2,w2,h2)
    return x1 < x2+w2 and
           x2 < x1    and
           y1 < y2+h2 and
           y2 < y1
end

CollisionSystem.checkPointBoxX = function(x1, x2,w2)
    return x1 < x2+w2 and
           x2 < x1
end

CollisionSystem.checkPointBoxY = function(y1, y2,h2)
    return y1 < y2+h2 and
           y2 < y1
end

CollisionSystem.checkPointPoint = function(x1,y1, x2,y2)
    return x1 == x2 and
           y1 == y2
end

CollisionSystem.checkPointPointX = function(x1, x2)
    return x1 == x2
end

CollisionSystem.checkPointPointY = function(y1, y2)
    return y1 == y2
end

return CollisionSystem