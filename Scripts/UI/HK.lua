local K = {esc=27, ret=13, ent=13, spc=32, bksp=8}
local M = {}
function M.add(self, sKey, rButton)
    sKey = string.lower(sKey)
    local c = K[sKey]
    if not c then
        c = string.byte(sKey)
        self.tHotkeyButtons[string.byte(string.upper(sKey))] = rButton
    end
    self.tHotkeyButtons[c] = rButton
end
function M.key(self, key, bDown)
    local bHandled = false
    if not self.rSubmenu then
        if bDown and self.tHotkeyButtons[key] then
            self.tHotkeyButtons[key]:keyboardPressed()
            bHandled = true
        end
    end
    if not bHandled and self.rSubmenu and self.rSubmenu.onKeyboard then
        bHandled = self.rSubmenu:onKeyboard(key, bDown)
    end
    return bHandled
end
return M
