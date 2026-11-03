local DFGraphics = require('DFCommon.Graphics') local DFMath = require('DFCommon.Math') local DFUtil = require('DFCommon.Util')
local Class=require('Class') local ObjectList=require('ObjectList') local Character=require('CharacterConstants')
local Zone = Class.create() Zone.spriteSheetPath='Environments/Tiles/Floor' Zone.PLAIN = { name='Unzoned', floorNames={ 'base01', },
description="ZONEUI006TEXT",
wallStraightTop = {Base_Straight01_top=15, Base_Straight02_top=1, Base_Straight03_top=30, Base_Straight04_top=2},
wallStraightBottom = {Base_Straight01_bottom=5, Base_Straight02_bottom=2, Base_Straight03_bottom=1},
wallCornerNTop = {Base_Corner_outer01_top=1}, wallCornerNBottom = {Base_Corner_outer01_bottom=1}, wallCornerETop = {Base_Corner_lb_top=1},
wallCornerEBottom = {Base_Corner_lb_bottom=1}, wallCornerSTop = {Base_Corner_inner01_top=1},
wallCornerSBottom = {Base_Corner_inner01_bottom=1}, wallCornerWTop = {Base_Corner_rb_top=1}, wallCornerWBottom = {Base_Corner_rb_bottom=1},
wallTNETop = {Base_Corner_T_NE_top=1}, wallTNEBottom = {Base_Corner_T_NE_bottom=1}, wallTSETop = {Base_Corner_T_SE_top=1},
wallTSEBottom = {Base_Corner_T_SE_bottom=1}, wallTSWTop = {Base_Corner_T_SW_top=1}, wallTSWBottom = {Base_Corner_T_SW_bottom=1},
wallTNWTop = {Base_Corner_T_NW_top=1}, wallTNWBottom = {Base_Corner_T_NW_bottom=1}, wallCrossTop = {Base_Corner_cross_top=1},
wallCrossBottom = {Base_Corner_cross_bottom=1}, wallColumnTop = {Base_Corner_cross_top=1}, wallColumnBottom = {Base_Corner_cross_bottom=1},
tAmbientLightColor = { 0.6*0.6, 0.55*0.6, 0.45*0.6 }, tRoomLights = { { tLightColor = {1.0 * 0.5, 0.6 * 0.5, 0.3 * 0.5}, nLightTileGapX = 4,
nLightTileGapY = 4, nLightRadius = 2, }, }, sLightSpriteName = 'directionalcast', clickSound = 'clickunzoned', portrait = 'Zone_Unzoned' }
Zone.GARDEN = { name='Garden', description="ZONEUI070TEXT", floorNames={ 'garden01', 'garden02', }, associatedJob=Character.BOTANIST,
wallStraightTop = { Garden_Straight01_top=1, Garden_Straight02_top=10, Garden_Straight03_top=2 },
wallStraightBottom = {Garden_Straight01_bottom=5,Garden_Straight02_bottom=5,Garden_Straight03_bottom=1},
wallCornerNTop = {Garden_Corner_outer01_top=1}, wallCornerNBottom = {Garden_Corner_outer01_bottom=1},
wallCornerETop = {Garden_Corner_lb_top=1}, wallCornerEBottom = {Garden_Corner_lb_bottom=1}, wallCornerSTop = {Garden_Corner_inner01_top=1},
wallCornerSBottom = {Garden_Corner_inner01_bottom=1}, wallCornerWTop = {Garden_Corner_rb_top=1},
wallCornerWBottom = {Garden_Corner_rb_bottom=1}, wallTNETop = {Garden_Corner_T_NE_top=1}, wallTNEBottom = {Garden_Corner_T_NE_bottom=1},
wallTSETop = {Garden_Corner_T_SE_top=1}, wallTSEBottom = {Garden_Corner_T_SE_bottom=1}, wallTSWTop = {Garden_Corner_T_SW_top=1},
wallTSWBottom = {Garden_Corner_T_SW_bottom=1}, wallTNWTop = {Garden_Corner_T_NW_top=1}, wallTNWBottom = {Garden_Corner_T_NW_bottom=1},
wallCrossTop = {Garden_Corner_cross_top=1}, wallCrossBottom = {Garden_Corner_cross_bottom=1}, wallColumnTop = {Garden_Corner_outer01_top=1},
wallColumnBottom = {Garden_Corner_outer01_bottom=1}, tAmbientLightColor = {0.5, 0.5, 0.5 }, tRoomLights = { { tLightColor = {0.5, 1, 0.8},
nLightTileGapX = 3, nLightTileGapY = 3, nLightRadius = 3, }, }, sLightSpriteName = 'directionalcast', clickSound = 'clickbar',
portrait = 'Zone_Garden', } Zone.INFIRMARY = { name='Infirmary', description="ZONEUI048TEXT", floorNames={ 'infirmary01', },
associatedJob=Character.DOCTOR, wallStraightTop = { Infirmary_Straight02_top=10, Infirmary_Straight01_top=3,Infirmary_Straight03_top=5, },
wallStraightBottom = {Infirmary_Straight01_bottom=10,}, wallCornerNTop = {Infirmary_Corner_outer01_top=1},
wallCornerNBottom = {Infirmary_Corner_outer01_bottom=1}, wallCornerETop = {Infirmary_Corner_lb_top=1},
wallCornerEBottom = {Infirmary_Corner_lb_bottom=1}, wallCornerSTop = {Infirmary_Corner_inner01_top=1},
wallCornerSBottom = {Infirmary_Corner_inner01_bottom=1}, wallCornerWTop = {Infirmary_Corner_rb_top=1},
wallCornerWBottom = {Infirmary_Corner_rb_bottom=1}, wallTNETop = {Infirmary_Corner_T_NE_top=1},
wallTNEBottom = {Infirmary_Corner_T_NE_bottom=1}, wallTSETop = {Infirmary_Corner_T_SE_top=1},
wallTSEBottom = {Infirmary_Corner_T_SE_bottom=1}, wallTSWTop = {Infirmary_Corner_T_SW_top=1},
wallTSWBottom = {Infirmary_Corner_T_SW_bottom=1}, wallTNWTop = {Infirmary_Corner_T_NW_top=1},
wallTNWBottom = {Infirmary_Corner_T_NW_bottom=1}, wallCrossTop = {Infirmary_Corner_cross_top=1},
wallCrossBottom = {Infirmary_Corner_cross_bottom=1}, wallColumnTop = {Infirmary_Corner_outer01_top=1},
wallColumnBottom = {Infirmary_Corner_outer01_bottom=1}, tAmbientLightColor = { 0.65, 0.65, 0.65 }, tRoomLights = { {
tLightColor = {0.25, 0.25, 0.25 }, nLightTileGapX = 5, nLightTileGapY = 5, nLightRadius = 4, }, }, sLightSpriteName = 'directionalcast',
clickSound = 'clickbar', class='Zones.HospitalZone', portrait = 'Zone_Infirmary', } Zone.LIFESUPPORT = { name='Life Support',
description="ZONEUI002TEXT", floorNames={ 'lifesupport01','lifesupport02', }, associatedJob=Character.TECHNICIAN,
wallStraightTop = {LifeSupport_Straight01_top=40, LifeSupport_Straight02_top=1, LifeSupport_Straight03_top=2},
wallStraightBottom = {LifeSupport_Straight01_bottom=1}, wallCornerNTop = {LifeSupport_Corner_outer01_top=1},
wallCornerNBottom = {LifeSupport_Corner_outerr01_bottom=1}, wallCornerETop = {LifeSupport_Corner_lb_top=1},
wallCornerEBottom = {LifeSupport_Corner_lb_bottom=1}, wallCornerSTop = {LifeSupport_Corner_inner01_top=1},
wallCornerSBottom = {LifeSupport_Corner_inner01_bottom=1}, wallCornerWTop = {LifeSupport_Corner_rb_top=1},
wallCornerWBottom = {LifeSupport_Corner_rb_bottom=1}, wallTNETop = {LifeSupport_Corner_T_NE_top=1},
wallTNEBottom = {LifeSupport_Corner_T_NE_bottom=1}, wallTSETop = {LifeSupport_Corner_T_SE_top=1},
wallTSEBottom = {LifeSupport_Corner_T_SE_bottom=1}, wallTSWTop = {LifeSupport_Corner_T_SW_top=1},
wallTSWBottom = {LifeSupport_Corner_T_SW_bottom=1}, wallTNWTop = {LifeSupport_Corner_T_NW_top=1},
wallTNWBottom = {LifeSupport_Corner_T_NW_bottom=1}, wallCrossTop = {LifeSupport_Corner_cross_top=1},
wallCrossBottom = {LifeSupport_Corner_cross_bottom=1}, wallColumnTop = {LifeSupport_Corner_outer01_top=1},
wallColumnBottom = {LifeSupport_Corner_outerr01_bottom=1}, tAmbientLightColor = {0.2, 0.3, 0.6 }, tRoomLights = { {
tLightColor = {0.5, 0.5, 0.8}, nLightTileGapX = 4, nLightTileGapY = 4, nLightRadius = 4, }, }, sLightSpriteName = 'directionalcast',
clickSound = 'clicklifesupport', portrait = 'Zone_LifeSupport', } Zone.RESIDENCE = { name='Residential Zone', description="ZONEUI043TEXT",
floorNames={ 'Residence', }, wallStraightTop = {Residence_Straight01_top=1, Residence_Straight02_top=10, Residence_Straight03_top=1},
wallStraightBottom = {Residence_Straight01_bottom=1}, wallCornerNTop = {Residence_Corner_outer01_top=1},
wallCornerNBottom = {Residence_Corner_outer01_bottom=1}, wallCornerETop = {Residence_Corner_lb_top=1},
wallCornerEBottom = {Residence_Corner_lb_bottom=1}, wallCornerSTop = {Residence_Corner_inner01_top=1},
wallCornerSBottom = {Residence_Corner_inner01_bottom=1}, wallCornerWTop = {Residence_Corner_rb_top=1},
wallCornerWBottom = {Residence_Corner_rb_bottom=1}, wallTNETop = {Residence_Corner_T_NE_top=1},
wallTNEBottom = {Residence_Corner_T_NE_bottom=1}, wallTSETop = {Residence_Corner_T_SE_top=1},
wallTSEBottom = {Residence_Corner_T_SE_bottom=1}, wallTSWTop = {Residence_Corner_T_SW_top=1},
wallTSWBottom = {Residence_Corner_T_SW_bottom=1}, wallTNWTop = {Residence_Corner_T_NW_top=1},
wallTNWBottom = {Residence_Corner_T_NW_bottom=1}, wallCrossTop = {Residence_Corner_cross_top=1},
wallCrossBottom = {Residence_Corner_cross_bottom=1}, wallColumnTop = {Residence_Corner_cross_top=1},
wallColumnBottom = {Residence_Corner_cross_bottom=1}, tAmbientLightColor = { 0.52, 0.485, 0.41 }, tRoomLights = { {
tLightColor = {1.0, 0.6, 0.3}, nLightTileGapX = 4, nLightTileGapY = 5, nLightRadius = 3, }, }, class = 'Zones.BedZone',
sLightSpriteName = 'directionalcast', clickSound = 'clickresidence', portrait = 'Zone_Residence', } Zone.PUB = { name='Pub',
description="ZONEUI047TEXT", floorNames={ 'Bar', }, associatedJob=Character.BARTENDER, wallStraightTop = {Pub_Straight01_top=1},
wallStraightBottom = {Pub_Straight01_bottom=1}, wallCornerNTop = {Pub_Corner_outer01_top=1},
wallCornerNBottom = {Pub_Corner_outer01_bottom=1}, wallCornerETop = {Pub_Corner_lb_top=1}, wallCornerEBottom = {Pub_Corner_lb_bottom=1},
wallCornerSTop = {Pub_Corner_inner01_top=1}, wallCornerSBottom = {Pub_Corner_inner01_bottom=1}, wallCornerWTop = {Pub_Corner_rb_top=1},
wallCornerWBottom = {Pub_Corner_rb_bottom=1}, wallTNETop = {Pub_Corner_T_NE_top=1}, wallTNEBottom = {Pub_Corner_T_NE_bottom=1},
wallTSETop = {Pub_Corner_T_SE_top=1}, wallTSEBottom = {Pub_Corner_T_SE_bottom=1}, wallTSWTop = {Pub_Corner_T_SW_top=1},
wallTSWBottom = {Pub_Corner_T_SW_bottom=1}, wallTNWTop = {Pub_Corner_T_NW_top=1}, wallTNWBottom = {Pub_Corner_T_NW_bottom=1},
wallCrossTop = {Pub_Corner_cross_top=1}, wallCrossBottom = {Pub_Corner_cross_bottom=1}, wallColumnTop = {Pub_Corner_outer01_top=1},
wallColumnBottom = {Pub_Corner_outer01_bottom=1}, tAmbientLightColor = { 0.8, 0.5, 1.0  }, tRoomLights = { { tLightColor = {0.4, 0.0, 1.0 },
nLightTileGapX = 4, nLightTileGapY = 4, nLightRadius = 2, }, }, sLightSpriteName = 'directionalcast', class='Zones.Pub',
clickSound = 'clickbar', portrait = 'Zone_Pub', } Zone.POWER = { name='Power Reactor', description="ZONEUI004TEXT",
floorNames={ 'reactor02', 'reactor01', }, associatedJob=Character.TECHNICIAN,
wallStraightTop = {Reactor_Straight01_top=3, Reactor_Straight02_top=1},
wallStraightBottom = {Reactor_Straight01_bottom=5, Reactor_Straight02_bottom=2}, wallCornerNTop = {Reactor_Corner_outer01_top=1},
wallCornerNBottom = {Reactor_Corner_outer01_bottom=1}, wallCornerETop = {Reactor_Corner_lb_top=1},
wallCornerEBottom = {Reactor_Corner_lb_bottom=1}, wallCornerSTop = {Reactor_Corner_inner01_top=1},
wallCornerSBottom = {Reactor_Corner_inner01_bottom=1}, wallCornerWTop = {Reactor_Corner_rb_top=1},
wallCornerWBottom = {Reactor_Corner_rb_bottom=1}, wallTNETop = {Reactor_Corner_T_NE_top=1}, wallTNEBottom = {Reactor_Corner_T_NE_bottom=1},
wallTSETop = {Reactor_Corner_T_SE_top=1}, wallTSEBottom = {Reactor_Corner_T_SE_bottom=1}, wallTSWTop = {Reactor_Corner_T_SW_top=1},
wallTSWBottom = {Reactor_Corner_T_SW_bottom=1}, wallTNWTop = {Reactor_Corner_T_NW_top=1}, wallTNWBottom = {Reactor_Corner_T_NW_bottom=1},
wallCrossTop = {Reactor_Corner_cross_top=1}, wallCrossBottom = {Reactor_Corner_cross_bottom=1},
wallColumnTop = {Reactor_Corner_cross_top=1}, wallColumnBottom = {Reactor_Corner_cross_bottom=1}, tAmbientLightColor = { 0.5, 0.2, 0.2 },
tRoomLights = { { tLightColor = {1.0, 0.0, 0.0}, nLightTileGapX = 4, nLightTileGapY = 4, nLightRadius = 2.5, }, },
sLightSpriteName = 'directionalcast', clickSound = 'clickreactor', portrait = 'Zone_Power', } Zone.AIRLOCK = { name='Airlock',
description="ZONEUI038TEXT", floorNames={ 'airlock02','airlock01', },
wallStraightTop = {Airlock_Straight01_top=1, Airlock_Straight02_top=1, Airlock_Straight03_top=4, Airlock_Straight04_top=1},
wallStraightBottom = {Airlock_Straight01_bottom=1, Airlock_Straight02_bottom=1}, wallCornerNTop = {Airlock_Corner_outer01_top=1},
wallCornerNBottom = {Airlock_Corner_outer01_bottom=1}, wallCornerETop = {Airlock_Corner_lb_top=1},
wallCornerEBottom = {Airlock_Corner_lb_bottom=1}, wallCornerSTop = {Airlock_Corner_inner01_top=1},
wallCornerSBottom = {Airlock_Corner_inner01_bottom=1}, wallCornerWTop = {Airlock_Corner_rb_top=1},
wallCornerWBottom = {Airlock_Corner_rb_bottom=1}, wallTNETop = {Airlock_Corner_T_NE_top=1}, wallTNEBottom = {Airlock_Corner_T_NE_bottom=1},
wallTSETop = {Airlock_Corner_T_SE_top=1}, wallTSEBottom = {Airlock_Corner_T_SE_bottom=1}, wallTSWTop = {Airlock_Corner_T_SW_top=1},
wallTSWBottom = {Airlock_Corner_T_SW_bottom=1}, wallTNWTop = {Airlock_Corner_T_NW_top=1}, wallTNWBottom = {Airlock_Corner_T_NW_bottom=1},
wallCrossTop = {Airlock_Corner_cross_top=1}, wallCrossBottom = {Airlock_Corner_cross_bottom=1},
wallColumnTop = {Airlock_Corner_cross_top=1}, wallColumnBottom = {Airlock_Corner_cross_bottom=1}, tAmbientLightColor = { 0.3, 0.5, 0.6 },
tRoomLights = { { tLightColor = {0.1, 0.5, 0.2}, nLightTileGapX = 4, nLightTileGapY = 4, nLightRadius = 2, }, },
sLightSpriteName = 'directionalcast', class='Zones.Airlock', clickSound = 'clickairlock', portrait = 'Zone_Airlock', } Zone.REFINERY = {
name='Refinery', description="ZONEUI039TEXT", floorNames={ 'refinery01' }, associatedJob=Character.MINER,
wallStraightTop = {Refinery_Straight01_top=1}, wallStraightBottom = {Refinery_Straight01_bottom=1},
wallCornerNTop = {Refinery_Corner_outer01_top=1}, wallCornerNBottom = {Refinery_Corner_outer01_bottom=1},
wallCornerETop = {Refinery_Corner_lb_top=1}, wallCornerEBottom = {Refinery_Corner_lb_bottom=1},
wallCornerSTop = {Refinery_Corner_inner01_top=1}, wallCornerSBottom = {Refinery_Corner_inner01_bottom=1},
wallCornerWTop = {Refinery_Corner_rb_top=1}, wallCornerWBottom = {Refinery_Corner_rb_bottom=1}, wallTNETop = {Refinery_Corner_T_NE_top=1},
wallTNEBottom = {Refinery_Corner_T_NE_bottom=1}, wallTSETop = {Refinery_Corner_T_SE_top=1}, wallTSEBottom = {Refinery_Corner_T_SE_bottom=1},
wallTSWTop = {Refinery_Corner_T_SW_top=1}, wallTSWBottom = {Refinery_Corner_T_SW_bottom=1}, wallTNWTop = {Refinery_Corner_T_NW_top=1},
wallTNWBottom = {Refinery_Corner_T_NW_bottom=1}, wallCrossTop = {Refinery_Corner_cross_top=1},
wallCrossBottom = {Refinery_Corner_cross_bottom=1}, wallColumnTop = {Refinery_Corner_cross_top=1},
wallColumnBottom = {Refinery_Corner_cross_bottom=1}, tAmbientLightColor = { .47/2, .44/2, .53/2 }, tRoomLights = { {
tLightColor = { 1.0, 0.7, 0.4}, nLightTileGapX = 5, nLightTileGapY = 5, nLightRadius = 3, }, }, sLightSpriteName = 'directionalcast',
clickSound = 'clickrefinery', portrait = 'Zone_Refinery', } Zone.EXTERIOR = { name='External', floorNames={ 'base01', },
wallStraightTop = {Exterior_Straight01_top=4, Exterior_Straight02_top=15}, wallStraightBottom = {Exterior_Straight01_bottom=5},
wallCornerNTop = {Exterior_Corner_outer01_top=1}, wallCornerNBottom = {Exterior_Corner_outer01_bottom=1},
wallCornerETop = {Exterior_Corner_lb_top=1}, wallCornerEBottom = {Exterior_Corner_lb_bottom=1},
wallCornerSTop = {Exterior_Corner_inner01_top=1}, wallCornerSBottom = {Exterior_Corner_inner01_bottom=1},
wallCornerWTop = {Exterior_Corner_rb_top=1}, wallCornerWBottom = {Exterior_Corner_rb_bottom=1}, wallTNETop = {Exterior_Corner_T_NE_top=1},
wallTNEBottom = {Exterior_Corner_T_NE_bottom=1}, wallTSETop = {Exterior_Corner_T_SE_top=1}, wallTSEBottom = {Exterior_Corner_T_SE_bottom=1},
wallTSWTop = {Exterior_Corner_T_SW_top=1}, wallTSWBottom = {Exterior_Corner_T_SW_bottom=1}, wallTNWTop = {Exterior_Corner_T_NW_top=1},
wallTNWBottom = {Exterior_Corner_T_NW_bottom=1}, wallCrossTop = {Exterior_Corner_cross_top=1},
wallCrossBottom = {Exterior_Corner_cross_bottom=1}, wallColumnTop = {Exterior_Corner_cross_top=1},
wallColumnBottom = {Exterior_Corner_cross_bottom=1}, tRoomLights = { { tLightColor = {0.8, 1.0, 0.2}, nLightTileGapX = 3,
nLightTileGapY = 3, nLightRadius = 3, }, }, sLightSpriteName = 'directionalcast', clickSound = 'clickunzoned', } Zone.CONSTRUCTION = {
name='Construction', floorNames={ 'base01', }, wallStraightTop = {Wireframe_Straight01_top=1},
wallStraightBottom = {Wireframe_Straight01_bottom=1}, wallCornerNTop = {Wireframe_Corner_outer01_top=1},
wallCornerNBottom = {Wireframe_Corner_outer01_bottom=1}, wallCornerETop = {Wireframe_Corner_lb_top=1},
wallCornerEBottom = {Wireframe_Corner_lb_bottom=1}, wallCornerSTop = {Wireframe_Corner_inner01_top=1},
wallCornerSBottom = {Wireframe_Corner_inner01_bottom=1}, wallCornerWTop = {Wireframe_Corner_rb_top=1},
wallCornerWBottom = {Wireframe_Corner_rb_bottom=1}, wallTNETop = {Wireframe_Corner_T_NE_top=1},
wallTNEBottom = {Wireframe_Corner_T_NE_bottom=1}, wallTSETop = {Wireframe_Corner_T_SE_top=1},
wallTSEBottom = {Wireframe_Corner_T_SE_bottom=1}, wallTSWTop = {Wireframe_Corner_T_SW_top=1},
wallTSWBottom = {Wireframe_Corner_T_SW_bottom=1}, wallTNWTop = {Wireframe_Corner_T_NW_top=1},
wallTNWBottom = {Wireframe_Corner_T_NW_bottom=1}, wallCrossTop = {Wireframe_Corner_cross_top=1},
wallCrossBottom = {Wireframe_Corner_cross_bottom=1}, wallColumnTop = {Wireframe_Corner_cross_top=1},
wallColumnBottom = {Wireframe_Corner_cross_bottom=1}, tRoomLights = { { tLightColor = {0.8, 1.0, 0.2}, nLightTileGapX = 3,
nLightTileGapY = 3, nLightRadius = 3, }, }, } Zone.FITNESS = { name='Fitness', description="ZONEUI110TEXT",
floorNames={ 'airlock01', 'airlock02', }, wallStraightTop = { Fitness_Straight01_top=10, Fitness_Straight02_top=1, },
wallStraightBottom = {Fitness_Straight01_bottom=10,Fitness_Straight02_bottom=1,}, wallCornerNTop = {Fitness_Corner_outer01_top=1},
wallCornerNBottom = {Fitness_Corner_outer01_bottom=1}, wallCornerETop = {Fitness_Corner_lb_top=1},
wallCornerEBottom = {Fitness_Corner_lb_bottom=1}, wallCornerSTop = {Fitness_Corner_inner01_top=1},
wallCornerSBottom = {Fitness_Corner_inner01_bottom=1}, wallCornerWTop = {Fitness_Corner_rb_top=1},
wallCornerWBottom = {Fitness_Corner_rb_bottom=1}, wallTNETop = {Fitness_Corner_T_NE_top=1}, wallTNEBottom = {Fitness_Corner_T_NE_bottom=1},
wallTSETop = {Fitness_Corner_T_SE_top=1}, wallTSEBottom = {Fitness_Corner_T_SE_bottom=1}, wallTSWTop = {Fitness_Corner_T_SW_top=1},
wallTSWBottom = {Fitness_Corner_T_SW_bottom=1}, wallTNWTop = {Fitness_Corner_T_NW_top=1}, wallTNWBottom = {Fitness_Corner_T_NW_bottom=1},
wallCrossTop = {Fitness_Corner_cross_top=1}, wallCrossBottom = {Fitness_Corner_cross_bottom=1},
wallColumnTop = {Fitness_Corner_outer01_top=1}, wallColumnBottom = {Fitness_Corner_outer01_bottom=1},
tAmbientLightColor = { 0.6, 0.6, 0.6 }, tRoomLights = { { tLightColor = {1.0, 1.0, 1.0}, nLightTileGapX = 4, nLightTileGapY = 4,
nLightRadius = 2, }, }, sLightSpriteName = 'directionalcast', clickSound = 'clickbar', class='Zones.FitnessZone', portrait = 'Zone_Fitness',
} Zone.RESEARCH = { name='Research Lab', description="ZONEUI127TEXT", floorNames={ 'airlock01','airlock02', },
associatedJob=Character.SCIENTIST, wallStraightTop = { Research_Straight02_top=2, Research_Straight01_top=1, },
wallStraightBottom = {Research_Straight01_bottom=10,}, wallCornerNTop = {Research_Corner_outer01_top=1},
wallCornerNBottom = {Research_Corner_outer01_bottom=1}, wallCornerETop = {Research_Corner_lb_top=1},
wallCornerEBottom = {Research_Corner_lb_bottom=1}, wallCornerSTop = {Research_Corner_inner01_top=1},
wallCornerSBottom = {Research_Corner_inner01_bottom=1}, wallCornerWTop = {Research_Corner_rb_top=1},
wallCornerWBottom = {Research_Corner_rb_bottom=1}, wallTNETop = {Research_Corner_T_NE_top=1},
wallTNEBottom = {Research_Corner_T_NE_bottom=1}, wallTSETop = {Research_Corner_T_SE_top=1}, wallTSEBottom = {Research_Corner_T_SE_bottom=1},
wallTSWTop = {Research_Corner_T_SW_top=1}, wallTSWBottom = {Research_Corner_T_SW_bottom=1}, wallTNWTop = {Research_Corner_T_NW_top=1},
wallTNWBottom = {Research_Corner_T_NW_bottom=1}, wallCrossTop = {Research_Corner_cross_top=1},
wallCrossBottom = {Research_Corner_cross_bottom=1}, wallColumnTop = {Research_Corner_outer01_top=1},
wallColumnBottom = {Research_Corner_outer01_bottom=1}, tAmbientLightColor = { 0.3, 0.5, 0.6 }, tRoomLights = { {
tLightColor = {0.1*2, 0.5*2, 0.2*2}, nLightTileGapX = 4, nLightTileGapY = 4, nLightRadius = 3, }, }, sLightSpriteName = 'directionalcast',
clickSound = 'clickbar', class='Zones.ResearchZone', portrait = 'Zone_Research', } Zone.BRIG = { name='Brig', description="ZONEUI146TEXT",
floorNames={ 'brig01','brig02', 'brig02','brig02','brig02','brig02','brig02','brig02', 'brig03', },
wallStraightTop = { Brig_Straight02_top=1, Brig_Straight01_top=2, },
wallStraightBottom = {Brig_Straight01_bottom=5, Brig_Straight02_bottom=1}, wallCornerNTop = {Brig_Corner_outer01_top=1},
wallCornerNBottom = {Research_Corner_outer01_bottom=1}, wallCornerETop = {Brig_Corner_lb_top=1},
wallCornerEBottom = {Research_Corner_lb_bottom=1}, wallCornerSTop = {Brig_Corner_inner01_top=1},
wallCornerSBottom = {Brig_Corner_inner01_bottom=1}, wallCornerWTop = {Brig_Corner_rb_top=1}, wallCornerWBottom = {Brig_Corner_rb_bottom=1},
wallTNETop = {Brig_Corner_T_NE_top=1}, wallTNEBottom = {Brig_Corner_T_NE_bottom=1}, wallTSETop = {Brig_Corner_T_SE_top=1},
wallTSEBottom = {Brig_Corner_T_SE_bottom=1}, wallTSWTop = {Brig_Corner_T_SW_top=1}, wallTSWBottom = {Brig_Corner_T_SW_bottom=1},
wallTNWTop = {Brig_Corner_T_NW_top=1}, wallTNWBottom = {Brig_Corner_T_NW_bottom=1}, wallCrossTop = {Brig_Corner_cross_top=1},
wallCrossBottom = {Brig_Corner_cross_bottom=1}, wallColumnTop = {Brig_Corner_outer01_top=1},
wallColumnBottom = {Brig_Corner_outer01_bottom=1}, tAmbientLightColor = { 0.4, 0.45, 0.5 }, tRoomLights = { { tLightColor = {0.7, 0.5, 0.5},
nLightTileGapX = 4, nLightTileGapY = 4, nLightRadius = 1, }, }, sLightSpriteName = 'directionalcast', clickSound = 'clickbar',
portrait = 'Zone_Unzoned', class='Zones.BrigZone', } Zone.tOrderedZoneList= {
'PLAIN','GARDEN','INFIRMARY','LIFESUPPORT','RESIDENCE','PUB','POWER', 'AIRLOCK','REFINERY','FITNESS','RESEARCH','BRIG', } Zone.tZoneTypeLCs=
{ PLAIN = 'ZONEUI005TEXT', GARDEN = 'ZONEUI069TEXT', INFIRMARY = 'ZONEUI049TEXT', LIFESUPPORT = 'ZONEUI001TEXT',
RESIDENCE = 'ZONEUI042TEXT', PUB = 'ZONEUI046TEXT', POWER = 'ZONEUI003TEXT', AIRLOCK = 'ZONEUI036TEXT', REFINERY = 'ZONEUI037TEXT',
FITNESS = 'ZONEUI109TEXT', RESEARCH = 'ZONEUI126TEXT', BRIG = 'ZONEUI142TEXT', } function Zone.getZoneDataForIdx(idx)
local zoneData = Zone[ Zone.tOrderedZoneList[idx] ] return zoneData end function Zone.getUniqueZoneName(zoneName)
if zoneName == 'POWER' then return Zone.getReactorName() elseif zoneName == 'LIFESUPPORT' then return Zone.getLifeSupportName()
elseif zoneName == 'AIRLOCK' then return Zone.getAirlockName() elseif zoneName == 'RESIDENCE' then return Zone.getResidenceName()
elseif zoneName == 'REFINERY' then return Zone.getRefineryName() elseif zoneName == 'PUB' then return Zone.getPubName()
elseif zoneName == 'GARDEN' then return Zone.getGardenName() elseif zoneName == 'FITNESS' then return Zone.getFitnessName()
elseif zoneName == 'RESEARCH' then return Zone.getResearchName() elseif zoneName == 'INFIRMARY' then return Zone.getInfirmaryName()
elseif zoneName == 'BRIG' then return Zone.getBrigName() else return g_LM.line('ZONEUI108TEXT') end end function Zone.getBrigName()
local name = g_LM.line('ZONEUI145TEXT') return name .. ' ' .. tostring(math.random(1, 99)) end
local greekLetters = { 'ZONEUI018TEXT', 'ZONEUI019TEXT', 'ZONEUI020TEXT', 'ZONEUI021TEXT', 'ZONEUI022TEXT', 'ZONEUI023TEXT', 'ZONEUI024TEXT', 'ZONEUI025TEXT', 'ZONEUI026TEXT', 'ZONEUI027TEXT', 'ZONEUI028TEXT', 'ZONEUI029TEXT', 'ZONEUI030TEXT', 'ZONEUI031TEXT', 'ZONEUI032TEXT', 'ZONEUI033TEXT' }
Zone.greekLetters = greekLetters function Zone.getReactorName() local name = g_LM.line( 'ZONEUI034TEXT' )
local letterCode = greekLetters[math.random( 1, #greekLetters-1 )] name = name .. ' ' .. g_LM.line( letterCode ) return name end
function Zone.getResearchName() local name = g_LM.line( 'ZONEUI128TEXT' ) local letterCode = greekLetters[math.random( 1, #greekLetters-1 )]
name = name .. ' ' .. g_LM.line( letterCode ) return name end
local constellations = { 'ZONEUI130TEXT', 'ZONEUI131TEXT', 'ZONEUI132TEXT', 'ZONEUI133TEXT', 'ZONEUI134TEXT', 'ZONEUI135TEXT', 'ZONEUI136TEXT', 'ZONEUI137TEXT', 'ZONEUI138TEXT', 'ZONEUI139TEXT', 'ZONEUI140TEXT', }
function Zone.getInfirmaryName() local name = g_LM.line( 'ZONEUI129TEXT' )
local letterCode = constellations[math.random( 1, #constellations-1 )] name = name .. ' ' .. g_LM.line( letterCode ) return name end
function Zone.getLifeSupportName() local name = g_LM.line( 'ZONEUI035TEXT' ) if math.random() < 0.01 then name = name .. ' 0451' else
name = name .. ' ' .. math.random(0, 99) local letters = 'ABCDEFGHJKLMNPQRSTUVWXYZ' local letterIndex = math.random(1, #letters-1)
name = name .. string.sub(letters, letterIndex, letterIndex) end return name end function Zone.getAirlockName()
local name = g_LM.line( 'ZONEUI041TEXT' ) local alpha = 'ABCDEFGHJKLMNPQRSTUVWXYZ' local idx = math.random(1, #alpha-1)
name = name .. ' ' .. string.sub(alpha, idx, idx) return name end function Zone.getResidenceName() local name = g_LM.line('ZONEUI141TEXT')
name = name .. ' ' .. tostring( math.random(1, 99)) if math.random() < 0.5 then local lower = 'abcdefghjkmnpqrstuvwxyz'
local idx = math.random(1, #lower-1) name = name .. string.sub(lower, idx, idx) end return name end function Zone.getRefineryName()
local name = g_LM.line( 'ZONEUI068TEXT' ) .. ' ' name = name .. tostring(math.random(10)-1) name = name .. tostring(math.random(10)-1)
name = name .. tostring(math.random(10)-1) name = name .. tostring(math.random(10)-1) return name end
local colors = { 'ZONEUI073TEXT', 'ZONEUI074TEXT', 'ZONEUI075TEXT', 'ZONEUI076TEXT', 'ZONEUI077TEXT', 'ZONEUI078TEXT', 'ZONEUI079TEXT', 'ZONEUI080TEXT', 'ZONEUI081TEXT', 'ZONEUI082TEXT', 'ZONEUI083TEXT', 'ZONEUI084TEXT', }
function Zone.getGardenName() return g_LM.line('ZONEUI085TEXT') .. ' ' .. g_LM.randomLine(colors) end
local tMythologicalFigures = { 'ZONEUI114TEXT', 'ZONEUI115TEXT', 'ZONEUI116TEXT', 'ZONEUI117TEXT', 'ZONEUI118TEXT', 'ZONEUI119TEXT', 'ZONEUI120TEXT', 'ZONEUI121TEXT', 'ZONEUI122TEXT', 'ZONEUI123TEXT', 'ZONEUI124TEXT', 'ZONEUI125TEXT',}
function Zone.getFitnessName() return g_LM.line('ZONEUI113TEXT') .. ' ' .. g_LM.randomLine(tMythologicalFigures) end
local tPubAdjectives = { 'ZONEUI087TEXT', 'ZONEUI088TEXT', 'ZONEUI089TEXT', 'ZONEUI090TEXT', 'ZONEUI091TEXT', 'ZONEUI092TEXT', 'ZONEUI093TEXT', 'ZONEUI094TEXT', 'ZONEUI095TEXT', 'ZONEUI096TEXT', 'ZONEUI097TEXT', }
local tPubNouns = { 'ZONEUI098TEXT', 'ZONEUI099TEXT', 'ZONEUI100TEXT', 'ZONEUI101TEXT', 'ZONEUI102TEXT', 'ZONEUI103TEXT', 'ZONEUI104TEXT', 'ZONEUI105TEXT', 'ZONEUI106TEXT', 'ZONEUI107TEXT', }
function Zone.getPubName() local name = g_LM.line('ZONEUI086TEXT') .. ' ' name = name .. g_LM.randomLine(tPubAdjectives) .. ' '
name = name .. g_LM.randomLine(tPubNouns) return name end function Zone.initZoneData()
local EnvObjectData = require('EnvObjects.EnvObjectData')
Zone.spriteSheet = DFGraphics.loadSpriteSheet(Zone.spriteSheetPath, false, false, true) for i,v in ipairs(Zone.tOrderedZoneList) do
local tZoneData = Zone[v] tZoneData.indexes={} tZoneData.tValidObjectTypes = {} for _,spriteName in ipairs(tZoneData.floorNames) do
table.insert(tZoneData.indexes,Zone.spriteSheet.names[spriteName]) end end for k,v in pairs(EnvObjectData.tObjects) do if v.zoneName then
table.insert(Zone[v.zoneName].tValidObjectTypes, k) end end end function Zone:init(rRoom) self.rRoom = rRoom
self.sZoneName = rRoom:getZoneName() self.tThingsPowered = {} self.tOrderedThingsPowered = {} end function Zone:getRoom() return self.rRoom
end function Zone:preTileUpdate() end function Zone:postTileUpdate() end function Zone:isFunctionalAirlock()
return self.sZoneName == 'AIRLOCK' and self.bFunctional end function Zone:isCharAssigned() return false end function Zone:remove()
self.bRemoved = true self.bDestroyed = true end function Zone:getActivityOptions(rChar, tObjects) end function Zone:getPowerOutput()
local tPowerProducers = {} local nTotalPowerOutput = 0 local tProps = self.rRoom:getProps()
local EnvObject = require('EnvObjects.EnvObject') for rProp,_ in pairs(tProps) do local nOutput = rProp:getPowerOutput() if nOutput > 0 then
nTotalPowerOutput = nTotalPowerOutput + nOutput tPowerProducers[rProp] = nOutput end end
local tExtra = g_SpaceRoom:getExtraGeneratorsForRoom(self.rRoom.id) for _,rProp in ipairs(tExtra) do local nOutput = rProp:getPowerOutput()
if nOutput > 0 then nTotalPowerOutput = nTotalPowerOutput + nOutput tPowerProducers[rProp] = nOutput end end
local x,y = self.rRoom:getCenterTile() return nTotalPowerOutput, tPowerProducers end function Zone:isPowering(rRoomOrObj)
return self.tThingsPowered[rRoomOrObj] ~= nil end function Zone:powerUnrequest(rRoomOrObj) if self.tThingsPowered[rRoomOrObj] then
self.tThingsPowered[rRoomOrObj] = nil rRoomOrObj.rPowerRoom = nil for i = 1, #self.tOrderedThingsPowered do
if rRoomOrObj == self.tOrderedThingsPowered[i] then table.remove(self.tOrderedThingsPowered, i) break end end end end function Zone:onTick()
for rObj,tData in pairs(self.tThingsPowered) do if rObj.bDestroyed then self:powerUnrequest(rObj) end end end
function Zone:getAssociatedJob() local zoneDef = Zone[self.sZoneName] return zoneDef.associatedJob end
function Zone:powerRequest(rRoomOrObj, nAmount, bNoPartial) local x,y = self.rRoom:getCenterTile() local cx,cy = rRoomOrObj:getTileLoc()
local nDist = DFMath.distance2D(x, y, cx, cy) local tPowerUser if self.tThingsPowered[rRoomOrObj] then
tPowerUser = self.tThingsPowered[rRoomOrObj] else tPowerUser = {} self.tThingsPowered[rRoomOrObj] = tPowerUser
table.insert(self.tOrderedThingsPowered, rRoomOrObj) end rRoomOrObj.rPowerRoom = self.rRoom tPowerUser.nDist = nDist
tPowerUser.nTiebreaker = cx * 1000 + cy tPowerUser.nPowerRequested = nAmount local f = function(x,y)
if self.tThingsPowered[x].nDist == self.tThingsPowered[y].nDist then
return self.tThingsPowered[x].nTiebreaker < self.tThingsPowered[y].nTiebreaker end
return self.tThingsPowered[x].nDist < self.tThingsPowered[y].nDist end table.sort(self.tOrderedThingsPowered, f)
local nTotalPowerOutput = self:getPowerOutput() local i = 1 while i <= #self.tOrderedThingsPowered and nTotalPowerOutput > 0 do
local rObj = self.tOrderedThingsPowered[i] local tPowerUser = self.tThingsPowered[rObj]
nTotalPowerOutput = nTotalPowerOutput - tPowerUser.nPowerRequested if rObj == rRoomOrObj then if nTotalPowerOutput >= 0 then
tPowerUser.nPowerGranted = nAmount return nAmount else if bNoPartial then self:powerUnrequest(rObj) tPowerUser.nPowerGranted = 0 return 0
else tPowerUser.nPowerGranted = nAmount + nTotalPowerOutput return nAmount + nTotalPowerOutput end end end i = i + 1 end if bNoPartial then
self:powerUnrequest(rRoomOrObj) end tPowerUser.nPowerGranted = 0 return 0 end return Zone
