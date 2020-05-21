local SceneManager = require("instances/SceneManager")
local Input = Class:new()

Input.mousepressed = function(x, y, button, istouch, presses)

end

Input.keypressed = function(key, scancode, isrepeat)
    if key == "backspace" then
        SceneManager.goBack()
    end
end

Input.wheelmoved = function(x, y)
    
end

return Input