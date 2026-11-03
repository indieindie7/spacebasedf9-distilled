local Renderer = require('Renderer')
local ParticleSystemManager = {
    profilerName='ParticleSystemManager',
}
ParticleSystemManager.tActiveParticleSystems = {}
ParticleSystemManager.lastTimePrint = 0
function ParticleSystemManager.register( rParticleSystem )
    table.insert(ParticleSystemManager.tActiveParticleSystems, rParticleSystem)
end
function ParticleSystemManager.init()
end
function ParticleSystemManager.onTick(dt)
    local numActiveParticleSystems = #ParticleSystemManager.tActiveParticleSystems
    for i=1,numActiveParticleSystems do
        local idx = numActiveParticleSystems - i + 1
        local rParticleSystem = ParticleSystemManager.tActiveParticleSystems[idx]
        if rParticleSystem.bStarted == true then
            local bUnregister = true
            if rParticleSystem.rParticleSystem ~= nil then
                bUnregister = false
                local bIsDead = rParticleSystem.rParticleSystem:isDead()
                if bIsDead == true then
                    rParticleSystem:stop()
                    if rParticleSystem.rEntity ~= nil then
                        rParticleSystem:removeFromEntity()
                    elseif rParticleSystem.rSceneLayer ~= nil then
                        rParticleSystem:removeFromSceneLayer()
                    else
                        assert(0)
                    end
                    rParticleSystem:unload()
                    rParticleSystem = nil
                    bUnregister = true
                else
                    rParticleSystem:onTick(dt)
                end
            end
            if bUnregister == true then
                table.remove(ParticleSystemManager.tActiveParticleSystems, idx)
            end
        elseif rParticleSystem.bUnloaded == true then
            rParticleSystem:stop()
            table.remove(ParticleSystemManager.tActiveParticleSystems, idx)
        end
    end
    if ParticleSystemManager.debugDrawEnabled then
        local curTime = MOAISim.getDeviceTime()
        local deltaTime = curTime - ParticleSystemManager.lastTimePrint
        if deltaTime > 2 then
            ParticleSystemManager.lastTimePrint = curTime
            numActiveParticleSystems = #ParticleSystemManager.tActiveParticleSystems
        end
    end
end
function ParticleSystemManager._debugDraw()
    local numActiveParticleSystems = #ParticleSystemManager.tActiveParticleSystems
    for i=1,numActiveParticleSystems do
        local rParticleSystem = ParticleSystemManager.tActiveParticleSystems[i]
        rParticleSystem:_debugDraw()
    end
end
return ParticleSystemManager
