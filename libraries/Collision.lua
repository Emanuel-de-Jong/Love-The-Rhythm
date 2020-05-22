local Collision = Class:new()

Collision.checkBoxBox = function(x1,y1,w1,h1, x2,y2,w2,h2)
    return x1 < x2+w2 and
           x2 < x1+w1 and
           y1 < y2+h2 and
           y2 < y1+h1
end

Collision.checkBoxBoxX = function(x1,w1, x2,w2)
    return x1 < x2+w2 and
           x2 < x1+w1
end

Collision.checkBoxBoxY = function(y1,h1, y2,h2)
    return y1 < y2+h2 and
           y2 < y1+h1
end

Collision.checkPointBox = function(x1,y1, x2,y2,w2,h2)
    return x1 < x2+w2 and
           x2 < x1    and
           y1 < y2+h2 and
           y2 < y1
end

Collision.checkPointBoxX = function(x1, x2,w2)
    return x1 < x2+w2 and
           x2 < x1
end

Collision.checkPointBoxY = function(y1, y2,h2)
    return y1 < y2+h2 and
           y2 < y1
end

Collision.checkPointPoint = function(x1,y1, x2,y2)
    return x1 == x2 and
           y1 == y2
end

Collision.checkPointPointX = function(x1, x2)
    return x1 == x2
end

Collision.checkPointPointY = function(y1, y2)
    return y1 == y2
end

return Collision