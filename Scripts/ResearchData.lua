local function _h1(a0,a1,a2,a3,a4) return {sName=a0,sDesc=a1,tPrereqs=a2,nResearchUnits=a3,sIcon=a4} end
local function _h2(a0,a1,a2,a3) return {sItemForDesc=a0,tPrereqs=a1,nResearchUnits=a2,sIcon=a3} end
local t=
{
    VaporizeLevel2= _h1('RESRCH001TEXT', 'RESRCH002TEXT', {}, 1200, 'ui_jobs_iconJobBuilder'),
    MaintenanceLevel2=
    {
        sName='RESRCH009TEXT',
        sDesc='RESRCH010TEXT',
        tPrereqs={'MaintenanceLevel2Discovered'},
        nResearchUnits=1200,
        nConditionMultiplier=1.5,
		sIcon = 'ui_jobs_iconJobTechnician',
    },
    BuildLevel2= _h1('RESRCH011TEXT', 'RESRCH012TEXT', {}, 1000, 'ui_jobs_iconJobBuilder'),
    PlantLevel2=
    {
        sName='RESRCH013TEXT',
        sDesc='RESRCH014TEXT',
        tPrereqs={},
        nResearchUnits=1000,
        nConditionMultiplier=2,
		sIcon = 'ui_jobs_iconJobBotanist',
    },
    LaserRifles= _h1('RESRCH003TEXT', 'RESRCH004TEXT', {}, 1100, 'ui_jobs_iconJobResponse'),
    ArmorLevel2= _h1('RESRCH005TEXT', 'RESRCH006TEXT', {}, 900, 'ui_jobs_iconJobResponse'),
    TeamTactics= _h1('RESRCH017TEXT', 'RESRCH018TEXT', {'TeamTacticsDiscovered'}, 2000, 'ui_jobs_iconJobResponse'),
    OxygenRecyclerLevel2= _h2('OxygenRecyclerLevel2', {'AirScrubber'}, 1000, 'ui_jobs_iconJobUnemployed'),
    GeneratorLevel2= _h2('GeneratorLevel2', {}, 1000, 'ui_jobs_iconJobUnemployed'),
    AirScrubber= _h2('AirScrubber', {}, 750, 'ui_jobs_iconJobDoctor'),
    DoorLevel2=
    {
        sItemForDesc='HeavyDoor',
        tPrereqs={},
        nResearchUnits=1200,
    },
    FridgeLevel2= _h2('FridgeLevel2', {'FridgeLevel2Discovered'}, 800, 'ui_jobs_iconJobBarkeep'),
    RefineryDropoffLevel2= _h2('RefineryDropoffLevel2', {}, 1200, 'ui_jobs_iconJobMiner'),
	WallMountedTurret2= _h2('WallMountedTurret2', {'WallMountedTurretLevel2Discovered'}, 2000, 'ui_jobs_iconJobResponse'),
	FridgeLevel2Discovered=
    {
        sName='PROPSX069TEXT',
        sDesc='PROPSX068TEXT',
        tPrereqs={},
        nResearchUnits=1,
		bDiscoverOnly=true,
    },
	TeamTacticsDiscovered=
    {
        sName='RESRCH017TEXT',
        sDesc='RESRCH018TEXT',
        tPrereqs={},
        nResearchUnits=1,
		bDiscoverOnly=true,
    },
    MaintenanceLevel2Discovered=
    {
        sName='RESRCH009TEXT',
        sDesc='RESRCH010TEXT',
        tPrereqs={},
        nResearchUnits=1,
		bDiscoverOnly=true,
	},
    WallMountedTurretLevel2Discovered=
    {
        sName='PROPSX080TEXT',
        sDesc='PROPSX081TEXT',
        tPrereqs={},
        nResearchUnits=1,
		bDiscoverOnly=true,
	},
}
return t
