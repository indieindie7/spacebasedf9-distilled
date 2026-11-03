local DFFile = require('DFCommon.File')
local Delegate = require('DFMoai.Delegate')
local EntityManager = { }
EntityManager.tComponentModules = { }
EntityManager.tEntityModules = { }
EntityManager.tEntities = { }
EntityManager.dEntityCreate = Delegate.new()
EntityManager.tFlags = {
	DebugOverrides = false,
}
function EntityManager.getEntityNamed( sName )
    for _,rEntity in ipairs( EntityManager.tEntities ) do
        if rEntity:getName() == sName then
            return rEntity
        end
    end
    return nil
end
function EntityManager._destroy(rEntity, index, bRemove)
	rEntity:_onDestroy()
    if bRemove then
        table.remove(EntityManager.tEntities, index)
    end
end
function EntityManager.onTick(deltaTime)
    for i, rEntity in ipairs(EntityManager.tEntities) do
        if rEntity.onTick then
            rEntity:onTick(deltaTime)
        end
		rEntity:_updateComponents(deltaTime)
    end
	EntityManager.processDestroyedEntities()
end
function EntityManager.processDestroyedEntities()
    local index = 1
    local rEntity = EntityManager.tEntities[index]
    while rEntity do
        if rEntity.needsDestroy then
            EntityManager._destroy(rEntity, index, true)
        else
            index = index + 1
        end
        rEntity = EntityManager.tEntities[index]
    end
end
return EntityManager
