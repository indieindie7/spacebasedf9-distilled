local Class = require('Class')
local Task = require('Utility.Task')
local Chat = require('Utility.Tasks.Chat')
local ChatPartner = Class.create(Chat)
function ChatPartner:init(rChar,tPromisedNeeds,rActivityOption)
    Chat.init(self, rChar, tPromisedNeeds, rActivityOption)
end
function ChatPartner:_startChat(duration)
    self.bChatting = true
end
function ChatPartner:onUpdate(dt, dtRaw)
    if not self.bChatting then
        self:_followTarget(dt)
    end
end
return ChatPartner
