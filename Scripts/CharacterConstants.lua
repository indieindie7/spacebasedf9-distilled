local function _h1(a0,a1,a2,a3) return {bHasHelmet=a0,bHasSuit=a1,sTopLayer=a2,sBottomLayer=a3} end
local function _h2(a0,a1,a2,a3,a4,a5) return {nRig=a0,sSex=a1,sBodyModel=a2,sBodyTexture=a3,tHeads=a4,nAccessorySetType=a5} end
local function _h3(a0,a1,a2,a3,a4,a5,a6) return {nRig=a0,sSex=a1,sBodyModel=a2,sBodyTexture=a3,tHeads=a4,nAccessorySetType=a5,bFat=a6} end
local function _h4(a0,a1,a2,a3,a4,a5,a6) return {nRig=a0,sSex=a1,sBodyModel=a2,sBodyTexture=a3,tHeads=a4,nAccessorySetType=a5,tJobOutfits=a6} end
local function _h5(a0,a1,a2,a3,a4,a5,a6,a7) return {nRig=a0,sSex=a1,sBodyModel=a2,sBodyTexture=a3,bFat=a4,tHeads=a5,nAccessorySetType=a6,tJobOutfits=a7} end
local function _h6(a0,a1,a2,a3,a4,a5,a6) return {nRig=a0,sSex=a1,sBodyModel=a2,sBodyTexture=a3,bFat=a4,tHeads=a5,nAccessorySetType=a6} end
local function _h7(a0,a1,a2) return {sModel=a0,sTexture=a1,tJobModelConflicts=a2} end
local function _h8(a0,a1,a2) return {Level1=a0,Level2=a1,Level3=a2} end
local _D = {}
local Class=require('Class')
local Gui=require('UI.Gui')
local CharacterConstants = Class.create(nil, MOAIProp.new)
local function S(t) for k,v in pairs(t) do CharacterConstants[k]=v end end
CharacterConstants.NUM_VARIATIONS = 10
CharacterConstants.DIR_ROT =
{
    S=0,
    SE=45,
    E=90,
    NE=135,
    N=180,
    NW=225,
    W=270,
    SW=315,
}
CharacterConstants.ROT_DIR=
{
    {15,'SE'},
    {75,'E'},
    {105,'NE'},
    {165,'N'},
    {195,'NW'},
    {255,'W'},
    {285,'SW'},
    {345,'S'},
}
CharacterConstants.PERSONALITY_TRAITS=
{
    nBravery=1,
    nGregariousness=2,
	nChattiness=3,
    nNeatness=4,
    bEmoticon=5,
    nTemper=7,
    nWorkEthic=8,
    bXenophobe=9,
    bAnxious=10,
    bGourmand=11,
    bJoker=12,
    bSentimental=13,
    bCompetitive=15,
    bLowerCase=16,
    bHipster=17,
    nPositivity=18,
	nAuthoritarian=19,
}
CharacterConstants.PERSONALITY_LINE=
{
    nBravery = { nHigh='PERSON001TEXT', nLow='PERSON008TEXT' },
    nGregariousness = { nHigh='PERSON002TEXT', nLow='PERSON009TEXT' },
    nChattiness = { nHigh='PERSON003TEXT', nLow='PERSON010TEXT' },
    nNeatness = { nHigh='PERSON004TEXT', nLow='PERSON011TEXT' },
    nTemper = { nHigh='PERSON012TEXT', nLow='PERSON013TEXT' },
    nWorkEthic = { nHigh='PERSON014TEXT', nLow='PERSON015TEXT' },
    nPositivity = { nHigh='PERSON016TEXT', nLow='PERSON017TEXT' },
	nAuthoritarian = { nHigh='PERSON027TEXT', nLow='PERSON028TEXT', },
}
CharacterConstants.QUIRK_LINE=
{
	bXenophobe = 'PERSON018TEXT',
	bAnxious = 'PERSON020TEXT',
	bGourmand = 'PERSON021TEXT',
	bJoker = 'PERSON019TEXT',
	bSentimental = 'PERSON022TEXT',
	bCompetitive = 'PERSON023TEXT',
	bHipster = 'PERSON024TEXT',
}
CharacterConstants.PERSONALITY_LIKELIHOOD=
{
    bEmoticon = 0.1,
    bJoker = 0.2,
    bXenophobe = 0.1,
    bHipster = 0.2,
    bLowerCase = 0.05,
	bCompetitive = 0.3,
}
CharacterConstants.PERSONALITY_ADJECTIVE_LINE=
{
    { nMin = 0, linecode = 'PERSON007TEXT', },
    { nMin = 0.35, linecode = 'PERSON006TEXT', },
	{ nMin = 0.5, linecode = 'PERSON026TEXT', },
    { nMin = 0.85, linecode = 'PERSON005TEXT', },
}
CharacterConstants.SELF_ESTEEM_LINE=
{
    { nMin = -10, linecode = 'INSPEC128TEXT', },
    { nMin = -8, linecode = 'INSPEC129TEXT', },
    { nMin = -5, linecode = 'INSPEC130TEXT', },
    { nMin = -3, linecode = 'INSPEC131TEXT', },
    { nMin = -1, linecode = 'INSPEC132TEXT', },
    { nMin = 1, linecode = 'INSPEC133TEXT', },
    { nMin = 3, linecode = 'INSPEC134TEXT', },
    { nMin = 5, linecode = 'INSPEC135TEXT', },
    { nMin = 8, linecode = 'INSPEC136TEXT', },
    { nMin = 10, linecode = 'INSPEC137TEXT', },
}
S{TEAM_ID_NONE=0,TEAM_ID_PLAYER=1,TEAM_ID_DEBUG_ENEMYGROUP=-2,TEAM_ID_PLAYER_ABANDONED=3,TEAM_ID_DEBUG_MONSTER=-3,TEAM_ID_DEBUG_FRIENDLY=-4,TEAM_ID_FIRST_USABLE=100}
CharacterConstants.FACTION_BEHAVIOR=
{
    Citizen=1,
    Monster=2,
    Friendly=3,
    EnemyGroup=4,
	KillBot=5,
}
CharacterConstants.THREAT_LEVEL=
{
    None=0,
    NormalCitizen=1,
    BadCitizen=3,
    Raider=3,
    Turret=3,
    Monster=4,
}
CharacterConstants.ATTACK_TYPE=
{
    Grapple=1,
    Ranged=2,
    Stunner=3,
}
S{HUMAN_MELEE_DAMAGE=20,MONSTER_MELEE_DAMAGE=40,MELEE_RANGE=2,DEFAULT_PROJECTILE_ATTACH_JOINT='Rt_Prop'}
CharacterConstants.DEFAULT_PROJECTILE_ATTACH_OFFSET = { 0, 0, 0 }
S{SPRITE_NAME_FRIENDLY_RIFLE='temp_laser_blue',SPRITE_NAME_ENEMY_RIFLE='temp_laser',SPRITE_NAME_FRIENDLY_PISTOL='pistol_laser_blue',SPRITE_NAME_ENEMY_PISTOL='pistol_laser'}
CharacterConstants.DAMAGE_TYPE=
{
    None=0,
    Melee=1,
    Laser=2,
    Fire=3,
    Acid=4,
    Impact=6,
    Stunner=7,
}
CharacterConstants.PremadePortraits={
    ['JP LeBreton'] = 'jp',
    ['Gabe Miller'] = 'Gabe',
    ['Chris Remo'] = 'Chris',
    ['Matt Franklin'] = 'Matt',
    ['Kee Chi'] = 'Kee',
    ['Ben Burbank'] = 'Ben',
    ['Jeremy Mitchell'] = 'Jeremy',
    ['Tim Schafer'] = 'Tim',
}
CharacterConstants.AccessoryDefs = {
    Rifle = { sTexture='Props/Tools/Rifle/Textures/Rifle', sRig ='Props/Tools/Rifle/Rig/Rifle.rig', tOff={0,0,0}},
    Pistol = { sTexture='Props/Tools/Rifle/Textures/Rifle', sRig ='Props/Tools/Pistol/Rig/Pistol.rig', tOff={0,0,0}},
    Bodybag = { sTexture='Props/Tools/Bodybag/Textures/Bodybag01', sRig ='Props/Tools/BodyBag/Rig/BodyBag.rig', tOff={0,0,0}},
    Cigarette = { sTexture='Props/Tools/Cigarette/Textures/Cigarette', sRig ='Props/Tools/Cigarette/Rig/Cigarette.rig', tOff={0,0,0}},
    Datapad = { sTexture='Props/Tools/Datapad/Textures/Datapad01', sRig ='Props/Tools/Datapad/Rig/Datapad.rig', tOff={0,0,0}},
    Extinguisher = { sTexture='Props/Tools/FireExtinguisher/Textures/Tools', sRig ='Props/Tools/FireExtinguisher/Rig/FireExtinguisher.rig', tOff={0,0,0}},
    GameSystem = { sTexture='Props/Tools/Spaceboy64/Textures/Spaceboy01', sRig ='Props/Tools/Spaceboy64/Rig/Spaceboy64.rig', tOff={0,0,0}},
    Mug = { sTexture='Props/Tools/Mug/Textures/Mug01', sRig ='Props/Tools/Mug/Rig/Mug01.rig', tOff={0,0,0}},
    Weldammer = { sTexture='Props/Tools/Weldammer/Textures/Weldammer', sRig ='Props/Tools/Weldammer/Rig/Weldammer.rig', tOff={0,0,0}},
    DebugRock = { sTexture='Props/Asteroid/AsteroidChunk/Textures/AsteroidChunk01', sRig='Props/Asteroid/AsteroidChunk/Rig/AsteroidChunk.rig', tOff={0,0,0}},
    Builder = { sTexture='Characters/Citizen_Base/Textures/Builder', sRig ='Props/Tools/Builder/Rig/Builder.rig', tOff={0,0,0}},
    Sphere = { sTexture="Characters/Primitives/Textures/Gray.png", sRig="Characters/Primitives/Rig/Sphere.rig", tOff={0,0,0}},
    Cube = { sTexture="Characters/Primitives/Textures/Gray.png", sRig="Characters/Primitives/Rig/Cube.rig", tOff={0,0,0}},
    FoodBar = { sTexture="Props/FoodItems/Textures/fooditems.png", sRig="Props/FoodItems/FoodBar/Rig/FoodBar.rig", tOff={0,0,0}},
    FoodVegetable = { sTexture="Props/FoodItems/Textures/fooditems.png", sRig="Props/FoodItems/Carrot/Rig/Carrot.rig", tOff={0,0,0}},
    FoodFork = { sTexture="Props/FoodItems/Textures/fooditems.png", sRig="Props/FoodItems/Fork/Rig/Fork.rig", tOff={0,0,0}},
    FryingPan = { sTexture="Props/FoodItems/Textures/fooditems.png", sRig="Props/FoodItems/FryingPan/Rig/FryingPan.rig", tOff={0,0,0}},
    Barbell = { sTexture="Props/Tools/Barbell/Textures/barbell01.png", sRig="Props/Tools/Barbell/Rig/Barbell01.rig", tOff={0,0,0}},
    Dumbell = { sTexture="Props/Tools/Barbell/Textures/barbell01.png", sRig="Props/Tools/Dumbell/Rig/Dumbell.rig", tOff={0,0,0}},
}
S{CHAT_COOLDOWN=10,CHAT_PUB_BONUS=100,MAX_AFFINITY=20,MAX_AFFINITY_INVERSE=1/20,STARTING_AFFINITY=10,ACTIVITY_AFFINITY_CHANGE_PCT=0.2,AFFINITY_CHANGE_MINOR=1,AFFINITY_CHANGE_MEDIUM=4,IMMIGRATION_ADD_TOPIC_CHANCE=0.1,THING_WEIGHT=0.5,FRIEND_AFFINITY=5,ENEMY_AFFINITY=-5,DUTY_AFFINITY_LIKE=2.5,DUTY_AFFINITY_DISLIKE=-2.5,DUTY_AFFINITY_XP_MAX_RATE=0.5,DUTY_AFFINITY_MORALE_MAX=0.4,STUFF_AFFINITY_PICKUP_THRESHOLD=2,STUFF_AFFINITY_DISCARD_THRESHOLD=-1,MAX_OWNED_STUFF=10,SATISFACTION_UTILITY_SCALE=1/10,MAX_INVENTORY=5,STUFF_MIN_HOLD_TIME=60*4,STARTING_HIT_POINTS=100,HURT_THRESHOLD=30,SCUFFED_UP_THRESHOLD=80,HEAL_RATE=0.05,SELF_HEAL_COOLDOWN=15,NEEDS_REDUCE_TICK=14.4,NEEDS_HUNGER_STARVATION=-90,TIME_BEFORE_STARVATION=60 * 10,NEEDS_ENERGY_TIRED=-50,NEEDS_STUFF_LOW=-50,FIRE_DAMAGE_RATE=5}
CharacterConstants.BLOOD_DECALS = { "blood01", "blood02", "blood03", "blood04", "blood05" }
S{GRAPH_TICK_RATE=3,GRAPH_MAX_ENTRIES=200,TASK_LOGS_MAX=100,BASE_LOG_SKILL_UP_DURATION=30,MORALE_TICK=15,SURVIVAL_TICK=1,OXYGEN_TICK=0.25,MORALE_MAX=100,MORALE_MIN=-100,MORALE_EVENTS_LOG_MAX=100,MORALE_COMPETENCY_THRESHOLD=33,MORALE_COMPETENCY_MODIFIER=0.5,MORALE_SPEED_THRESHOLD=50,MORALE_LOW_SPEED_MODIFIER=-0.3,MORALE_HIGH_SPEED_MODIFIER=0.1,MORALE_NEEDS_LOW=-20,MORALE_NEEDS_DECREASE=-0.1,MORALE_NEEDS_HIGH=25,MORALE_NEEDS_INCREASE=0.1,MAX_ROOM_MORALE_SCORE=0.5,ROOM_MORALE_FALLOFF_START=30,ROOM_MORALE_FALLOFF_END=60,MAX_ROOM_MORALE_BOOST=0.4,ROOM_MORALE_TICK=3,CORPSE_ROOM_MORALE_SCORE=-20}
CharacterConstants.ROOM_MORALE_SAMPLES = CharacterConstants.MORALE_TICK / CharacterConstants.ROOM_MORALE_TICK
CharacterConstants.ROOM_MORALE_LOG_THRESHOLD = 0.8
CharacterConstants.MORALE_UI_TEXT =
{
    { nMinMorale = -100, linecode = "INSPEC068TEXT", },
    { nMinMorale = -75, linecode = "INSPEC064TEXT", },
    { nMinMorale = -50, linecode = "INSPEC023TEXT", },
    { nMinMorale = -25, linecode = "INSPEC065TEXT", },
    { nMinMorale = -5, linecode = "INSPEC025TEXT", },
    { nMinMorale = 5, linecode = "INSPEC066TEXT", },
    { nMinMorale = 25, linecode = "INSPEC024TEXT", },
    { nMinMorale = 50, linecode = "INSPEC067TEXT", },
    { nMinMorale = 75, linecode = "INSPEC069TEXT", },
}
CharacterConstants.ANGER_UI_TEXT =
{
	{ nMinAnger = 0, linecode = 'INSPEC178TEXT' },
	{ nMinAnger = 10, linecode = 'INSPEC179TEXT' },
	{ nMinAnger = 20, linecode = 'INSPEC180TEXT' },
	{ nMinAnger = 30, linecode = 'INSPEC181TEXT' },
	{ nMinAnger = 40, linecode = 'INSPEC182TEXT' },
	{ nMinAnger = 50, linecode = 'INSPEC183TEXT' },
	{ nMinAnger = 60, linecode = 'INSPEC184TEXT' },
	{ nMinAnger = 70, linecode = 'INSPEC186TEXT' },
	{ nMinAnger = 80, linecode = 'INSPEC185TEXT' },
	{ nMinAnger = 90, linecode = 'INSPEC187TEXT' },
}
S{MORALE_NEEDS_MET_BONUS=0.5,MORALE_LOW_OXYGEN=-0.1,MORALE_LOW_OXYGEN_THRESHOLD=550,MORALE_NICE_CHAT=0,MORALE_MET_NEW_CITIZEN=6,MORALE_MINE_ASTEROID=0,MORALE_MAINTAIN_OBJECT=0,MORALE_MAINTAIN_PLANT=0,MORALE_REPAIR_OBJECT=0,MORALE_BUILD_BASE=0,MORALE_DID_HOBBY=0,MORALE_WOKE_UP_BED=4,MORALE_DELIVERED_FOOD=0,MORALE_SERVED_MEAL=1,MORALE_DRANK_BASE=3,MORALE_DRANK_MAX=6,MORALE_ATE_MEAL_BASE=1,MORALE_ATE_MEAL_MAX=10,MORALE_HAPPY_CHAT_BASE=1,MORALE_HAPPY_CHAT_MAX=10,MORALE_BAD_CHAT=0,MORALE_SLEPT_ON_FLOOR=-1,MORALE_CITIZEN_DIES_MIN=-4,MORALE_CITIZEN_DIES_MAX=-60,MORALE_MAX_FAMILIARITY_DEATH=100,MORALE_MAX_AFFINITY_DEATH=10,ANGER_BAD_CONVO_WITH_NORMAL=1,ANGER_BAD_CONVO_WITH_JERK=5,ANGER_NEARBY_BRAWL=15,ANGER_NEARBY_RAMPAGE=25,ANGER_EMBRIGGENED_UNJUST=60,ANGER_EMBRIGGENED_JUST=15,ANGER_JOB_FAIL_TINY=5,ANGER_JOB_FAIL_MINOR=15,ANGER_JOB_FAIL_MAJOR=25,ANGER_BAD_FOOD=10,REPLICATOR_FOOD=3,ANGER_MAX=100,ANGER_REDUCTION_PER_MORALE_TICK=1,ANGER_REDUCTION_PER_MORALE_TICK_BRIG=2,STATUS_RAMPAGE=1,STATUS_RAMPAGE_NONVIOLENT=2,STATUS_RAMPAGE_VIOLENT=3,VIOLENT_RAMPAGE_CHANCE=.25,FAMILIARITY_TICK_RATE=5,FAMILIARITY_TICK_INCREASE=0.1,FAMILIARITY_CHAT=4,FAMILIARITY_SERVE_MEAL=0.5,LOG_RECENT_HISTORY=5,LOG_RATE_MIN=5,LOG_RATE_MAX=15,LOG_MORALE_NEEDS_RATE=180,PUB_CAPACITY=3,PUB_CITIZENS_PER_BARTENDER=5,RENDER_LAYER='WorldWall',BACKGROUND_RENDER_LAYER='WorldOutlines',SIGHT_RADIUS=18,OXYGEN_PER_SECOND=200,OXYGEN_LOW=400,OXYGEN_SUFFOCATING=100,OXYGEN_SUFFOCATION_UNTIL_DEATH=60,OXYGEN_AVERAGE_SAMPLE=5}
CharacterConstants.SPACESUIT_MAX_OXYGEN = 480 * CharacterConstants.OXYGEN_PER_SECOND
CharacterConstants.SPACESUIT_OXYGEN_SUFFOCATING = CharacterConstants.OXYGEN_SUFFOCATION_UNTIL_DEATH * CharacterConstants.OXYGEN_PER_SECOND
S{UNNECESSARY_SPACESUIT_REMOVE=10,STARTLE_CHANCE=0.75,TIME_BETWEEN_IDLE_ANIMS_RAMPAGE=60,TIME_BETWEEN_IDLE_ANIMS=120,TIME_BETWEEN_IDLE_ANIMS_TIRED=60,STATUS_HEALTHY=1,STATUS_HURT=2,STATUS_SICK=3,STATUS_DEAD=4,STATUS_INCAPACITATED=5,STATUS_ILL=6,STATUS_SCUFFED_UP=7}
CharacterConstants.HEALTH_STATUS_LINE=
{
    [CharacterConstants.STATUS_HEALTHY] = "INSPEC022TEXT",
    [CharacterConstants.STATUS_HURT] = "INSPEC021TEXT",
    [CharacterConstants.STATUS_SICK] = "INSPEC009TEXT",
    [CharacterConstants.STATUS_DEAD] = "INSPEC010TEXT",
    [CharacterConstants.STATUS_INCAPACITATED] = "INSPEC142TEXT",
    [CharacterConstants.STATUS_ILL] = "INSPEC143TEXT",
    [CharacterConstants.STATUS_SCUFFED_UP] = "INSPEC151TEXT",
}
CharacterConstants.ROBOT_HEALTH_STATUS_LINE=
{
    [CharacterConstants.STATUS_HEALTHY] = "INSPEC089TEXT",
    [CharacterConstants.STATUS_HURT] = "INSPEC090TEXT",
    [CharacterConstants.STATUS_SICK] = "INSPEC092TEXT",
    [CharacterConstants.STATUS_DEAD] = "INSPEC091TEXT",
    [CharacterConstants.STATUS_INCAPACITATED] = "INSPEC142TEXT",
    [CharacterConstants.STATUS_ILL] = "INSPEC142TEXT",
    [CharacterConstants.STATUS_SCUFFED_UP] = "INSPEC151TEXT",
}
CharacterConstants.CORPSE_DURATION = 60*10
CharacterConstants.CAUSE_OF_DEATH = {
    UNSPECIFIED = 1,
    DEBUG = 2,
    SUFFOCATION = 3,
    FIRE = 4,
    DISEASE = 5,
    COMBAT_RANGED = 6,
    SUCKED_INTO_SPACE = 7,
    PARASITE = 8,
    STARVATION = 9,
    COMBAT_MELEE = 10,
}
S{INFESTATION_CHANCE=.025,INFESTATION_LOG_TIME=60 * 5,WORKOUT_COOLDOWN=60*2,GAMING_COOLDOWN=60*2}
CharacterConstants.tDeathCauses=
{
	[CharacterConstants.CAUSE_OF_DEATH.UNSPECIFIED] = 'INSPEC103TEXT',
	[CharacterConstants.CAUSE_OF_DEATH.DEBUG] = 'INSPEC108TEXT',
	[CharacterConstants.CAUSE_OF_DEATH.SUFFOCATION] = 'INSPEC098TEXT',
	[CharacterConstants.CAUSE_OF_DEATH.FIRE] = 'INSPEC100TEXT',
	[CharacterConstants.CAUSE_OF_DEATH.DISEASE] = 'INSPEC109TEXT',
	[CharacterConstants.CAUSE_OF_DEATH.COMBAT_RANGED] = 'INSPEC102TEXT',
	[CharacterConstants.CAUSE_OF_DEATH.SUCKED_INTO_SPACE] = 'INSPEC105TEXT',
	[CharacterConstants.CAUSE_OF_DEATH.PARASITE] = 'INSPEC104TEXT',
	[CharacterConstants.CAUSE_OF_DEATH.STARVATION] = 'INSPEC099TEXT',
	[CharacterConstants.CAUSE_OF_DEATH.COMBAT_MELEE] = 'INSPEC101TEXT',
}
S{MAX_COMPETENCY=10,MAX_STARTING_COMPETENCY=2,STARTING_SKILL_POINTS=8,MAX_CHANCE_TO_FAIL=0.1,MIN_CHANCE_TO_FAIL=0,NO_FAIL_COMPETENCY_THRESHOLD=0.9,FAILURE_XP_PENALTY=0.5,EXPERIENCE_PER_LEVEL=200,JOB_EXPERIENCE_RATE=25.0 / 60.0}
CharacterConstants.tJobLevels =
{
    {
        nLevel = 1,
        nMinCompetency = 0,
        sTextureName = 'ui_jobs_skillrank1'
    },
    {
        nLevel = 2,
        nMinCompetency = .16,
        sTextureName = 'ui_jobs_skillrank2'
    },
    {
        nLevel = 3,
        nMinCompetency = .28,
        sTextureName = 'ui_jobs_skillrank3'
    },
    {
        nLevel = 4,
        nMinCompetency = .60,
        sTextureName = 'ui_jobs_skillrank4'
    },
    {
        nLevel = 5,
        nMinCompetency = .90,
        sTextureName = 'ui_jobs_skillrank5'
    },
}
S{XP_FIRE_EXTINGUISH=15,XP_COMBAT_KILL=15,XP_COMBAT_DAMAGE=1,XP_BUILD_BASE=2,MEMORY_WORKED_OUT_RECENTLY='bWorkedOutRecently',MEMORY_PLAYED_GAME_RECENTLY='bPlayedGameRecently',MEMORY_LAST_BED='tLastSleptInBed',MEMORY_ATTEMPTED_MONSTER_SPAWN_RECENTLY='bRecentlyTriedToSpawnMonster',MEMORY_TOOK_DAMAGE_RECENTLY='bTookDamageRecently',MEMORY_ENTERED_COMBAT_RECENTLY='bEnteredCombatRecently',MEMORY_GENERIC_LOG='bMadeGenericLogRecently',GENERIC_LOG_FREQUENCY=240,MEMORY_STUFF_NEED='bMadeStuffNeedLogRecently',STUFF_NEED_LOG_FREQUENCY=800,MEMORY_PRISON_ANGER_RECENTLY='bPrisonAngerRecently',MEMORY_EXPLORED_RECENTLY='bExploredRecently',MAX_LOG_ENTRIES=100,MEMORY_ROOM_BREACHED_PREFIX='bRoomBreached',MEMORY_ROOM_COMBAT_PREFIX='bCombatInRoom',MEMORY_ROOM_FIRE_PREFIX='bFireInRoom',MEMORY_ROOM_LOWO2_PREFIX='bLowOxygenInRoom',MEMORY_LOGGED_RECENTLY='bLoggedRecently',MEMORY_LOGGED_MORALE_RECENTLY='bLoggedMoraleRecently',MEMORY_ATTEMPTED_MONSTER_LOG_RECENTLY='bRecentLogAboutParasite',MEMORY_LOGGED_PATROL_RECENTLY='bLoggedPatrolRecently',PATROL_LOG_FREQUENCY=120,MEMORY_LOGGED_RESEARCH_RECENTLY='bLoggedResearchRecently',MEMORY_SENT_TO_HOSPITAL='bSentToHospital',MEMORY_STARTLED_RECENTLY='bStartledRecently',MEMORY_STARTLED_RECENTLY_DURATION=15,MEMORY_SAW_TANTRUM_RECENTLY='tSawTantrum',BASE_SPEED=1.5,RUN_SPEED=2.2,UNEMPLOYED=1,BUILDER=2,TECHNICIAN=3,MINER=4,EMERGENCY=5,RAIDER=6,BARTENDER=7,BOTANIST=8,SCIENTIST=9,EMERGENCY2=10,EMERGENCY3=11,DOCTOR=12}
CharacterConstants.tJobs = {
	CharacterConstants.BUILDER, CharacterConstants.TECHNICIAN,
	CharacterConstants.MINER, CharacterConstants.EMERGENCY,
	CharacterConstants.BARTENDER, CharacterConstants.BOTANIST,
	CharacterConstants.SCIENTIST, CharacterConstants.DOCTOR,
}
S{COMPETENCY_LEVEL1=1,COMPETENCY_LEVEL2=2,COMPETENCY_LEVEL3=3,COMPETENCY_LEVEL4=4,COMPETENCY_LEVEL5=5,WELDER=1,DATAPAD=2,RIFLE=3,ROCK=4,BEER=5,SHIFT_COOLDOWN=360,SHIFT_DURATION=270,SLEEP_DURATION=270,VACUUM_VEC_SAMPLES=5}
CharacterConstants.DISPLAY_JOBS = {
CharacterConstants.UNEMPLOYED,
CharacterConstants.BUILDER,
CharacterConstants.TECHNICIAN,
CharacterConstants.MINER,
CharacterConstants.EMERGENCY,
CharacterConstants.BARTENDER,
CharacterConstants.BOTANIST,
CharacterConstants.SCIENTIST,
CharacterConstants.DOCTOR,
}
CharacterConstants.JOB_NAMES_CAPS=
{
    [CharacterConstants.UNEMPLOYED] = "DUTIES001TEXT",
    [CharacterConstants.BUILDER] = "DUTIES003TEXT",
    [CharacterConstants.TECHNICIAN] = "DUTIES005TEXT",
    [CharacterConstants.MINER] = "DUTIES007TEXT",
    [CharacterConstants.EMERGENCY] = "DUTIES009TEXT",
    [CharacterConstants.RAIDER] = "DUTIES011TEXT",
    [CharacterConstants.BARTENDER] = "DUTIES013TEXT",
    [CharacterConstants.BOTANIST] = "DUTIES016TEXT",
    [CharacterConstants.SCIENTIST] = "DUTIES018TEXT",
    [CharacterConstants.DOCTOR] = "DUTIES020TEXT",
}
CharacterConstants.JOB_NAMES=
{
    [CharacterConstants.UNEMPLOYED] = "DUTIES001TEXT",
    [CharacterConstants.BUILDER] = "DUTIES003TEXT",
    [CharacterConstants.TECHNICIAN] = "DUTIES005TEXT",
    [CharacterConstants.MINER] = "DUTIES007TEXT",
    [CharacterConstants.EMERGENCY] = "DUTIES009TEXT",
    [CharacterConstants.RAIDER] = "DUTIES012TEXT",
    [CharacterConstants.BARTENDER] = "DUTIES013TEXT",
    [CharacterConstants.BOTANIST] = "DUTIES016TEXT",
    [CharacterConstants.SCIENTIST] = "DUTIES018TEXT",
    [CharacterConstants.DOCTOR] = "DUTIES020TEXT",
}
CharacterConstants.JOB_ICONS=
{
    [CharacterConstants.UNEMPLOYED] = "ui_jobs_iconJobUnemployed",
    [CharacterConstants.BUILDER] = "ui_jobs_iconJobBuilder",
    [CharacterConstants.TECHNICIAN] = "ui_jobs_iconJobTechnician",
    [CharacterConstants.MINER] = "ui_jobs_iconJobMiner",
    [CharacterConstants.EMERGENCY] = "ui_jobs_iconJobResponse",
    [CharacterConstants.RAIDER] = "ui_jobs_iconJobUnemployed",
    [CharacterConstants.BARTENDER] = "ui_jobs_iconJobBarkeep",
    [CharacterConstants.BOTANIST] = "ui_jobs_iconJobBotanist",
    [CharacterConstants.SCIENTIST] = "ui_jobs_iconJobScientist",
    [CharacterConstants.DOCTOR] = "ui_jobs_iconJobDoctor",
}
CharacterConstants.AFFINITY_ICONS =
{
	{ sIconName = 'ui_dialogicon_bigfrown', nAffMin = -10, tColor = Gui.RED },
	{ sIconName = 'ui_dialogicon_frown',    nAffMin = -7.5, tColor = Gui.ORANGE },
	{ sIconName = 'ui_dialogicon_meh',      nAffMin = CharacterConstants.DUTY_AFFINITY_DISLIKE, tColor = Gui.AMBER },
	{ sIconName = 'ui_dialogicon_smile',    nAffMin = CharacterConstants.DUTY_AFFINITY_LIKE, tColor = Gui.AMBERGREEN },
	{ sIconName = 'ui_dialogicon_bigsmile', nAffMin = 7.5, tColor = Gui.GREEN },
}
CharacterConstants.JOB_COMPETENCY_COLORS=
{
    [CharacterConstants.COMPETENCY_LEVEL1] = { 79/255, 28/255, 1/255 },
    [CharacterConstants.COMPETENCY_LEVEL2] = { 105/255, 69/255, 14/255 },
    [CharacterConstants.COMPETENCY_LEVEL3] = { 87/255, 81/255, 1/255 },
    [CharacterConstants.COMPETENCY_LEVEL4] = { 37/255, 78/255, 0/255 },
    [CharacterConstants.COMPETENCY_LEVEL5] = { 28/255, 91/255, 118/255 },
}
CharacterConstants.JOB_EQUIPMENT_PREFIX = '_Character_Group_Group_Flipbook_Group_Job_FBGroup_Jobs_AllTransB_Jobs_'
_D.CharacterConstantsSC18 = _h1(false, true, 'Characters/Citizen_Base/Textures/Scientist_base', 'Characters/Citizen_Base/Textures/Scientist_base')
CharacterConstants.JOB_EQUIPMENT =
{
    [CharacterConstants.BUILDER] = _h1(true, true, 'Characters/Citizen_Base/Textures/Builder01_Base_top', 'Characters/Citizen_Base/Textures/Builder01_Base_bottom'),
    [CharacterConstants.TECHNICIAN] = _h1(false, true, 'Characters/Citizen_Base/Textures/Technician01_Base_top', 'Characters/Citizen_Base/Textures/Technician01_Base_bottom'),
    [CharacterConstants.MINER] = _h1(true, true, 'Characters/Citizen_Base/Textures/Miner01_Base_top', 'Characters/Citizen_Base/Textures/Miner01_Base_bottom'),
    [CharacterConstants.EMERGENCY] = {
        bHasHelmet = true,
        bHasSuit = true,
    },
    [CharacterConstants.EMERGENCY2] = {
        bHasHelmet = true,
        bHasSuit = true,
    },
    [CharacterConstants.EMERGENCY3] = {
        bHasHelmet = true,
        bHasSuit = true,
    },
    [CharacterConstants.RAIDER] = _h1(false, true, 'Characters/Citizen_Base/Textures/Raider01_top', 'Characters/Citizen_Base/Textures/Raider01_bottom'),
    [CharacterConstants.BARTENDER] = {
        bHasHelmet = false,
        bHasSuit = true,
    },
    [CharacterConstants.BOTANIST] = _h1(false, false, 'Characters/Citizen_Base/Textures/gardener_base', 'Characters/Citizen_Base/Textures/gardener_base'),
    [CharacterConstants.SCIENTIST] = _D.CharacterConstantsSC18,
    [CharacterConstants.DOCTOR] = _D.CharacterConstantsSC18,
}
CharacterConstants.SPACESUIT_PREFIX = '_Character_Group_Group_Flipbook_Group_FBody_FBGroup_FBody_AllTransB_Full_Body_'
CharacterConstants.SPACESUITS =
{
    [CharacterConstants.UNEMPLOYED] = { sModel = 'Suit01_Body', sTexture = 'Characters/Spacesuit/Textures/SpaceDefault01'},
    [CharacterConstants.BUILDER] = { sModel = 'Suit01_Body', sTexture = 'Characters/Spacesuit/Textures/Spacesuit01'},
    [CharacterConstants.TECHNICIAN] = { sModel = 'Suit01_Body', sTexture = 'Characters/Spacesuit/Textures/SpaceDefault01'},
    [CharacterConstants.MINER] = { sModel = 'Suit01_Body', sTexture = 'Characters/Spacesuit/Textures/SpaceMiner01'},
    [CharacterConstants.EMERGENCY] = { sModel = 'Suit01_Body', sTexture = 'Characters/Spacesuit/Textures/SpaceEmergency01'},
    [CharacterConstants.RAIDER] = { sModel = 'Suit01_Body', sTexture = 'Characters/Spacesuit/Textures/SpaceRaider01'},
    [CharacterConstants.BARTENDER] = { sModel = 'Suit01_Body', sTexture = 'Characters/Spacesuit/Textures/SpaceDefault01'},
    [CharacterConstants.BOTANIST] = { sModel = 'Suit01_Body', sTexture = 'Characters/Spacesuit/Textures/SpaceDefault01'},
    [CharacterConstants.SCIENTIST] = { sModel = 'Suit01_Body', sTexture = 'Characters/Spacesuit/Textures/SpaceDefault01'},
    [CharacterConstants.DOCTOR] = { sModel = 'Suit01_Body', sTexture = 'Characters/Spacesuit/Textures/SpaceDefault01'},
}
CharacterConstants.SPACESUIT_JOB_EQUIPMENT_PREFIX = '_Character_Group_Group_Flipbook_Group_Job_FBGroup_Jobs_AllTransB_Jobs_'
CharacterConstants.SPACESUIT_JOB_EQUIPMENT =
{
    [CharacterConstants.UNEMPLOYED] = { sModel = 'Builder_Spacesuit01', sTexture = 'Characters/Spacesuit/Textures/Spacesuit01'},
    [CharacterConstants.BUILDER] = { sModel = 'Builder_Spacesuit01', sTexture = 'Characters/Spacesuit/Textures/Spacesuit01'},
    [CharacterConstants.TECHNICIAN] = { sModel = 'Builder_Spacesuit01', sTexture = 'Characters/Spacesuit/Textures/Spacesuit01'},
    [CharacterConstants.MINER] = { sModel = 'Miner_Spacesuit01', sTexture = 'Characters/Spacesuit/Textures/MinerAcc01'},
    [CharacterConstants.EMERGENCY] = { sModel = 'Emergency_Spacesuit01', sTexture = 'Characters/Spacesuit/Textures/SpaceEmergency01'},
    [CharacterConstants.RAIDER] = { sModel = 'Builder_Spacesuit01', sTexture = 'Characters/Spacesuit/Textures/Spacesuit01'},
    [CharacterConstants.BARTENDER] = { sModel = 'Builder_Spacesuit01', sTexture = 'Characters/Spacesuit/Textures/Spacesuit01'},
    [CharacterConstants.BOTANIST] = { sModel = 'Builder_Spacesuit01', sTexture = 'Characters/Spacesuit/Textures/Spacesuit01'},
    [CharacterConstants.SCIENTIST] = { sModel = 'Builder_Spacesuit01', sTexture = 'Characters/Spacesuit/Textures/Spacesuit01'},
    [CharacterConstants.DOCTOR] = { sModel = 'Builder_Spacesuit01', sTexture = 'Characters/Spacesuit/Textures/Spacesuit01'},
}
CharacterConstants.JOB_HAND_ACCESSORY_PREFIX = '_Character_Group_Group_Flipbook_Group_AC_Hand_FBGroup_Hands_Rt_Prop_ACHands_'
CharacterConstants.JOB_HAND_ACCESSORIES=
{
    [CharacterConstants.WELDER] = { sModel = 'Builder_Hand01', sTexture = 'Characters/Citizen_Base/Textures/Builder01'},
    [CharacterConstants.DATAPAD] = { sModel = 'Tech_Hand01', sTexture = 'Characters/Citizen_Base/Textures/Technician01'},
    [CharacterConstants.RIFLE] = { sModel = 'Rifle_01', sTexture = 'Characters/Citizen_Base/Textures/Rifle01'},
    [CharacterConstants.BEER] = { sModel = 'Mug_01', sTexture = 'Characters/Citizen_Base/Textures/Mug01'},
}
CharacterConstants.SPACESUIT_JOB_HAND_ACCESSORIES=
{
    [CharacterConstants.WELDER] = { sModel = 'Builder_Hand01', sTexture = 'Characters/Citizen_Base/Textures/Builder01'},
    [CharacterConstants.ROCK] = { sModel = 'AsteroidChunk01', sTexture = 'Characters/Spacesuit/Textures/AsteroidChunk01'},
}
S{RIG_BASE=1,RIG_ALIEN=2,RIG_CUBE=3,RIG_SPHERE=6,RIG_MONSTER=4,RIG_KILLBOT=5,HUMAN_RACE_PCT=60,CAT_RACE_PCT=2,RACE_HUMAN=1,RACE_JELLY=2,RACE_TOBIAN=3,RACE_CAT=4,RACE_BIRDSHARK=5,RACE_CHICKEN=6,RACE_MONSTER=7,RACE_SHAMON=8,RACE_MURDERFACE=9,RACE_KILLBOT=10}
CharacterConstants.tRaceNames=
{
    [CharacterConstants.RACE_HUMAN] = 'NAMESX253TEXT',
    [CharacterConstants.RACE_JELLY] = 'NAMESX254TEXT',
    [CharacterConstants.RACE_TOBIAN] = 'NAMESX255TEXT',
    [CharacterConstants.RACE_CAT] = 'NAMESX259TEXT',
    [CharacterConstants.RACE_BIRDSHARK] = 'NAMESX256TEXT',
    [CharacterConstants.RACE_CHICKEN] = 'NAMESX258TEXT',
    [CharacterConstants.RACE_MONSTER] = 'NAMESX260TEXT',
    [CharacterConstants.RACE_SHAMON] = 'NAMESX257TEXT',
    [CharacterConstants.RACE_MURDERFACE] = 'NAMESX261TEXT',
    [CharacterConstants.RACE_MURDERFACE] = 'NAMESX340TEXT',
}
S{BODY_HUMAN_BROWN_MALE=1,BODY_HUMAN_YELLOWISH_MALE=2,BODY_HUMAN_REDDISH_MALE=3,BODY_HUMAN_WHITE_MALE=4,BODY_HUMAN_BLACK_MALE=5,BODY_HUMAN_BROWN_FEMALE=6,BODY_HUMAN_YELLOWISH_FEMALE=7,BODY_HUMAN_REDDISH_FEMALE=8,BODY_HUMAN_WHITE_FEMALE=9,BODY_HUMAN_BLACK_FEMALE=10,BODY_JELLY_MAUVE_FEMALE=11,BODY_JELLY_PURPLE_FEMALE=12,BODY_JELLY_PINK_FEMALE=13,BODY_JELLY_BLUE_FEMALE=14,BODY_TOBIAN_BLUE_ALIEN_01=15,BODY_TOBIAN_BLUE_ALIEN_02=16,BODY_TOBIAN_BLUE_ALIEN_03=17,BODY_TOBIAN_BLUE_ALIEN_04=18,BODY_TOBIAN_BLUE_ALIEN_05=19,BODY_CAT_MALE_01=20,BODY_CAT_MALE_02=21,BODY_CAT_FEMALE_01=22,BODY_CAT_FEMALE_02=23,BODY_BIRDSHARK_MALE_01=24,BODY_BIRDSHARK_MALE_02=25,BODY_BIRDSHARK_FEMALE_01=26,BODY_BIRDSHARK_FEMALE_02=27,BODY_CHICKEN_MALE_01=28,BODY_CHICKEN_MALE_02=29,BODY_CHICKEN_FEMALE_01=30,BODY_CHICKEN_FEMALE_02=31,BODY_HUMAN_FAT_BROWN_MALE=32,BODY_HUMAN_FAT_YELLOWISH_MALE=33,BODY_HUMAN_FAT_REDDISH_MALE=34,BODY_HUMAN_FAT_WHITE_MALE=35,BODY_HUMAN_FAT_BLACK_MALE=36,BODY_HUMAN_FAT_BROWN_FEMALE=37,BODY_HUMAN_FAT_YELLOWISH_FEMALE=38,BODY_HUMAN_FAT_REDDISH_FEMALE=39,BODY_HUMAN_FAT_WHITE_FEMALE=40,BODY_HUMAN_FAT_BLACK_FEMALE=41,BODY_JELLY_FAT_MAUVE_FEMALE=42,BODY_JELLY_FAT_PURPLE_FEMALE=43,BODY_JELLY_FAT_PINK_FEMALE=44,BODY_JELLY_FAT_BLUE_FEMALE=45,BODY_CAT_FAT_MALE_01=46,BODY_CAT_FAT_MALE_02=47,BODY_CAT_FAT_FEMALE_01=48,BODY_CAT_FAT_FEMALE_02=49,BODY_BIRDSHARK_FAT_MALE_01=50,BODY_BIRDSHARK_FAT_MALE_02=51,BODY_BIRDSHARK_FAT_FEMALE_01=52,BODY_BIRDSHARK_FAT_FEMALE_02=53,BODY_MONSTER=54,BODY_SHAMON_MALE_01=55,BODY_MURDERFACE_MALE_01=56,BODY_KILLBOT_01=57,HEAD_HUMAN_BROWN_MALE=1,HEAD_HUMAN_YELLOWISH_MALE=2,HEAD_HUMAN_REDDISH_MALE=3,HEAD_HUMAN_WHITE_MALE=4,HEAD_HUMAN_BLACK_MALE=5,HEAD_HUMAN_BROWN_FEMALE=6,HEAD_HUMAN_YELLOWISH_FEMALE=7,HEAD_HUMAN_REDDISH_FEMALE=8,HEAD_HUMAN_WHITE_FEMALE=9,HEAD_HUMAN_BLACK_FEMALE=10,HEAD_JELLY_MAUVE_FEMALE=11,HEAD_JELLY_PURPLE_FEMALE=12,HEAD_JELLY_PINK_FEMALE=13,HEAD_JELLY_BLUE_FEMALE=14,HEAD_TOBIAN_BLUE_ALIEN_01=15,HEAD_TOBIAN_BLUE_ALIEN_02=16,HEAD_TOBIAN_BLUE_ALIEN_03=17,HEAD_TOBIAN_BLUE_ALIEN_04=18,HEAD_TOBIAN_BLUE_ALIEN_05=19,HEAD_CAT_MALE_01=20,HEAD_CAT_MALE_02=21,HEAD_CAT_FEMALE_01=22,HEAD_CAT_FEMALE_02=23,HEAD_BIRDSHARK_MALE_01=24,HEAD_BIRDSHARK_MALE_02=25,HEAD_BIRDSHARK_FEMALE_01=26,HEAD_BIRDSHARK_FEMALE_02=27,HEAD_CHICKEN_MALE_01=28,HEAD_CHICKEN_MALE_02=29,HEAD_CHICKEN_FEMALE_01=30,HEAD_CHICKEN_FEMALE_02=31,HEAD_HUMAN_FAT_BROWN_MALE=32,HEAD_HUMAN_FAT_YELLOWISH_MALE=33,HEAD_HUMAN_FAT_REDDISH_MALE=34,HEAD_HUMAN_FAT_WHITE_MALE=35,HEAD_HUMAN_FAT_BLACK_MALE=36,HEAD_HUMAN_FAT_BROWN_FEMALE=37,HEAD_HUMAN_FAT_YELLOWISH_FEMALE=38,HEAD_HUMAN_FAT_REDDISH_FEMALE=39,HEAD_HUMAN_FAT_WHITE_FEMALE=40,HEAD_HUMAN_FAT_BLACK_FEMALE=41,HEAD_SHAMON_MALE_01=42,HEAD_MURDERFACE_MALE_01=43,HEAD_NONE=44,BALD=0,MALE_HAIR_01_BLONDE=1,MALE_HAIR_02_BLONDE=2,MALE_HAIR_03_BLONDE=3,FEMALE_HAIR_01_BLONDE=4,FEMALE_HAIR_02_BLONDE=5,FEMALE_HAIR_03_BLONDE=6,FEMALE_HAIR_04_BLONDE=7,FEMALE_HAIR_05_BLONDE=8,TOBIAN_DONG_01=9,TOBIAN_DONG_02=11,TOBIAN_DONG_03=12,TOBIAN_DONG_04=13,TOBIAN_DONG_05=14,TOBIAN_MUSTACHE_01=10,TOBIAN_MUSTACHE_02=15,TOBIAN_MUSTACHE_03=16,TOBIAN_MUSTACHE_04=17,TOBIAN_MUSTACHE_05=18,TOBIAN_ELEPHANT_01=19,TOBIAN_ELEPHANT_02=20,TOBIAN_ELEPHANT_03=21,TOBIAN_ELEPHANT_04=22,TOBIAN_ELEPHANT_05=23,CAT_MUSTACHE_01=24,FEMALE_HAIR_02_RED=25,FEMALE_HAIR_02_BRUNETTE=26,FEMALE_HAIR_02_BLACK=27,FEMALE_HAIR_01_RED=28,FEMALE_HAIR_01_BRUNETTE=29,FEMALE_HAIR_01_BLACK=30,FEMALE_HAIR_03_RED=31,FEMALE_HAIR_03_BRUNETTE=32,FEMALE_HAIR_03_BLACK=33,FEMALE_HAIR_04_RED=34,FEMALE_HAIR_04_BRUNETTE=35,FEMALE_HAIR_04_BLACK=36,FEMALE_HAIR_05_RED=37,FEMALE_HAIR_05_BRUNETTE=38,FEMALE_HAIR_05_BLACK=39,MALE_HAIR_01_RED=40,MALE_HAIR_01_BRUNETTE=41,MALE_HAIR_01_BLACK=42,MALE_HAIR_02_RED=43,MALE_HAIR_02_BRUNETTE=44,MALE_HAIR_02_BLACK=45,MALE_HAIR_03_RED=46,MALE_HAIR_03_BRUNETTE=47,MALE_HAIR_03_BLACK=48,FEMALE_HAIR_01_PURPLE=49,FEMALE_HAIR_01_GREEN=50,FEMALE_HAIR_05_PURPLE=51,FEMALE_HAIR_05_GREEN=52,MALE_HAIR_01_REDBANGS=53,MALE_HAIR_01_BLUEBANGS=54,MALE_HAIR_02_REDBANGS=55,MALE_HAIR_02_BLUEBANGS=56,MALE_HAIR_03_REDBANGS=57,MALE_HAIR_03_BLUEBANGS=58,FEMALE_HAIR_03_REDBANGS=59,FEMALE_HAIR_03_BLUEBANGS=60,FEMALE_HAIR_04_REDBANGS=61,FEMALE_HAIR_04_BLUEBANGS=62,CAT_MUSTACHE_02=63,MALE_HAIR_04_BLONDE=64,MALE_HAIR_04_RED=65,MALE_HAIR_04_BRUNETTE=66,MALE_HAIR_04_BLACK=67,MALE_HAIR_04_REDBANGS=68,MALE_HAIR_04_BLUEBANGS=69,MALE_HAIR_05_BLONDE=70,MALE_HAIR_05_RED=71,MALE_HAIR_05_BRUNETTE=72,MALE_HAIR_05_BLACK=73,MALE_HAIR_05_REDBANGS=74,MALE_HAIR_05_BLUEBANGS=75,MALE_HAIR_01_GRAY=76,MALE_HAIR_02_GRAY=77,MALE_HAIR_03_GRAY=78,MALE_HAIR_04_GRAY=79,MALE_HAIR_05_GRAY=80,FEMALE_HAIR_01_GRAY=81,FEMALE_HAIR_02_GRAY=82,FEMALE_HAIR_03_GRAY=83,FEMALE_HAIR_04_GRAY=84,FEMALE_HAIR_05_GRAY=85,FACE_BOTTOM_CLEAR=0,FACE_BOTTOM_CHICKEN_BEAK_01=1,FACE_BOTTOM_CHICKEN_BEAK_02=2,FACE_BOTTOM_CHICKEN_BEAK_03=3,FACE_BOTTOM_CHICKEN_BEAK_04=4,FACE_BOTTOM_HUMAN_BEARD_01_BLONDE=5,FACE_BOTTOM_HUMAN_BEARD_01_RED=6,FACE_BOTTOM_HUMAN_BEARD_01_BRUNETTE=7,FACE_BOTTOM_HUMAN_BEARD_01_BLACK=8,FACE_BOTTOM_HUMAN_BEARD_02_BLONDE=9,FACE_BOTTOM_HUMAN_BEARD_02_RED=10,FACE_BOTTOM_HUMAN_BEARD_02_BRUNETTE=11,FACE_BOTTOM_HUMAN_BEARD_02_BLACK=12,FACE_BOTTOM_HUMAN_BEARD_03_BLONDE=13,FACE_BOTTOM_HUMAN_BEARD_03_RED=14,FACE_BOTTOM_HUMAN_BEARD_03_BRUNETTE=15,FACE_BOTTOM_HUMAN_BEARD_03_BLACK=16,FACE_BOTTOM_HUMAN_BEARD_04_BLONDE=17,FACE_BOTTOM_HUMAN_BEARD_04_RED=18,FACE_BOTTOM_HUMAN_BEARD_04_BRUNETTE=19,FACE_BOTTOM_HUMAN_BEARD_04_BLACK=20,FACE_BOTTOM_HUMAN_BEARD_05_BLONDE=21,FACE_BOTTOM_HUMAN_BEARD_05_RED=22,FACE_BOTTOM_HUMAN_BEARD_05_BRUNETTE=23,FACE_BOTTOM_HUMAN_BEARD_05_BLACK=24,FACE_BOTTOM_HUMAN_BEARD_01_GRAY=25,FACE_BOTTOM_HUMAN_BEARD_02_GRAY=26,FACE_BOTTOM_HUMAN_BEARD_03_GRAY=27,FACE_BOTTOM_HUMAN_BEARD_04_GRAY=28,FACE_BOTTOM_HUMAN_BEARD_05_GRAY=29,FACE_TOP_CLEAR=0,FACE_TOP_CHICKEN_COMB_01=1,FACE_TOP_CHICKEN_COMB_02=2,FACE_TOP_CHICKEN_COMB_03=3,FACE_TOP_CHICKEN_COMB_04=4,NO_BOTTOM_ACCESSORY=0,MALE_BOTTOM_ACCESSORY_LEGPOUCH_01=1,MALE_BOTTOM_ACCESSORY_BELT_01=2,FEMALE_BOTTOM_ACCESSORY_LEGPOUCH_01=3,FEMALE_BOTTOM_ACCESSORY_BELT_01=4,TOBIAN_BOTTOM_ACCESSORY_LEGPOUCH_01=5,TOBIAN_BOTTOM_ACCESSORY_BELT_01=6,MALE_BOTTOM_ACCESSORY_TOURISTSHORTS_01=7,FEMALE_BOTTOM_ACCESSORY_TOURISTSHORTS_01=8,MALE_BOTTOM_ACCESSORY_FAT_TOURISTSHORTS_01=9,MALE_BOTTOM_ACCESSORY_FAT_LEGPOUCH_01=10,FEMALE_BOTTOM_ACCESSORY_FAT_LEGPOUCH_01=11,MALE_BOTTOM_ACCESSORY_FAT_BELT_01=12,FEMALE_BOTTOM_ACCESSORY_FAT_BELT_01=13,TOBIAN_BOTTOM_ACCESSORY_TOURISTSHORTS_01=14,SHAMON_BOTTOM_ACCESSORY_BELT_01=15,SHAMON_BOTTOM_ACCESSORY_LEGPOUCH_01=16,NO_TOP_ACCESSORY=0,MALE_TOP_ACCESSORY_COLLAR_01=1,MALE_TOP_ACCESSORY_VEST_01=2,FEMALE_TOP_ACCESSORY_COLLAR_01=3,FEMALE_TOP_ACCESSORY_VEST_01=4,TOBIAN_TOP_ACCESSORY_COLLAR_01=5,TOBIAN_TOP_ACCESSORY_VEST_01=6,MALE_TOP_ACCESSORY_SEXYSHIRT_01=7,FEMALE_TOP_ACCESSORY_BANDOLIER_01=8,FEMALE_TOP_ACCESSORY_FAT_BANDOLIER_01=9,MALE_TOP_ACCESSORY_BANDOLIER_01=10,MALE_TOP_ACCESSORY_FAT_BANDOLIER_01=11,FEMALE_TOP_ACCESSORY_BANDOLIER_02=12,FEMALE_TOP_ACCESSORY_FAT_BANDOLIER_02=13,MALE_TOP_ACCESSORY_BANDOLIER_02=14,MALE_TOP_ACCESSORY_FAT_BANDOLIER_02=15,MALE_TOP_ACCESSORY_FAT_COLLAR_01=19,TOP_ACCESSORY_GAUNTLET_LEFT_01=20,TOP_ACCESSORY_GAUNTLET_RIGHT_01=21,TOBIAN_TOP_ACCESSORY_ROBESHIRT_01=22,MALE_TOP_ACCESSORY_TOURIST_SHIRT_02=24,MALE_TOP_ACCESSORY_TOURIST_SHIRT_03=25,MALE_TOP_ACCESSORY_FAT_TOURIST_SHIRT_02=26,MALE_TOP_ACCESSORY_FAT_TOURIST_SHIRT_03=27,MALE_TOP_ACCESSORY_VEST_01_BEIGE=28,FEMALE_TOP_ACCESSORY_VEST_01_BEIGE=29,TOBIAN_TOP_ACCESSORY_VEST_01_BEIGE=30,SHAMON_TOP_ACCESSORY_SEXYSHIRT_01=31,SHAMON_TOP_ACCESSORY_TOURIST_SHIRT_02=33,SHAMON_TOP_ACCESSORY_TOURIST_SHIRT_03=34,SHAMON_TOP_ACCESSORY_VEST_01=35,SHAMON_TOP_ACCESSORY_VEST_01_BEIGE=36,TOP_ACCESSORY_HUMANVISOR_01=37,TOP_ACCESSORY_BIRDSHARKVISOR_01=38,TOP_ACCESSORY_CATVISOR_01=39,TOP_ACCESSORY_SHAMONVISOR_01=40,MALE_TOP_ACCESSORY_TOURIST_SHIRT_02=41,MALE_TOP_ACCESSORY_TOURIST_SHIRT_03=42,MALE_TOP_ACCESSORY_TOURIST_SHIRT_04=43,MALE_TOP_ACCESSORY_TOURIST_SHIRT_05=44,FEMALE_TOP_ACCESSORY_TOURIST_SHIRT_02=45,FEMALE_TOP_ACCESSORY_TOURIST_SHIRT_03=46,FEMALE_TOP_ACCESSORY_TOURIST_SHIRT_04=47,FEMALE_TOP_ACCESSORY_TOURIST_SHIRT_05=48,FEMALE_TOP_ACCESSORY_FAT_TOURIST_SHIRT_02=49,FEMALE_TOP_ACCESSORY_FAT_TOURIST_SHIRT_03=50,FEMALE_TOP_ACCESSORY_FAT_TOURIST_SHIRT_04=51,FEMALE_TOP_ACCESSORY_FAT_TOURIST_SHIRT_05=52,SHAMON_TOP_ACCESSORY_TOURIST_SHIRT_04=53,SHAMON_TOP_ACCESSORY_TOURIST_SHIRT_05=54,MALE_TOP_ACCESSORY_FAT_TOURIST_SHIRT_04=55,MALE_TOP_ACCESSORY_FAT_TOURIST_SHIRT_05=56,TOBIAN_TOP_ACCESSORY_TOURIST_SHIRT_03=57,TOBIAN_TOP_ACCESSORY_TOURIST_SHIRT_04=58,TOBIAN_TOP_ACCESSORY_TOURIST_SHIRT_05=59,HUMAN_MALE=1,HUMAN_FEMALE=2,JELLY_FEMALE=3,TOBIAN=4,MURDERFACE_MALE=5,CAT_MALE=6,CAT_FEMALE=7,BIRDSHARK_MALE=8,BIRDSHARK_FEMALE=9,CHICKEN_MALE=10,CHICKEN_FEMALE=11,SHAMON_MALE=12,SHAMON_FEMALE=13,HUMAN_FAT_MALE=14,HUMAN_FAT_FEMALE=15,JELLY_FAT_FEMALE=16,CAT_FAT_MALE=17,CAT_FAT_FEMALE=18,BIRDSHARK_FAT_MALE=19,BIRDSHARK_FAT_FEMALE=20,TOBIAN_BLUE_ALIEN_01=21,TOBIAN_BLUE_ALIEN_02=22,TOBIAN_BLUE_ALIEN_03=23,TOBIAN_BLUE_ALIEN_04=24,TOBIAN_BLUE_ALIEN_05=25,CAT_MALE_01=26,CAT_MALE_02=27,KILLBOT_01=28,BUILDER_BASE_NORMAL=1,BUILDER_BASE_NORMAL_NO_HELMET=2,BUILDER_BASE_FAT=3,BUILDER_BASE_FAT_NO_HELMET=4,BUILDER_TOBIAN_NO_HELMET=5,TECHNICIAN_BASE_NORMAL=6,TECHNICIAN_TOBIAN=7,MINER_BASE_NORMAL=8,MINER_BASE_FAT=9,MINER_TOBIAN=10,EMERGENCY_BASE_NORMAL=11,EMERGENCY_BASE_FAT=12,EMERGENCY_TOBIAN=13,RAIDER_BASE_NORMAL=14,BUILDER_BASE_NORMAL_HOOF_BOOT=15,MINER_BASE_NORMAL_HOOF_BOOT=16,EMERGENCY_BASE_NORMAL_HOOF_BOOT=17,RAIDER_BASE_NORMAL_NO_HELMET=18,RAIDER_BASE_FAT=19,RAIDER_BASE_FAT_NO_HELMET=20,RAIDER_TOBIAN_NO_HELMET=21,BARTENDER_BASE_NORMAL=22,BARTENDER_BASE_FAT=23,BARTENDER_BASE_NORMAL_FEMALE=24,BARTENDER_BASE_FAT_FEMALE=25,BARTENDER_TOBIAN=26,BARTENDER_SHAMON=27,TECHNICIAN_BASE_FAT=28,BOTANIST_BASE_NORMAL=29,SCIENTIST_BASE_NORMAL=29,SCIENTIST_BASE_FAT=30,DOCTOR_BASE_NORMAL=31,DOCTOR_BASE_FAT=32,NO_HELMET=0,BUILDER_BASE_HELMET=1,MINER_BASE_HELMET=2,MINER_TOBIAN_HELMET=3,EMERGENCY_BASE_HELMET=4,EMERGENCY_TOBIAN_HELMET=5,RAIDER_BASE_HELMET=6,NO_REPLACE=1000000+1}
CharacterConstants.RACE_TYPE=
{
    [CharacterConstants.RACE_HUMAN] = {
        sName = "human",
        nRig = CharacterConstants.RIG_BASE,
        tBodies = {
            CharacterConstants.BODY_HUMAN_BROWN_MALE,
            CharacterConstants.BODY_HUMAN_YELLOWISH_MALE,
            CharacterConstants.BODY_HUMAN_REDDISH_MALE,
            CharacterConstants.BODY_HUMAN_WHITE_MALE,
            CharacterConstants.BODY_HUMAN_BLACK_MALE,
            CharacterConstants.BODY_HUMAN_BROWN_FEMALE,
            CharacterConstants.BODY_HUMAN_YELLOWISH_FEMALE,
            CharacterConstants.BODY_HUMAN_REDDISH_FEMALE,
            CharacterConstants.BODY_HUMAN_WHITE_FEMALE,
            CharacterConstants.BODY_HUMAN_BLACK_FEMALE,
            CharacterConstants.BODY_HUMAN_FAT_BROWN_MALE,
            CharacterConstants.BODY_HUMAN_FAT_YELLOWISH_MALE,
            CharacterConstants.BODY_HUMAN_FAT_REDDISH_MALE,
            CharacterConstants.BODY_HUMAN_FAT_WHITE_MALE,
            CharacterConstants.BODY_HUMAN_FAT_BLACK_MALE,
            CharacterConstants.BODY_HUMAN_FAT_BROWN_FEMALE,
            CharacterConstants.BODY_HUMAN_FAT_YELLOWISH_FEMALE,
            CharacterConstants.BODY_HUMAN_FAT_REDDISH_FEMALE,
            CharacterConstants.BODY_HUMAN_FAT_WHITE_FEMALE,
            CharacterConstants.BODY_HUMAN_FAT_BLACK_FEMALE,
            },
    },
    [CharacterConstants.RACE_JELLY] = {
        sName = "jelly",
        nRig = CharacterConstants.RIG_BASE,
        tBodies = {
            CharacterConstants.BODY_JELLY_MAUVE_FEMALE,
            CharacterConstants.BODY_JELLY_PURPLE_FEMALE,
            CharacterConstants.BODY_JELLY_PINK_FEMALE,
            CharacterConstants.BODY_JELLY_BLUE_FEMALE,
            CharacterConstants.BODY_JELLY_FAT_MAUVE_FEMALE,
            CharacterConstants.BODY_JELLY_FAT_PURPLE_FEMALE,
            CharacterConstants.BODY_JELLY_FAT_PINK_FEMALE,
            CharacterConstants.BODY_JELLY_FAT_BLUE_FEMALE,
            },
    },
    [CharacterConstants.RACE_TOBIAN] = {
        sName = "tobian",
        nRig = CharacterConstants.RIG_ALIEN,
        tBodies = {
            CharacterConstants.BODY_TOBIAN_BLUE_ALIEN_01,
            CharacterConstants.BODY_TOBIAN_BLUE_ALIEN_02,
            CharacterConstants.BODY_TOBIAN_BLUE_ALIEN_03,
            CharacterConstants.BODY_TOBIAN_BLUE_ALIEN_04,
            CharacterConstants.BODY_TOBIAN_BLUE_ALIEN_05,
        },
    },
    [CharacterConstants.RACE_CAT] = {
        sName = "cat",
        nRig = CharacterConstants.RIG_BASE,
        tBodies = {
            CharacterConstants.BODY_CAT_MALE_01,
            CharacterConstants.BODY_CAT_MALE_02,
            CharacterConstants.BODY_CAT_FEMALE_01,
            CharacterConstants.BODY_CAT_FEMALE_02,
            CharacterConstants.BODY_CAT_FAT_MALE_01,
            CharacterConstants.BODY_CAT_FAT_MALE_02,
            CharacterConstants.BODY_CAT_FAT_FEMALE_01,
            CharacterConstants.BODY_CAT_FAT_FEMALE_02,
        },
    },
    [CharacterConstants.RACE_BIRDSHARK] = {
        sName = "birdshark",
        nRig = CharacterConstants.RIG_BASE,
        tBodies = {
            CharacterConstants.BODY_BIRDSHARK_MALE_01,
            CharacterConstants.BODY_BIRDSHARK_MALE_02,
            CharacterConstants.BODY_BIRDSHARK_FEMALE_01,
            CharacterConstants.BODY_BIRDSHARK_FEMALE_02,
            CharacterConstants.BODY_BIRDSHARK_FAT_MALE_01,
            CharacterConstants.BODY_BIRDSHARK_FAT_MALE_02,
            CharacterConstants.BODY_BIRDSHARK_FAT_FEMALE_01,
            CharacterConstants.BODY_BIRDSHARK_FAT_FEMALE_02,
        },
    },
    [CharacterConstants.RACE_CHICKEN] = {
        sName = "chicken",
        nRig = CharacterConstants.RIG_ALIEN,
        tBodies = {
            CharacterConstants.BODY_CHICKEN_MALE_01,
            CharacterConstants.BODY_CHICKEN_MALE_02,
            CharacterConstants.BODY_CHICKEN_FEMALE_01,
            CharacterConstants.BODY_CHICKEN_FEMALE_02,
        },
    },
    [CharacterConstants.RACE_MONSTER] = {
        sName = "badalien",
        nRig = CharacterConstants.RIG_MONSTER,
        tBodies = {
            CharacterConstants.BODY_MONSTER,
        },
    },
    [CharacterConstants.RACE_SHAMON] = {
        sName = "shamon",
        nRig = CharacterConstants.RIG_BASE,
        tBodies = {
            CharacterConstants.BODY_SHAMON_MALE_01,
        },
    },
    [CharacterConstants.RACE_MURDERFACE] = {
        sName = "murderface",
        nRig = CharacterConstants.RIG_ALIEN,
        tBodies = {
            CharacterConstants.BODY_MURDERFACE_MALE_01,
        },
    },
    [CharacterConstants.RACE_KILLBOT] = {
        sName = "killbot",
        nRig = CharacterConstants.RIG_KILLBOT,
        tBodies = {
            CharacterConstants.BODY_KILLBOT_01,
        },
    },
}
CharacterConstants.RIG_TYPE=
{
    [CharacterConstants.RIG_BASE] = {sRigPath='Characters/Citizen_Base/Rig/Citizen_Base.rig',sAnimPath='Animations.Citizen_Base',nScl=.5},
    [CharacterConstants.RIG_ALIEN] = {sRigPath='Characters/Citizen_Alien/Rig/Citizen_Alien.rig',sAnimPath='Animations.Citizen_Alien',nScl=.5},
    [CharacterConstants.RIG_CUBE] = {sRigPath='Characters/Primitives/Rig/Cube.rig',sAnimPath='Animations.None',nScl=.5},
    [CharacterConstants.RIG_SPHERE] = {sRigPath='Characters/Primitives/Rig/Sphere.rig',sAnimPath='Animations.None',nScl=.5},
    [CharacterConstants.RIG_MONSTER] = {sRigPath='Characters/Bad_Alien/Rig/Bad_Alien.rig',sAnimPath='Animations.Bad_Alien',nScl=.65},
    [CharacterConstants.RIG_KILLBOT] = {sRigPath='Characters/Murder_Robot/Rig/Murder_Robot.rig',sAnimPath='Animations.Murder_Robot',nScl=.5},
}
CharacterConstants.RIG_SPACESUIT = "Characters/Spacesuit/Rig/Spacesuit.rig"
CharacterConstants.BODY_PREFIX = '_Character_Group_Group_Flipbook_Group_FBody_FBGroup_FBody_AllTransB_Full_Body_'
_D.tJobOutfits4 = {
    [CharacterConstants.BUILDER] = CharacterConstants.BUILDER_TOBIAN_NO_HELMET,
    [CharacterConstants.TECHNICIAN] = CharacterConstants.TECHNICIAN_TOBIAN,
    [CharacterConstants.MINER] = CharacterConstants.MINER_TOBIAN,
    [CharacterConstants.EMERGENCY] = CharacterConstants.EMERGENCY_TOBIAN,
    [CharacterConstants.RAIDER] = CharacterConstants.RAIDER_TOBIAN_NO_HELMET,
}
_D.tJobOutfits6 = {
    [CharacterConstants.BUILDER] = CharacterConstants.BUILDER_BASE_NORMAL,
    [CharacterConstants.MINER] = CharacterConstants.MINER_BASE_NORMAL,
    [CharacterConstants.EMERGENCY] = CharacterConstants.EMERGENCY_BASE_NORMAL,
    [CharacterConstants.RAIDER] = CharacterConstants.RAIDER_BASE_NORMAL,
}
_D.tJobOutfits7 = {
    [CharacterConstants.BUILDER] = CharacterConstants.BUILDER_BASE_FAT,
    [CharacterConstants.MINER] = CharacterConstants.MINER_BASE_FAT,
    [CharacterConstants.EMERGENCY] = CharacterConstants.EMERGENCY_BASE_FAT,
    [CharacterConstants.RAIDER] = CharacterConstants.RAIDER_BASE_FAT,
}
CharacterConstants.BODY_TYPE=
{
    [CharacterConstants.BODY_HUMAN_BROWN_MALE] = _h2(CharacterConstants.RIG_BASE, "M", 'Male01_Body', "Characters/Citizen_Base/Textures/Human_Body_Male01_base_01", { CharacterConstants.HEAD_HUMAN_BROWN_MALE }, CharacterConstants.HUMAN_MALE),
    [CharacterConstants.BODY_HUMAN_YELLOWISH_MALE] = _h2(CharacterConstants.RIG_BASE, "M", 'Male01_Body', "Characters/Citizen_Base/Textures/Human_Body_Male01_base_02", { CharacterConstants.HEAD_HUMAN_YELLOWISH_MALE }, CharacterConstants.HUMAN_MALE),
    [CharacterConstants.BODY_HUMAN_REDDISH_MALE] = _h2(CharacterConstants.RIG_BASE, "M", 'Male01_Body', "Characters/Citizen_Base/Textures/Human_Body_Male01_base_03", { CharacterConstants.HEAD_HUMAN_REDDISH_MALE }, CharacterConstants.HUMAN_MALE),
    [CharacterConstants.BODY_HUMAN_WHITE_MALE] = _h2(CharacterConstants.RIG_BASE, "M", 'Male01_Body', "Characters/Citizen_Base/Textures/Human_Body_Male01_base_04", { CharacterConstants.HEAD_HUMAN_WHITE_MALE }, CharacterConstants.HUMAN_MALE),
    [CharacterConstants.BODY_HUMAN_BLACK_MALE] = _h2(CharacterConstants.RIG_BASE, "M", 'Male01_Body', "Characters/Citizen_Base/Textures/Human_Body_Male01_base_05", { CharacterConstants.HEAD_HUMAN_BLACK_MALE }, CharacterConstants.HUMAN_MALE),
    [CharacterConstants.BODY_HUMAN_BROWN_FEMALE] = _h2(CharacterConstants.RIG_BASE, "F", 'Female01_Body', "Characters/Citizen_Base/Textures/Human_Body_Female01_base_01", { CharacterConstants.HEAD_HUMAN_BROWN_FEMALE }, CharacterConstants.HUMAN_FEMALE),
    [CharacterConstants.BODY_HUMAN_YELLOWISH_FEMALE] = _h2(CharacterConstants.RIG_BASE, "F", 'Female01_Body', "Characters/Citizen_Base/Textures/Human_Body_Female01_base_02", { CharacterConstants.HEAD_HUMAN_YELLOWISH_FEMALE }, CharacterConstants.HUMAN_FEMALE),
    [CharacterConstants.BODY_HUMAN_REDDISH_FEMALE] = _h2(CharacterConstants.RIG_BASE, "F", 'Female01_Body', "Characters/Citizen_Base/Textures/Human_Body_Female01_base_03", { CharacterConstants.HEAD_HUMAN_REDDISH_FEMALE }, CharacterConstants.HUMAN_FEMALE),
    [CharacterConstants.BODY_HUMAN_WHITE_FEMALE] = _h2(CharacterConstants.RIG_BASE, "F", 'Female01_Body', "Characters/Citizen_Base/Textures/Human_Body_Female01_base_04", { CharacterConstants.HEAD_HUMAN_WHITE_FEMALE }, CharacterConstants.HUMAN_FEMALE),
    [CharacterConstants.BODY_HUMAN_BLACK_FEMALE] = _h2(CharacterConstants.RIG_BASE, "F", 'Female01_Body', "Characters/Citizen_Base/Textures/Human_Body_Female01_base_05", { CharacterConstants.HEAD_HUMAN_BLACK_FEMALE }, CharacterConstants.HUMAN_FEMALE),
  [CharacterConstants.BODY_HUMAN_FAT_BROWN_MALE] = _h3(CharacterConstants.RIG_BASE, "M", 'Male01_FatBody', "Characters/Citizen_Base/Textures/Human_Body_Male01_base_01", { CharacterConstants.HEAD_HUMAN_FAT_BROWN_MALE }, CharacterConstants.HUMAN_FAT_MALE, true),
    [CharacterConstants.BODY_HUMAN_FAT_YELLOWISH_MALE] = _h3(CharacterConstants.RIG_BASE, "M", 'Male01_FatBody', "Characters/Citizen_Base/Textures/Human_Body_Male01_base_02", { CharacterConstants.HEAD_HUMAN_FAT_YELLOWISH_MALE }, CharacterConstants.HUMAN_FAT_MALE, true),
    [CharacterConstants.BODY_HUMAN_FAT_REDDISH_MALE] = _h3(CharacterConstants.RIG_BASE, "M", 'Male01_FatBody', "Characters/Citizen_Base/Textures/Human_Body_Male01_base_03", { CharacterConstants.HEAD_HUMAN_FAT_REDDISH_MALE }, CharacterConstants.HUMAN_FAT_MALE, true),
    [CharacterConstants.BODY_HUMAN_FAT_WHITE_MALE] = _h3(CharacterConstants.RIG_BASE, "M", 'Male01_FatBody', "Characters/Citizen_Base/Textures/Human_Body_Male01_base_04", { CharacterConstants.HEAD_HUMAN_FAT_WHITE_MALE }, CharacterConstants.HUMAN_FAT_MALE, true),
    [CharacterConstants.BODY_HUMAN_FAT_BLACK_MALE] = _h3(CharacterConstants.RIG_BASE, "M", 'Male01_FatBody', "Characters/Citizen_Base/Textures/Human_Body_Male01_base_05", { CharacterConstants.HEAD_HUMAN_FAT_BLACK_MALE }, CharacterConstants.HUMAN_FAT_MALE, true),
    [CharacterConstants.BODY_HUMAN_FAT_BROWN_FEMALE] = _h3(CharacterConstants.RIG_BASE, "F", 'Female01_FatBody', "Characters/Citizen_Base/Textures/Human_Body_Female01_base_01", { CharacterConstants.HEAD_HUMAN_FAT_BROWN_FEMALE }, CharacterConstants.HUMAN_FAT_FEMALE, true),
    [CharacterConstants.BODY_HUMAN_FAT_YELLOWISH_FEMALE] = _h3(CharacterConstants.RIG_BASE, "F", 'Female01_FatBody', "Characters/Citizen_Base/Textures/Human_Body_Female01_base_02", { CharacterConstants.HEAD_HUMAN_FAT_YELLOWISH_FEMALE }, CharacterConstants.HUMAN_FAT_FEMALE, true),
    [CharacterConstants.BODY_HUMAN_FAT_REDDISH_FEMALE] = _h3(CharacterConstants.RIG_BASE, "F", 'Female01_FatBody', "Characters/Citizen_Base/Textures/Human_Body_Female01_base_03", { CharacterConstants.HEAD_HUMAN_FAT_REDDISH_FEMALE }, CharacterConstants.HUMAN_FAT_FEMALE, true),
    [CharacterConstants.BODY_HUMAN_FAT_WHITE_FEMALE] = _h3(CharacterConstants.RIG_BASE, "F", 'Female01_FatBody', "Characters/Citizen_Base/Textures/Human_Body_Female01_base_04", { CharacterConstants.HEAD_HUMAN_FAT_WHITE_FEMALE }, CharacterConstants.HUMAN_FAT_FEMALE, true),
    [CharacterConstants.BODY_HUMAN_FAT_BLACK_FEMALE] = _h3(CharacterConstants.RIG_BASE, "F", 'Female01_FatBody', "Characters/Citizen_Base/Textures/Human_Body_Female01_base_05", { CharacterConstants.HEAD_HUMAN_FAT_BLACK_FEMALE }, CharacterConstants.HUMAN_FAT_FEMALE, true),
    [CharacterConstants.BODY_JELLY_MAUVE_FEMALE] = _h4(CharacterConstants.RIG_BASE, "F", 'Female01_Body', "Characters/Citizen_Base/Textures/Jelly_Body_Female01_base_01", { CharacterConstants.HEAD_JELLY_MAUVE_FEMALE }, CharacterConstants.JELLY_FEMALE, _D.tJobOutfits6),
    [CharacterConstants.BODY_JELLY_PURPLE_FEMALE] = _h4(CharacterConstants.RIG_BASE, "F", 'Female01_Body', "Characters/Citizen_Base/Textures/Jelly_Body_Female01_base_02", { CharacterConstants.HEAD_JELLY_PURPLE_FEMALE }, CharacterConstants.JELLY_FEMALE, _D.tJobOutfits6),
    [CharacterConstants.BODY_JELLY_PINK_FEMALE] = _h4(CharacterConstants.RIG_BASE, "F", 'Female01_Body', "Characters/Citizen_Base/Textures/Jelly_Body_Female01_base_03", { CharacterConstants.HEAD_JELLY_PINK_FEMALE }, CharacterConstants.JELLY_FEMALE, _D.tJobOutfits6),
    [CharacterConstants.BODY_JELLY_BLUE_FEMALE] = _h4(CharacterConstants.RIG_BASE, "F", 'Female01_Body', "Characters/Citizen_Base/Textures/Jelly_Body_Female01_base_04", { CharacterConstants.HEAD_JELLY_BLUE_FEMALE }, CharacterConstants.JELLY_FEMALE, _D.tJobOutfits6),
    [CharacterConstants.BODY_JELLY_FAT_MAUVE_FEMALE] = _h5(CharacterConstants.RIG_BASE, "F", 'Female01_FatBody', "Characters/Citizen_Base/Textures/Jelly_Body_Female01_base_01", true, { CharacterConstants.HEAD_JELLY_MAUVE_FEMALE }, CharacterConstants.JELLY_FAT_FEMALE, _D.tJobOutfits7),
    [CharacterConstants.BODY_JELLY_FAT_PURPLE_FEMALE] = _h5(CharacterConstants.RIG_BASE, "F", 'Female01_FatBody', "Characters/Citizen_Base/Textures/Jelly_Body_Female01_base_02", true, { CharacterConstants.HEAD_JELLY_PURPLE_FEMALE }, CharacterConstants.JELLY_FAT_FEMALE, _D.tJobOutfits7),
    [CharacterConstants.BODY_JELLY_FAT_PINK_FEMALE] = _h5(CharacterConstants.RIG_BASE, "F", 'Female01_FatBody', "Characters/Citizen_Base/Textures/Jelly_Body_Female01_base_03", true, {  CharacterConstants.HEAD_JELLY_PINK_FEMALE }, CharacterConstants.JELLY_FAT_FEMALE, _D.tJobOutfits7),
    [CharacterConstants.BODY_JELLY_FAT_BLUE_FEMALE] = _h5(CharacterConstants.RIG_BASE, "F", 'Female01_FatBody', "Characters/Citizen_Base/Textures/Jelly_Body_Female01_base_04", true, { CharacterConstants.HEAD_JELLY_BLUE_FEMALE }, CharacterConstants.JELLY_FAT_FEMALE, _D.tJobOutfits7),
    [CharacterConstants.BODY_TOBIAN_BLUE_ALIEN_01] = _h4(CharacterConstants.RIG_ALIEN, "M", 'Alien01_Body', "Characters/Citizen_Alien/Textures/Alien_Body01_base_01", {  CharacterConstants.HEAD_TOBIAN_BLUE_ALIEN_01 }, CharacterConstants.TOBIAN, _D.tJobOutfits4),
    [CharacterConstants.BODY_TOBIAN_BLUE_ALIEN_02] = _h4(CharacterConstants.RIG_ALIEN, "M", 'Alien01_Body', "Characters/Citizen_Alien/Textures/Alien_Body01_base_02", {   CharacterConstants.HEAD_TOBIAN_BLUE_ALIEN_02, }, CharacterConstants.TOBIAN, _D.tJobOutfits4),
    [CharacterConstants.BODY_TOBIAN_BLUE_ALIEN_03] = _h4(CharacterConstants.RIG_ALIEN, "M", 'Alien01_Body', "Characters/Citizen_Alien/Textures/Alien_Body01_base_03", { CharacterConstants.HEAD_TOBIAN_BLUE_ALIEN_03, }, CharacterConstants.TOBIAN, _D.tJobOutfits4),
    [CharacterConstants.BODY_TOBIAN_BLUE_ALIEN_04] = _h4(CharacterConstants.RIG_ALIEN, "M", 'Alien01_Body', "Characters/Citizen_Alien/Textures/Alien_Body01_base_04", { CharacterConstants.HEAD_TOBIAN_BLUE_ALIEN_04, }, CharacterConstants.TOBIAN, _D.tJobOutfits4),
    [CharacterConstants.BODY_TOBIAN_BLUE_ALIEN_05] = _h4(CharacterConstants.RIG_ALIEN, "M", 'Alien01_Body', "Characters/Citizen_Alien/Textures/Alien_Body01_base_05", { CharacterConstants.HEAD_TOBIAN_BLUE_ALIEN_05, }, CharacterConstants.TOBIAN, _D.tJobOutfits4),
    [CharacterConstants.BODY_CAT_MALE_01] = _h2(CharacterConstants.RIG_BASE, "M", 'Male01_Body', "Characters/Citizen_Base/Textures/Cat_Body_Male01_base_01", { CharacterConstants.HEAD_CAT_MALE_01 }, CharacterConstants.CAT_MALE),
    [CharacterConstants.BODY_CAT_MALE_02] = _h2(CharacterConstants.RIG_BASE, "M", 'Male01_Body', "Characters/Citizen_Base/Textures/Cat_Body_Male01_base_02", { CharacterConstants.HEAD_CAT_MALE_02 }, CharacterConstants.CAT_MALE),
    [CharacterConstants.BODY_CAT_FEMALE_01] = _h2(CharacterConstants.RIG_BASE, "F", 'Female01_Body', "Characters/Citizen_Base/Textures/Cat_Body_Female01_base_01", { CharacterConstants.HEAD_CAT_FEMALE_01 }, CharacterConstants.CAT_FEMALE),
    [CharacterConstants.BODY_CAT_FEMALE_02] = _h2(CharacterConstants.RIG_BASE, "F", 'Female01_Body', "Characters/Citizen_Base/Textures/Cat_Body_Female01_base_02", { CharacterConstants.HEAD_CAT_FEMALE_02 }, CharacterConstants.CAT_FEMALE),
    [CharacterConstants.BODY_CAT_FAT_MALE_01] = _h6(CharacterConstants.RIG_BASE, "M", 'Male01_FatBody', "Characters/Citizen_Base/Textures/Cat_Body_Male01_base_01", true, {  CharacterConstants.HEAD_CAT_MALE_01  }, CharacterConstants.CAT_FAT_MALE),
    [CharacterConstants.BODY_CAT_FAT_MALE_02] = _h6(CharacterConstants.RIG_BASE, "M", 'Male01_FatBody', "Characters/Citizen_Base/Textures/Cat_Body_Male01_base_02", true, { CharacterConstants.HEAD_CAT_MALE_02 }, CharacterConstants.CAT_FAT_MALE),
    [CharacterConstants.BODY_CAT_FAT_FEMALE_01] = _h6(CharacterConstants.RIG_BASE, "F", 'Female01_FatBody', "Characters/Citizen_Base/Textures/Cat_Body_Female01_base_01", true, { CharacterConstants.HEAD_CAT_FEMALE_01 }, CharacterConstants.CAT_FAT_FEMALE),
    [CharacterConstants.BODY_CAT_FAT_FEMALE_02] = _h6(CharacterConstants.RIG_BASE, "F", 'Female01_FatBody', "Characters/Citizen_Base/Textures/Cat_Body_Female01_base_02", true, { CharacterConstants.HEAD_CAT_FEMALE_02 }, CharacterConstants.CAT_FAT_FEMALE),
    [CharacterConstants.BODY_BIRDSHARK_MALE_01] = _h4(CharacterConstants.RIG_BASE, "M", 'Male01_Body', "Characters/Citizen_Base/Textures/Bird_Body_Male01_base_01", { CharacterConstants.HEAD_BIRDSHARK_MALE_01  }, CharacterConstants.BIRDSHARK_MALE, _D.tJobOutfits6),
    [CharacterConstants.BODY_BIRDSHARK_MALE_02] = _h4(CharacterConstants.RIG_BASE, "M", 'Male01_Body', "Characters/Citizen_Base/Textures/Bird_Body_Male01_base_02", { CharacterConstants.HEAD_BIRDSHARK_MALE_02 }, CharacterConstants.BIRDSHARK_MALE, _D.tJobOutfits6),
    [CharacterConstants.BODY_BIRDSHARK_FEMALE_01] = _h4(CharacterConstants.RIG_BASE, "F", 'Female01_Body', "Characters/Citizen_Base/Textures/Bird_Body_Female01_base_01", {  CharacterConstants.HEAD_BIRDSHARK_FEMALE_01 }, CharacterConstants.BIRDSHARK_FEMALE, _D.tJobOutfits6),
    [CharacterConstants.BODY_BIRDSHARK_FEMALE_02] = _h4(CharacterConstants.RIG_BASE, "F", 'Female01_Body', "Characters/Citizen_Base/Textures/Bird_Body_Female01_base_02", {  CharacterConstants.HEAD_BIRDSHARK_FEMALE_02 }, CharacterConstants.BIRDSHARK_FEMALE, _D.tJobOutfits6),
    [CharacterConstants.BODY_BIRDSHARK_FAT_MALE_01] = _h5(CharacterConstants.RIG_BASE, "M", 'Male01_FatBody', "Characters/Citizen_Base/Textures/Bird_Body_Male01_base_01", true, { CharacterConstants.HEAD_BIRDSHARK_MALE_01  }, CharacterConstants.BIRDSHARK_FAT_MALE, _D.tJobOutfits7),
    [CharacterConstants.BODY_BIRDSHARK_FAT_MALE_02] = _h5(CharacterConstants.RIG_BASE, "M", 'Male01_FatBody', "Characters/Citizen_Base/Textures/Bird_Body_Male01_base_01", true, { CharacterConstants.HEAD_BIRDSHARK_MALE_02  }, CharacterConstants.BIRDSHARK_FAT_MALE, _D.tJobOutfits7),
    [CharacterConstants.BODY_BIRDSHARK_FAT_FEMALE_01] = _h5(CharacterConstants.RIG_BASE, "F", 'Female01_FatBody', "Characters/Citizen_Base/Textures/Bird_Body_Female01_base_01", true, { CharacterConstants.HEAD_BIRDSHARK_FEMALE_01  }, CharacterConstants.BIRDSHARK_FAT_FEMALE, _D.tJobOutfits7),
    [CharacterConstants.BODY_BIRDSHARK_FAT_FEMALE_02] = _h5(CharacterConstants.RIG_BASE, "F", 'Female01_FatBody', "Characters/Citizen_Base/Textures/Bird_Body_Female01_base_01", true, { CharacterConstants.HEAD_BIRDSHARK_FEMALE_02  }, CharacterConstants.BIRDSHARK_FAT_FEMALE, _D.tJobOutfits7),
    [CharacterConstants.BODY_CHICKEN_MALE_01] = _h4(CharacterConstants.RIG_ALIEN, "M", 'Alien01_Body', "Characters/Citizen_Alien/Textures/Chicken_Body01_base_01", { CharacterConstants.HEAD_CHICKEN_MALE_01 }, CharacterConstants.CHICKEN_MALE, _D.tJobOutfits4),
    [CharacterConstants.BODY_CHICKEN_MALE_02] = _h4(CharacterConstants.RIG_ALIEN, "M", 'Alien01_Body', "Characters/Citizen_Alien/Textures/Chicken_Body01_base_02", {  CharacterConstants.HEAD_CHICKEN_MALE_02 }, CharacterConstants.CHICKEN_MALE, _D.tJobOutfits4),
    [CharacterConstants.BODY_CHICKEN_FEMALE_01] = _h4(CharacterConstants.RIG_ALIEN, "F", 'Alien01_Body', "Characters/Citizen_Alien/Textures/Chicken_Body01_base_03", { CharacterConstants.HEAD_CHICKEN_FEMALE_01 }, CharacterConstants.CHICKEN_FEMALE, _D.tJobOutfits4),
    [CharacterConstants.BODY_CHICKEN_FEMALE_02] = _h4(CharacterConstants.RIG_ALIEN, "F", 'Alien01_Body', "Characters/Citizen_Alien/Textures/Chicken_Body01_base_04", {  CharacterConstants.HEAD_CHICKEN_FEMALE_02  }, CharacterConstants.CHICKEN_FEMALE, _D.tJobOutfits4),
    [CharacterConstants.BODY_MONSTER] = {
        nRig = CharacterConstants.RIG_MONSTER,
        sSex = "F",
        bNoReplacements=true,
        bNoSpacesuit=true,
    },
    [CharacterConstants.BODY_SHAMON_MALE_01] = {
        nRig = CharacterConstants.RIG_BASE,
        sSex = "M",
        sBodyModel = 'Male01_ShamonBody',
        sBodyTexture = "Characters/Citizen_Base/Textures/Shamon_Body",
        tHeads = { CharacterConstants.HEAD_SHAMON_MALE_01 },
        nAccessorySetType = CharacterConstants.SHAMON_MALE,
        tJobOutfits = {
            [CharacterConstants.BUILDER] = CharacterConstants.BUILDER_BASE_NORMAL_HOOF_BOOT,
            [CharacterConstants.TECHNICIAN] = CharacterConstants.TECHNICIAN_BASE_NORMAL,
            [CharacterConstants.MINER] = CharacterConstants.MINER_BASE_NORMAL_HOOF_BOOT,
            [CharacterConstants.EMERGENCY] = CharacterConstants.EMERGENCY_BASE_NORMAL_HOOF_BOOT,
        },
        tJobHelmets = {
            [CharacterConstants.BUILDER] = CharacterConstants.NO_HELMET,
            [CharacterConstants.EMERGENCY] = CharacterConstants.NO_HELMET,
            [CharacterConstants.MINER] = CharacterConstants.NO_HELMET,
            [CharacterConstants.BARTENDER] = CharacterConstants.NO_HELMET,
            [CharacterConstants.BOTANIST] = CharacterConstants.NO_HELMET,
            [CharacterConstants.SCIENTIST] = CharacterConstants.NO_HELMET,
        },
    },
    [CharacterConstants.BODY_MURDERFACE_MALE_01] = _h4(CharacterConstants.RIG_ALIEN, "M", 'Alien01_Body', "Characters/Citizen_Alien/Textures/Murder_Body01", { CharacterConstants.HEAD_MURDERFACE_MALE_01 }, CharacterConstants.MURDERFACE_MALE, _D.tJobOutfits4),
    [CharacterConstants.BODY_KILLBOT_01] = {
        nRig = CharacterConstants.RIG_ALIEN,
        sSex = "M",
        bNoReplacements=true,
        bNoSpacesuit=true,
    },
}
CharacterConstants.HEAD_PREFIX = '_Character_Group_Group_Flipbook_Group_Head_FBGroup_Head_Head_Heads_'
_D.tJobHelmets2 = {
    [CharacterConstants.BUILDER] = CharacterConstants.BUILDER_BASE_HELMET,
    [CharacterConstants.TECHNICIAN] = CharacterConstants.NO_HELMET,
    [CharacterConstants.EMERGENCY] = CharacterConstants.EMERGENCY_BASE_HELMET,
    [CharacterConstants.MINER] = CharacterConstants.MINER_BASE_HELMET,
    [CharacterConstants.BARTENDER] = CharacterConstants.NO_HELMET,
}
_D.tFaceBottom3 = {
    CharacterConstants.FACE_BOTTOM_CLEAR,
    CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_01_BLONDE,
    CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_01_RED,
    CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_01_BRUNETTE,
    CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_01_BLACK,
    CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_02_BLONDE,
    CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_02_RED,
    CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_02_BRUNETTE,
    CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_02_BLACK,
    CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_03_BLONDE,
    CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_03_RED,
    CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_03_BRUNETTE,
    CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_03_BLACK,
    CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_04_BLONDE,
    CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_04_RED,
    CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_04_BRUNETTE,
    CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_04_BLACK,
    CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_05_BLONDE,
    CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_05_RED,
    CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_05_BRUNETTE,
    CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_05_BLACK,
    CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_01_GRAY,
    CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_02_GRAY,
    CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_03_GRAY,
    CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_04_GRAY,
    CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_05_GRAY,
}
_D.tJobHelmets5 = {
    [CharacterConstants.BUILDER] = CharacterConstants.NO_HELMET,
    [CharacterConstants.TECHNICIAN] = CharacterConstants.NO_HELMET,
    [CharacterConstants.EMERGENCY] = CharacterConstants.EMERGENCY_BASE_HELMET,
    [CharacterConstants.MINER] = CharacterConstants.MINER_BASE_HELMET,
    [CharacterConstants.BARTENDER] = CharacterConstants.NO_HELMET,
}
_D.tJobHelmets8 = {
    [CharacterConstants.BUILDER] = CharacterConstants.NO_HELMET,
    [CharacterConstants.TECHNICIAN] = CharacterConstants.NO_HELMET,
    [CharacterConstants.EMERGENCY] = CharacterConstants.EMERGENCY_TOBIAN_HELMET,
    [CharacterConstants.MINER] = CharacterConstants.MINER_TOBIAN_HELMET,
    [CharacterConstants.BARTENDER] = CharacterConstants.NO_HELMET,
}
local function H(m,t,hs,fb,ft,jh) return {sHeadModel=m,sHeadTexture=t,nHairSetType=hs,tFaceBottom=fb or {CharacterConstants.FACE_BOTTOM_CLEAR},tFaceTop=ft or {CharacterConstants.FACE_TOP_CLEAR},tJobHelmets=jh} end
CharacterConstants.HEAD_TYPE=
{
    [CharacterConstants.HEAD_HUMAN_BROWN_MALE] = H('Male01_Head',"Characters/Citizen_Base/Textures/Human_Head_Male01_base_01",CharacterConstants.HUMAN_MALE,{ CharacterConstants.FACE_BOTTOM_CLEAR, CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_01_BLONDE, CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_01_RED, CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_01_BRUNETTE, CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_01_BLACK, CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_01_GRAY, CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_02_BLONDE, CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_02_RED, CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_02_BRUNETTE, CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_02_BLACK, CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_02_GRAY, CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_03_BLONDE, CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_03_RED, CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_03_BRUNETTE, CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_03_BLACK, CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_03_GRAY, CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_04_BLONDE, CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_04_RED, CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_04_BRUNETTE, CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_04_BLACK, CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_04_GRAY, CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_05_BLONDE, CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_05_RED, CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_05_BRUNETTE, CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_05_BLACK, CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_05_GRAY, },nil,_D.tJobHelmets2),
    [CharacterConstants.HEAD_HUMAN_YELLOWISH_MALE] = H('Male01_Head',"Characters/Citizen_Base/Textures/Human_Head_Male01_base_02",CharacterConstants.HUMAN_MALE,_D.tFaceBottom3,nil,_D.tJobHelmets2),
    [CharacterConstants.HEAD_HUMAN_REDDISH_MALE] = H('Male01_Head',"Characters/Citizen_Base/Textures/Human_Head_Male01_base_03",CharacterConstants.HUMAN_MALE,_D.tFaceBottom3,nil,_D.tJobHelmets2),
    [CharacterConstants.HEAD_HUMAN_WHITE_MALE] = H('Male01_Head',"Characters/Citizen_Base/Textures/Human_Head_Male01_base_04",CharacterConstants.HUMAN_MALE,_D.tFaceBottom3,nil,_D.tJobHelmets2),
    [CharacterConstants.HEAD_HUMAN_BLACK_MALE] = H('Male01_Head',"Characters/Citizen_Base/Textures/Human_Head_Male01_base_05",CharacterConstants.HUMAN_MALE,_D.tFaceBottom3,nil,_D.tJobHelmets2),
    [CharacterConstants.HEAD_HUMAN_BROWN_FEMALE] = H('Female01_Head',"Characters/Citizen_Base/Textures/Human_Head_Female01_base_01",CharacterConstants.HUMAN_FEMALE,nil,nil,_D.tJobHelmets2),
    [CharacterConstants.HEAD_HUMAN_YELLOWISH_FEMALE] = H('Female01_Head',"Characters/Citizen_Base/Textures/Human_Head_Female01_base_02",CharacterConstants.HUMAN_FEMALE,nil,nil,_D.tJobHelmets2),
    [CharacterConstants.HEAD_HUMAN_REDDISH_FEMALE] = H('Female01_Head',"Characters/Citizen_Base/Textures/Human_Head_Female01_base_03",CharacterConstants.HUMAN_FEMALE,nil,nil,_D.tJobHelmets2),
    [CharacterConstants.HEAD_HUMAN_WHITE_FEMALE] = H('Female01_Head',"Characters/Citizen_Base/Textures/Human_Head_Female01_base_04",CharacterConstants.HUMAN_FEMALE,nil,nil,_D.tJobHelmets2),
    [CharacterConstants.HEAD_HUMAN_BLACK_FEMALE] = H('Female01_Head',"Characters/Citizen_Base/Textures/Human_Head_Female01_base_05",CharacterConstants.HUMAN_FEMALE,nil,nil,_D.tJobHelmets2),
    [CharacterConstants.HEAD_HUMAN_FAT_BROWN_MALE] = H('Male01_FatHead',"Characters/Citizen_Base/Textures/Human_Head_Male01_base_01",CharacterConstants.HUMAN_MALE,_D.tFaceBottom3,nil,_D.tJobHelmets2),
    [CharacterConstants.HEAD_HUMAN_FAT_YELLOWISH_MALE] = H('Male01_FatHead',"Characters/Citizen_Base/Textures/Human_Head_Male01_base_02",CharacterConstants.HUMAN_MALE,_D.tFaceBottom3,nil,_D.tJobHelmets2),
    [CharacterConstants.HEAD_HUMAN_FAT_REDDISH_MALE] = H('Male01_FatHead',"Characters/Citizen_Base/Textures/Human_Head_Male01_base_03",CharacterConstants.HUMAN_MALE,_D.tFaceBottom3,nil,_D.tJobHelmets2),
    [CharacterConstants.HEAD_HUMAN_FAT_WHITE_MALE] = H('Male01_FatHead',"Characters/Citizen_Base/Textures/Human_Head_Male01_base_04",CharacterConstants.HUMAN_MALE,_D.tFaceBottom3,nil,_D.tJobHelmets2),
    [CharacterConstants.HEAD_HUMAN_FAT_BLACK_MALE] = H('Male01_FatHead',"Characters/Citizen_Base/Textures/Human_Head_Male01_base_05",CharacterConstants.HUMAN_MALE,_D.tFaceBottom3,nil,_D.tJobHelmets2),
    [CharacterConstants.HEAD_HUMAN_FAT_BROWN_FEMALE] = H('Female01_FatHead',"Characters/Citizen_Base/Textures/Human_Head_Female01_base_01",CharacterConstants.HUMAN_FEMALE,nil,nil,_D.tJobHelmets2),
    [CharacterConstants.HEAD_HUMAN_FAT_YELLOWISH_FEMALE] = H('Female01_FatHead',"Characters/Citizen_Base/Textures/Human_Head_Female01_base_02",CharacterConstants.HUMAN_FEMALE,nil,nil,_D.tJobHelmets2),
    [CharacterConstants.HEAD_HUMAN_FAT_REDDISH_FEMALE] = H('Female01_FatHead',"Characters/Citizen_Base/Textures/Human_Head_Female01_base_03",CharacterConstants.HUMAN_FEMALE,nil,nil,_D.tJobHelmets2),
    [CharacterConstants.HEAD_HUMAN_FAT_WHITE_FEMALE] = H('Female01_FatHead',"Characters/Citizen_Base/Textures/Human_Head_Female01_base_04",CharacterConstants.HUMAN_FEMALE,nil,nil,_D.tJobHelmets2),
    [CharacterConstants.HEAD_HUMAN_FAT_BLACK_FEMALE] = H('Female01_FatHead',"Characters/Citizen_Base/Textures/Human_Head_Female01_base_05",CharacterConstants.HUMAN_FEMALE,nil,nil,_D.tJobHelmets2),
    [CharacterConstants.HEAD_JELLY_MAUVE_FEMALE] = H('Jelly01_Head',"Characters/Citizen_Base/Textures/Jelly_Head_Female01_base_01",CharacterConstants.BALD,nil,nil,_D.tJobHelmets5),
    [CharacterConstants.HEAD_JELLY_PURPLE_FEMALE] = H('Jelly01_Head',"Characters/Citizen_Base/Textures/Jelly_Head_Female01_base_02",CharacterConstants.BALD,nil,nil,_D.tJobHelmets5),
    [CharacterConstants.HEAD_JELLY_PINK_FEMALE] = H('Jelly01_Head',"Characters/Citizen_Base/Textures/Jelly_Head_Female01_base_03",CharacterConstants.BALD,nil,nil,_D.tJobHelmets5),
    [CharacterConstants.HEAD_JELLY_BLUE_FEMALE] = H('Jelly01_Head',"Characters/Citizen_Base/Textures/Jelly_Head_Female01_base_04",CharacterConstants.BALD,nil,nil,_D.tJobHelmets5),
    [CharacterConstants.HEAD_TOBIAN_BLUE_ALIEN_01] = H('Alien01_Head',"Characters/Citizen_Alien/Textures/Alien_Head01_base_01",CharacterConstants.TOBIAN_BLUE_ALIEN_01,nil,nil,_D.tJobHelmets8),
    [CharacterConstants.HEAD_TOBIAN_BLUE_ALIEN_02] = H('Alien01_Head',"Characters/Citizen_Alien/Textures/Alien_Head01_base_02",CharacterConstants.TOBIAN_BLUE_ALIEN_02,nil,nil,{ [CharacterConstants.BUILDER] = CharacterConstants.NO_HELMET, [CharacterConstants.TECHNICIAN] = CharacterConstants.NO_HELMET, [CharacterConstants.EMERGENCY] = CharacterConstants.EMERGENCY_TOBIAN_HELMET, [CharacterConstants.MINER] = CharacterConstants.MINER_TOBIAN_HELMET, [CharacterConstants.BARTENDER] = CharacterConstants.NO_HELMET, }),
    [CharacterConstants.HEAD_TOBIAN_BLUE_ALIEN_03] = H('Alien01_Head',"Characters/Citizen_Alien/Textures/Alien_Head01_base_03",CharacterConstants.TOBIAN_BLUE_ALIEN_03,nil,nil,{ [CharacterConstants.BUILDER] = CharacterConstants.NO_HELMET, [CharacterConstants.TECHNICIAN] = CharacterConstants.NO_HELMET, [CharacterConstants.EMERGENCY] = CharacterConstants.EMERGENCY_TOBIAN_HELMET, [CharacterConstants.MINER] = CharacterConstants.MINER_TOBIAN_HELMET, [CharacterConstants.BARTENDER] = CharacterConstants.NO_HELMET, }),
    [CharacterConstants.HEAD_TOBIAN_BLUE_ALIEN_04] = H('Alien01_Head',"Characters/Citizen_Alien/Textures/Alien_Head01_base_04",CharacterConstants.TOBIAN_BLUE_ALIEN_04,nil,nil,{ [CharacterConstants.BUILDER] = CharacterConstants.NO_HELMET, [CharacterConstants.TECHNICIAN] = CharacterConstants.NO_HELMET, [CharacterConstants.EMERGENCY] = CharacterConstants.EMERGENCY_TOBIAN_HELMET, [CharacterConstants.MINER] = CharacterConstants.MINER_TOBIAN_HELMET, [CharacterConstants.BARTENDER] = CharacterConstants.NO_HELMET, }),
    [CharacterConstants.HEAD_TOBIAN_BLUE_ALIEN_05] = H('Alien01_Head',"Characters/Citizen_Alien/Textures/Alien_Head01_base_05",CharacterConstants.TOBIAN_BLUE_ALIEN_05,nil,nil,{ [CharacterConstants.BUILDER] = CharacterConstants.NO_HELMET, [CharacterConstants.TECHNICIAN] = CharacterConstants.NO_HELMET, [CharacterConstants.EMERGENCY] = CharacterConstants.EMERGENCY_TOBIAN_HELMET, [CharacterConstants.MINER] = CharacterConstants.MINER_TOBIAN_HELMET, [CharacterConstants.BARTENDER] = CharacterConstants.NO_HELMET, }),
    [CharacterConstants.HEAD_CAT_MALE_01] = H('Cat01_Head',"Characters/Citizen_Base/Textures/Cat_Head_Male01_base_01",CharacterConstants.CAT_MALE_01,nil,nil,_D.tJobHelmets2),
    [CharacterConstants.HEAD_CAT_MALE_02] = H('Cat01_Head',"Characters/Citizen_Base/Textures/Cat_Head_Male01_base_02",CharacterConstants.CAT_MALE_02,nil,nil,_D.tJobHelmets2),
    [CharacterConstants.HEAD_CAT_FEMALE_01] = H('Cat01_Head',"Characters/Citizen_Base/Textures/Cat_Head_Female01_base_01",CharacterConstants.BALD,nil,nil,_D.tJobHelmets2),
    [CharacterConstants.HEAD_CAT_FEMALE_02] = H('Cat01_Head',"Characters/Citizen_Base/Textures/Cat_Head_Female01_base_02",CharacterConstants.BALD,nil,nil,_D.tJobHelmets2),
    [CharacterConstants.HEAD_BIRDSHARK_MALE_01] = H('Bird01_Head',"Characters/Citizen_Base/Textures/Bird_Head_Male01_base_01",CharacterConstants.BALD,nil,nil,_D.tJobHelmets5),
    [CharacterConstants.HEAD_BIRDSHARK_MALE_02] = H('Bird01_Head',"Characters/Citizen_Base/Textures/Bird_Head_Male01_base_02",CharacterConstants.BALD,nil,nil,_D.tJobHelmets5),
    [CharacterConstants.HEAD_BIRDSHARK_FEMALE_01] = H('Bird01_Head',"Characters/Citizen_Base/Textures/Bird_Head_Female01_base_01",CharacterConstants.BALD,nil,nil,_D.tJobHelmets5),
    [CharacterConstants.HEAD_BIRDSHARK_FEMALE_02] = H('Bird01_Head',"Characters/Citizen_Base/Textures/Bird_Head_Female01_base_02",CharacterConstants.BALD,nil,nil,_D.tJobHelmets5),
    [CharacterConstants.HEAD_CHICKEN_MALE_01] = H('Chicken01_Head',"Characters/Citizen_Alien/Textures/Chicken_Head01_base_01",CharacterConstants.BALD,{ CharacterConstants.FACE_BOTTOM_CHICKEN_BEAK_01, CharacterConstants.FACE_BOTTOM_CHICKEN_BEAK_02, },{ CharacterConstants.FACE_TOP_CHICKEN_COMB_01, CharacterConstants.FACE_TOP_CHICKEN_COMB_02, },_D.tJobHelmets8),
    [CharacterConstants.HEAD_CHICKEN_MALE_02] = H('Chicken01_Head',"Characters/Citizen_Alien/Textures/Chicken_Head01_base_02",CharacterConstants.BALD,{ CharacterConstants.FACE_BOTTOM_CHICKEN_BEAK_01, CharacterConstants.FACE_BOTTOM_CHICKEN_BEAK_02, },{ CharacterConstants.FACE_TOP_CHICKEN_COMB_01, CharacterConstants.FACE_TOP_CHICKEN_COMB_02, },_D.tJobHelmets8),
    [CharacterConstants.HEAD_CHICKEN_FEMALE_01] = H('Chicken01_Head',"Characters/Citizen_Alien/Textures/Chicken_Head01_base_03",CharacterConstants.BALD,{ CharacterConstants.FACE_BOTTOM_CHICKEN_BEAK_03, CharacterConstants.FACE_BOTTOM_CHICKEN_BEAK_04, },{ CharacterConstants.FACE_TOP_CHICKEN_COMB_03, CharacterConstants.FACE_TOP_CHICKEN_COMB_04, },_D.tJobHelmets8),
    [CharacterConstants.HEAD_CHICKEN_FEMALE_02] = H('Chicken01_Head',"Characters/Citizen_Alien/Textures/Chicken_Head01_base_04",CharacterConstants.BALD,{ CharacterConstants.FACE_BOTTOM_CHICKEN_BEAK_03, CharacterConstants.FACE_BOTTOM_CHICKEN_BEAK_04, },{ CharacterConstants.FACE_TOP_CHICKEN_COMB_03, CharacterConstants.FACE_TOP_CHICKEN_COMB_04, },_D.tJobHelmets8),
    [CharacterConstants.NO_REPLACE] = H(nil,nil,CharacterConstants.BALD,{ CharacterConstants.NO_REPLACE, },{ CharacterConstants.NO_REPLACE, }),
    [CharacterConstants.HEAD_SHAMON_MALE_01] = H('Shamon01_Head',"Characters/Citizen_Base/Textures/Shamon_Head01",CharacterConstants.BALD,nil,nil,_D.tJobHelmets5),
    [CharacterConstants.HEAD_MURDERFACE_MALE_01] = H('Murderface01_Head',"Characters/Citizen_Alien/Textures/Murder_Head01",CharacterConstants.BALD,nil,nil,_D.tJobHelmets8),
}
CharacterConstants.FACE_BOTTOM_TYPE=
{
    [CharacterConstants.FACE_BOTTOM_CLEAR] = "transparent",
    [CharacterConstants.FACE_BOTTOM_CHICKEN_BEAK_01] = "Characters/Citizen_Alien/Textures/Chicken_Head01_bottom_01",
    [CharacterConstants.FACE_BOTTOM_CHICKEN_BEAK_02] = "Characters/Citizen_Alien/Textures/Chicken_Head01_bottom_02",
    [CharacterConstants.FACE_BOTTOM_CHICKEN_BEAK_03] = "Characters/Citizen_Alien/Textures/Chicken_Head01_bottom_03",
    [CharacterConstants.FACE_BOTTOM_CHICKEN_BEAK_04] = "Characters/Citizen_Alien/Textures/Chicken_Head01_bottom_04",
    [CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_01_BLONDE] = "Characters/Citizen_Base/Textures/Human_Head_Male01_bottom_01_Color_01",
    [CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_01_RED] = "Characters/Citizen_Base/Textures/Human_Head_Male01_bottom_01_Color_02",
    [CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_01_BRUNETTE] = "Characters/Citizen_Base/Textures/Human_Head_Male01_bottom_01_Color_03",
    [CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_01_BLACK] = "Characters/Citizen_Base/Textures/Human_Head_Male01_bottom_01_Color_04",
    [CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_02_BLONDE] = "Characters/Citizen_Base/Textures/Human_Head_Male01_bottom_02_Color_01",
    [CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_02_RED] = "Characters/Citizen_Base/Textures/Human_Head_Male01_bottom_02_Color_02",
    [CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_02_BRUNETTE] = "Characters/Citizen_Base/Textures/Human_Head_Male01_bottom_02_Color_03",
    [CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_02_BLACK] = "Characters/Citizen_Base/Textures/Human_Head_Male01_bottom_02_Color_04",
    [CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_03_BLONDE] = "Characters/Citizen_Base/Textures/Human_Head_Male01_bottom_03_Color_01",
    [CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_03_RED] = "Characters/Citizen_Base/Textures/Human_Head_Male01_bottom_03_Color_02",
    [CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_03_BRUNETTE] = "Characters/Citizen_Base/Textures/Human_Head_Male01_bottom_03_Color_03",
	[CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_03_BLACK] = "Characters/Citizen_Base/Textures/Human_Head_Male01_bottom_03_Color_04",
    [CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_04_BLONDE] = "Characters/Citizen_Base/Textures/Human_Head_Male01_bottom_04_Color_01",
    [CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_04_RED] = "Characters/Citizen_Base/Textures/Human_Head_Male01_bottom_04_Color_02",
    [CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_04_BRUNETTE] = "Characters/Citizen_Base/Textures/Human_Head_Male01_bottom_04_Color_03",
	[CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_04_BLACK] = "Characters/Citizen_Base/Textures/Human_Head_Male01_bottom_04_Color_04",
    [CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_05_BLONDE] = "Characters/Citizen_Base/Textures/Human_Head_Male01_bottom_05_Color_01",
    [CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_05_RED] = "Characters/Citizen_Base/Textures/Human_Head_Male01_bottom_05_Color_02",
    [CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_05_BRUNETTE] = "Characters/Citizen_Base/Textures/Human_Head_Male01_bottom_05_Color_03",
	[CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_05_BLACK] = "Characters/Citizen_Base/Textures/Human_Head_Male01_bottom_05_Color_04",
	[CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_01_GRAY] = "Characters/Citizen_Base/Textures/Human_Head_Male01_bottom_01_Color_05",
	[CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_02_GRAY] = "Characters/Citizen_Base/Textures/Human_Head_Male01_bottom_02_Color_05",
	[CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_03_GRAY] = "Characters/Citizen_Base/Textures/Human_Head_Male01_bottom_03_Color_05",
	[CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_04_GRAY] = "Characters/Citizen_Base/Textures/Human_Head_Male01_bottom_04_Color_05",
	[CharacterConstants.FACE_BOTTOM_HUMAN_BEARD_05_GRAY] = "Characters/Citizen_Base/Textures/Human_Head_Male01_bottom_05_Color_05",
}
CharacterConstants.FACE_TOP_TYPE=
{
    [CharacterConstants.FACE_TOP_CLEAR] = "transparent",
    [CharacterConstants.FACE_TOP_CHICKEN_COMB_01] = "Characters/Citizen_Alien/Textures/Chicken_Head01_top_01",
    [CharacterConstants.FACE_TOP_CHICKEN_COMB_02] = "Characters/Citizen_Alien/Textures/Chicken_Head01_top_02",
    [CharacterConstants.FACE_TOP_CHICKEN_COMB_03] = "Characters/Citizen_Alien/Textures/Chicken_Head01_top_03",
    [CharacterConstants.FACE_TOP_CHICKEN_COMB_04] = "Characters/Citizen_Alien/Textures/Chicken_Head01_top_04",
}
CharacterConstants.HAIR_PREFIX = "_Character_Group_Group_Flipbook_Group_Hair_FBGroup_Hairs_Head_Hairs_"
CharacterConstants.HAIR_TYPE=
{
    [CharacterConstants.BALD] = { },
    [CharacterConstants.MALE_HAIR_01_BLONDE] = { sHairModel = 'Short06', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_01", sPortraitColor = "Yellow" },
	[CharacterConstants.MALE_HAIR_01_RED] = { sHairModel = 'Short06', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_02", sPortraitColor = "Orange" },
	[CharacterConstants.MALE_HAIR_01_BRUNETTE] = { sHairModel = 'Short06', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_03", sPortraitColor = "Brown" },
	[CharacterConstants.MALE_HAIR_01_BLACK] = { sHairModel = 'Short06', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_04", sPortraitColor = "Black" },
	[CharacterConstants.MALE_HAIR_01_REDBANGS] = { sHairModel = 'Short06', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_05", sPortraitColor = "Red" },
	[CharacterConstants.MALE_HAIR_01_BLUEBANGS] = { sHairModel = 'Short06', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_06", sPortraitColor = "Blue" },
	[CharacterConstants.MALE_HAIR_01_GRAY] = { sHairModel = 'Short06', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_07", sPortraitColor = "Gray" },
    [CharacterConstants.MALE_HAIR_02_BLONDE] = { sHairModel = 'Short03', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_01", sPortraitColor = "Yellow" },
	[CharacterConstants.MALE_HAIR_02_RED] = { sHairModel = 'Short03', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_02", sPortraitColor = "Orange" },
	[CharacterConstants.MALE_HAIR_02_BRUNETTE] = { sHairModel = 'Short03', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_03", sPortraitColor = "Brown" },
	[CharacterConstants.MALE_HAIR_02_BLACK] = { sHairModel = 'Short03', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_04", sPortraitColor = "Black" },
	[CharacterConstants.MALE_HAIR_02_REDBANGS] = { sHairModel = 'Short03', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_05", sPortraitColor = "Red" },
	[CharacterConstants.MALE_HAIR_02_BLUEBANGS] = { sHairModel = 'Short03', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_06", sPortraitColor = "Blue" },
	[CharacterConstants.MALE_HAIR_02_GRAY] = { sHairModel = 'Short03', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_07", sPortraitColor = "Gray" },
    [CharacterConstants.MALE_HAIR_03_BLONDE] = { sHairModel = 'Short05', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_01", sPortraitColor = "Yellow" },
	[CharacterConstants.MALE_HAIR_03_RED] = { sHairModel = 'Short05', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_02", sPortraitColor = "Orange" },
	[CharacterConstants.MALE_HAIR_03_BRUNETTE] = { sHairModel = 'Short05', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_03", sPortraitColor = "Brown" },
	[CharacterConstants.MALE_HAIR_03_BLACK] = { sHairModel = 'Short05', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_04", sPortraitColor = "Black" },
	[CharacterConstants.MALE_HAIR_03_REDBANGS] = { sHairModel = 'Short05', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_05", sPortraitColor = "Red" },
	[CharacterConstants.MALE_HAIR_03_BLUEBANGS] = { sHairModel = 'Short05', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_06", sPortraitColor = "Blue" },
	[CharacterConstants.MALE_HAIR_03_GRAY] = { sHairModel = 'Short05', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_07", sPortraitColor = "Gray" },
    [CharacterConstants.MALE_HAIR_04_BLONDE] = { sHairModel = 'Short07', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_01", sPortraitColor = "Yellow" },
	[CharacterConstants.MALE_HAIR_04_RED] = { sHairModel = 'Short07', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_02", sPortraitColor = "Orange" },
	[CharacterConstants.MALE_HAIR_04_BRUNETTE] = { sHairModel = 'Short07', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_03", sPortraitColor = "Brown" },
	[CharacterConstants.MALE_HAIR_04_BLACK] = { sHairModel = 'Short07', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_04", sPortraitColor = "Black" },
	[CharacterConstants.MALE_HAIR_04_REDBANGS] = { sHairModel = 'Short07', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_05", sPortraitColor = "Red" },
	[CharacterConstants.MALE_HAIR_04_BLUEBANGS] = { sHairModel = 'Short07', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_06", sPortraitColor = "Blue" },
	[CharacterConstants.MALE_HAIR_04_GRAY] = { sHairModel = 'Short07', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_07", sPortraitColor = "Gray" },
    [CharacterConstants.MALE_HAIR_05_BLONDE] = { sHairModel = 'Short08', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_01", sPortraitColor = "Yellow" },
	[CharacterConstants.MALE_HAIR_05_RED] = { sHairModel = 'Short08', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_02", sPortraitColor = "Red" },
	[CharacterConstants.MALE_HAIR_05_BRUNETTE] = { sHairModel = 'Short08', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_03", sPortraitColor = "Brown" },
	[CharacterConstants.MALE_HAIR_05_BLACK] = { sHairModel = 'Short08', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_04", sPortraitColor = "Black" },
	[CharacterConstants.MALE_HAIR_05_REDBANGS] = { sHairModel = 'Short08', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_05", sPortraitColor = "Red" },
	[CharacterConstants.MALE_HAIR_05_BLUEBANGS] = { sHairModel = 'Short08', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_06", sPortraitColor = "Blue" },
	[CharacterConstants.MALE_HAIR_05_GRAY] = { sHairModel = 'Short08', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_07", sPortraitColor = "Gray" },
    [CharacterConstants.FEMALE_HAIR_01_BLONDE] = { sHairModel = 'Short01', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Long01_Color_01", sPortraitColor = "Yellow" },
	[CharacterConstants.FEMALE_HAIR_01_RED] = { sHairModel = 'Short01', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Long01_Color_02", sPortraitColor = "Orange" },
	[CharacterConstants.FEMALE_HAIR_01_BRUNETTE] = { sHairModel = 'Short01', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Long01_Color_03", sPortraitColor = "Brown" },
	[CharacterConstants.FEMALE_HAIR_01_BLACK] = { sHairModel = 'Short01', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Long01_Color_04", sPortraitColor = "Black" },
	[CharacterConstants.FEMALE_HAIR_01_PURPLE] = { sHairModel = 'Short01', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Long01_Color_05", sPortraitColor = "Pink" },
	[CharacterConstants.FEMALE_HAIR_01_GREEN] = { sHairModel = 'Short01', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Long01_Color_06", sPortraitColor = "Green" },
	[CharacterConstants.FEMALE_HAIR_01_GRAY] = { sHairModel = 'Short01', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Long01_Color_07", sPortraitColor = "Gray" },
    [CharacterConstants.FEMALE_HAIR_02_BLONDE] = { sHairModel = 'Short02', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short02_Color_01", sPortraitColor = "Yellow" },
	[CharacterConstants.FEMALE_HAIR_02_RED] = { sHairModel = 'Short02', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short02_Color_02", sPortraitColor = "Orange" },
	[CharacterConstants.FEMALE_HAIR_02_BRUNETTE] = { sHairModel = 'Short02', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short02_Color_03", sPortraitColor = "Brown" },
	[CharacterConstants.FEMALE_HAIR_02_BLACK] = { sHairModel = 'Short02', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short02_Color_04", sPortraitColor = "Black" },
	[CharacterConstants.FEMALE_HAIR_02_GRAY] = { sHairModel = 'Short02', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short02_Color_07", sPortraitColor = "Gray" },
    [CharacterConstants.FEMALE_HAIR_03_BLONDE] = { sHairModel = 'Short06', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_01", sPortraitColor = "Yellow" },
	[CharacterConstants.FEMALE_HAIR_03_RED] = { sHairModel = 'Short06', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_02", sPortraitColor = "Orange" },
	[CharacterConstants.FEMALE_HAIR_03_BRUNETTE] = { sHairModel = 'Short06', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_03", sPortraitColor = "Brown" },
	[CharacterConstants.FEMALE_HAIR_03_BLACK] = { sHairModel = 'Short06', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_04", sPortraitColor = "Black" },
	[CharacterConstants.FEMALE_HAIR_03_REDBANGS] = { sHairModel = 'Short06', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_05", sPortraitColor = "Red" },
	[CharacterConstants.FEMALE_HAIR_03_BLUEBANGS] = { sHairModel = 'Short06', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_06", sPortraitColor = "Blue" },
	[CharacterConstants.FEMALE_HAIR_03_GRAY] = { sHairModel = 'Short06', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_07", sPortraitColor = "Gray" },
    [CharacterConstants.FEMALE_HAIR_04_BLONDE] = { sHairModel = 'Short04', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_01", sPortraitColor = "Yellow" },
	[CharacterConstants.FEMALE_HAIR_04_RED] = { sHairModel = 'Short04', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_02", sPortraitColor = "Orange" },
	[CharacterConstants.FEMALE_HAIR_04_BRUNETTE] = { sHairModel = 'Short04', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_03", sPortraitColor = "Brown" },
	[CharacterConstants.FEMALE_HAIR_04_BLACK] = { sHairModel = 'Short04', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_04", sPortraitColor = "Black" },
	[CharacterConstants.FEMALE_HAIR_04_REDBANGS] = { sHairModel = 'Short04', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_05", sPortraitColor = "Red" },
	[CharacterConstants.FEMALE_HAIR_04_BLUEBANGS] = { sHairModel = 'Short04', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_06", sPortraitColor = "Blue" },
	[CharacterConstants.FEMALE_HAIR_04_GRAY] = { sHairModel = 'Short04', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Short03_Color_07", sPortraitColor = "Gray" },
	[CharacterConstants.FEMALE_HAIR_05_BLONDE] = { sHairModel = 'Long01', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Long01_Color_01", sPortraitColor = "Yellow" },
	[CharacterConstants.FEMALE_HAIR_05_RED] = { sHairModel = 'Long01', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Long01_Color_02", sPortraitColor = "Orange" },
	[CharacterConstants.FEMALE_HAIR_05_BRUNETTE] = { sHairModel = 'Long01', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Long01_Color_03", sPortraitColor = "Brown" },
	[CharacterConstants.FEMALE_HAIR_05_BLACK] = { sHairModel = 'Long01', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Long01_Color_04", sPortraitColor = "Black" },
	[CharacterConstants.FEMALE_HAIR_05_PURPLE] = { sHairModel = 'Long01', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Long01_Color_05", sPortraitColor = "Pink" },
	[CharacterConstants.FEMALE_HAIR_05_GREEN] = { sHairModel = 'Long01', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Long01_Color_06", sPortraitColor = "Green" },
	[CharacterConstants.FEMALE_HAIR_05_GRAY] = { sHairModel = 'Long01', sHairTexture = "Characters/Citizen_Base/Textures/Hair_Long01_Color_07", sPortraitColor = "Gray" },
    [CharacterConstants.TOBIAN_DONG_01] = { sHairModel = 'Alien01_Hair01', sHairTexture = "Characters/Citizen_Alien/Textures/Alien_Head01_base_01" },
    [CharacterConstants.TOBIAN_DONG_02] = { sHairModel = 'Alien01_Hair01', sHairTexture = "Characters/Citizen_Alien/Textures/Alien_Head01_base_02" },
    [CharacterConstants.TOBIAN_DONG_03] = { sHairModel = 'Alien01_Hair01', sHairTexture = "Characters/Citizen_Alien/Textures/Alien_Head01_base_03" },
    [CharacterConstants.TOBIAN_DONG_04] = { sHairModel = 'Alien01_Hair01', sHairTexture = "Characters/Citizen_Alien/Textures/Alien_Head01_base_04" },
    [CharacterConstants.TOBIAN_DONG_05] = { sHairModel = 'Alien01_Hair01', sHairTexture = "Characters/Citizen_Alien/Textures/Alien_Head01_base_05" },
    [CharacterConstants.TOBIAN_MUSTACHE_01] = { sHairModel = 'Moustache01_Hair01', sHairTexture = "Characters/Citizen_Alien/Textures/Moustache01_Hair01_base_01" },
    [CharacterConstants.TOBIAN_MUSTACHE_02] = { sHairModel = 'Moustache01_Hair01', sHairTexture = "Characters/Citizen_Alien/Textures/Moustache01_Hair01_base_02" },
    [CharacterConstants.TOBIAN_MUSTACHE_03] = { sHairModel = 'Moustache01_Hair01', sHairTexture = "Characters/Citizen_Alien/Textures/Moustache01_Hair01_base_03" },
    [CharacterConstants.TOBIAN_MUSTACHE_04] = { sHairModel = 'Moustache01_Hair01', sHairTexture = "Characters/Citizen_Alien/Textures/Moustache01_Hair01_base_04" },
    [CharacterConstants.TOBIAN_MUSTACHE_05] = { sHairModel = 'Moustache01_Hair01', sHairTexture = "Characters/Citizen_Alien/Textures/Moustache01_Hair01_base_05" },
    [CharacterConstants.TOBIAN_ELEPHANT_01] = { sHairModel = 'Elephant01_Hair01', sHairTexture = "Characters/Citizen_Alien/Textures/Elephant01_Hair01_base_01" },
    [CharacterConstants.TOBIAN_ELEPHANT_02] = { sHairModel = 'Elephant01_Hair01', sHairTexture = "Characters/Citizen_Alien/Textures/Elephant01_Hair01_base_02" },
    [CharacterConstants.TOBIAN_ELEPHANT_03] = { sHairModel = 'Elephant01_Hair01', sHairTexture = "Characters/Citizen_Alien/Textures/Elephant01_Hair01_base_03" },
    [CharacterConstants.TOBIAN_ELEPHANT_04] = { sHairModel = 'Elephant01_Hair01', sHairTexture = "Characters/Citizen_Alien/Textures/Elephant01_Hair01_base_04" },
    [CharacterConstants.TOBIAN_ELEPHANT_05] = { sHairModel = 'Elephant01_Hair01', sHairTexture = "Characters/Citizen_Alien/Textures/Elephant01_Hair01_base_05" },
    [CharacterConstants.CAT_MUSTACHE_01] = { sHairModel = 'Cat01', sHairTexture = "Characters/Citizen_Base/Textures/Cat_Head_Male01_base_01" },
    [CharacterConstants.CAT_MUSTACHE_02] = { sHairModel = 'Cat01', sHairTexture = "Characters/Citizen_Base/Textures/Cat_Head_Male01_base_02" },
    [CharacterConstants.NO_REPLACE] = {
    },
}
CharacterConstants.HAIR_SET_TYPE=
{
    [CharacterConstants.BALD]={
        tHairs = { CharacterConstants.BALD },
    },
    [CharacterConstants.HUMAN_MALE] = {
        tHairs = {
            CharacterConstants.BALD,
            CharacterConstants.MALE_HAIR_01_BLONDE,
            CharacterConstants.MALE_HAIR_01_RED,
            CharacterConstants.MALE_HAIR_01_BRUNETTE,
            CharacterConstants.MALE_HAIR_01_BLACK,
            CharacterConstants.MALE_HAIR_01_REDBANGS,
            CharacterConstants.MALE_HAIR_01_BLUEBANGS,
            CharacterConstants.MALE_HAIR_02_BLONDE,
            CharacterConstants.MALE_HAIR_02_RED,
            CharacterConstants.MALE_HAIR_02_BRUNETTE,
            CharacterConstants.MALE_HAIR_02_BLACK,
            CharacterConstants.MALE_HAIR_02_REDBANGS,
            CharacterConstants.MALE_HAIR_02_BLUEBANGS,
            CharacterConstants.MALE_HAIR_03_BLONDE,
            CharacterConstants.MALE_HAIR_03_RED,
            CharacterConstants.MALE_HAIR_03_BRUNETTE,
            CharacterConstants.MALE_HAIR_03_BLACK,
            CharacterConstants.MALE_HAIR_03_REDBANGS,
            CharacterConstants.MALE_HAIR_03_BLUEBANGS,
            CharacterConstants.MALE_HAIR_04_BLONDE,
            CharacterConstants.MALE_HAIR_04_RED,
            CharacterConstants.MALE_HAIR_04_BRUNETTE,
            CharacterConstants.MALE_HAIR_04_BLACK,
            CharacterConstants.MALE_HAIR_04_REDBANGS,
            CharacterConstants.MALE_HAIR_04_BLUEBANGS,
            CharacterConstants.MALE_HAIR_05_BLONDE,
            CharacterConstants.MALE_HAIR_05_RED,
            CharacterConstants.MALE_HAIR_05_BRUNETTE,
            CharacterConstants.MALE_HAIR_05_BLACK,
            CharacterConstants.MALE_HAIR_05_REDBANGS,
            CharacterConstants.MALE_HAIR_05_BLUEBANGS,
            CharacterConstants.MALE_HAIR_01_GRAY,
            CharacterConstants.MALE_HAIR_02_GRAY,
            CharacterConstants.MALE_HAIR_03_GRAY,
            CharacterConstants.MALE_HAIR_04_GRAY,
            CharacterConstants.MALE_HAIR_05_GRAY,
        },
    },
    [CharacterConstants.HUMAN_FEMALE] = {
        tHairs = {
            CharacterConstants.BALD,
            CharacterConstants.FEMALE_HAIR_01_BLONDE,
			CharacterConstants.FEMALE_HAIR_01_RED,
			CharacterConstants.FEMALE_HAIR_01_BRUNETTE,
			CharacterConstants.FEMALE_HAIR_01_BLACK,
			CharacterConstants.FEMALE_HAIR_01_PURPLE,
			CharacterConstants.FEMALE_HAIR_01_GREEN,
            CharacterConstants.FEMALE_HAIR_02_BLONDE,
			CharacterConstants.FEMALE_HAIR_02_RED,
			CharacterConstants.FEMALE_HAIR_02_BRUNETTE,
			CharacterConstants.FEMALE_HAIR_02_BLACK,
            CharacterConstants.FEMALE_HAIR_03_BLONDE,
			CharacterConstants.FEMALE_HAIR_03_RED,
			CharacterConstants.FEMALE_HAIR_03_BRUNETTE,
			CharacterConstants.FEMALE_HAIR_03_BLACK,
			CharacterConstants.FEMALE_HAIR_03_REDBANGS,
			CharacterConstants.FEMALE_HAIR_03_BLUEBANGS,
            CharacterConstants.FEMALE_HAIR_04_BLONDE,
			CharacterConstants.FEMALE_HAIR_04_RED,
			CharacterConstants.FEMALE_HAIR_04_BRUNETTE,
			CharacterConstants.FEMALE_HAIR_04_BLACK,
			CharacterConstants.FEMALE_HAIR_04_REDBANGS,
			CharacterConstants.FEMALE_HAIR_04_BLUEBANGS,
            CharacterConstants.FEMALE_HAIR_05_BLONDE,
			CharacterConstants.FEMALE_HAIR_05_RED,
			CharacterConstants.FEMALE_HAIR_05_BRUNETTE,
			CharacterConstants.FEMALE_HAIR_05_BLACK,
			CharacterConstants.FEMALE_HAIR_05_PURPLE,
			CharacterConstants.FEMALE_HAIR_05_GREEN,
			CharacterConstants.FEMALE_HAIR_01_GRAY,
			CharacterConstants.FEMALE_HAIR_02_GRAY,
			CharacterConstants.FEMALE_HAIR_03_GRAY,
			CharacterConstants.FEMALE_HAIR_04_GRAY,
			CharacterConstants.FEMALE_HAIR_05_GRAY,
        },
    },
    [CharacterConstants.TOBIAN_BLUE_ALIEN_01] = {
        tHairs = {
            CharacterConstants.TOBIAN_DONG_01,
            CharacterConstants.TOBIAN_MUSTACHE_01,
            CharacterConstants.TOBIAN_ELEPHANT_01,
        },
    },
    [CharacterConstants.TOBIAN_BLUE_ALIEN_02] = {
        tHairs = {
            CharacterConstants.TOBIAN_DONG_02,
            CharacterConstants.TOBIAN_MUSTACHE_02,
            CharacterConstants.TOBIAN_ELEPHANT_02,
        },
    },
    [CharacterConstants.TOBIAN_BLUE_ALIEN_03] = {
        tHairs = {
            CharacterConstants.TOBIAN_DONG_03,
            CharacterConstants.TOBIAN_MUSTACHE_03,
            CharacterConstants.TOBIAN_ELEPHANT_03,
        },
    },
    [CharacterConstants.TOBIAN_BLUE_ALIEN_04] = {
        tHairs = {
            CharacterConstants.TOBIAN_DONG_04,
            CharacterConstants.TOBIAN_MUSTACHE_04,
            CharacterConstants.TOBIAN_ELEPHANT_04,
        },
    },
    [CharacterConstants.TOBIAN_BLUE_ALIEN_05] = {
        tHairs = {
            CharacterConstants.TOBIAN_DONG_05,
            CharacterConstants.TOBIAN_MUSTACHE_05,
            CharacterConstants.TOBIAN_ELEPHANT_05,
        },
    },
    [CharacterConstants.CAT_MALE_01]={
        tHairs = { CharacterConstants.CAT_MUSTACHE_01, },
    },
    [CharacterConstants.CAT_MALE_02]={
        tHairs = { CharacterConstants.CAT_MUSTACHE_02, },
    },
}
CharacterConstants.BOTTOM_ACCESSORY_PREFIX = "_Character_Group_Group_Flipbook_Group_AC_LwBody_FBGroup_LwBody_AllTransB_LwBody_"
_D.tJobModelConflicts1 = {
    CharacterConstants.BUILDER,
    CharacterConstants.TECHNICIAN,
    CharacterConstants.MINER,
    CharacterConstants.EMERGENCY,
    CharacterConstants.BARTENDER,
    CharacterConstants.BOTANIST,
    CharacterConstants.SCIENTIST,
    CharacterConstants.DOCTOR,
}
_D.CharacterConstantsMA13 = _h7('Belt01', "Characters/Citizen_Base/Textures/Straps_Pouches", _D.tJobModelConflicts1)
CharacterConstants.BOTTOM_ACCESSORY_TYPE=
{
    [CharacterConstants.MALE_BOTTOM_ACCESSORY_LEGPOUCH_01] = _h7('M_LegPouch01', "Characters/Citizen_Base/Textures/Straps_Pouches", _D.tJobModelConflicts1),
    [CharacterConstants.MALE_BOTTOM_ACCESSORY_FAT_LEGPOUCH_01] = _h7('M_FatLegPouch', "Characters/Citizen_Base/Textures/Straps_Pouches", _D.tJobModelConflicts1),
    [CharacterConstants.FEMALE_BOTTOM_ACCESSORY_FAT_LEGPOUCH_01] = _h7('F_FatLegPouch', "Characters/Citizen_Base/Textures/Straps_Pouches", _D.tJobModelConflicts1),
    [CharacterConstants.MALE_BOTTOM_ACCESSORY_BELT_01] = _D.CharacterConstantsMA13,
    [CharacterConstants.FEMALE_BOTTOM_ACCESSORY_LEGPOUCH_01] = _h7('F_LegPouch01', "Characters/Citizen_Base/Textures/Straps_Pouches", _D.tJobModelConflicts1),
    [CharacterConstants.FEMALE_BOTTOM_ACCESSORY_BELT_01] = _D.CharacterConstantsMA13,
    [CharacterConstants.FEMALE_BOTTOM_ACCESSORY_FAT_BELT_01] = _h7('FatBelt_F', "Characters/Citizen_Base/Textures/Straps_Pouches", _D.tJobModelConflicts1),
    [CharacterConstants.MALE_BOTTOM_ACCESSORY_FAT_BELT_01] = _h7('FatBelt_M', "Characters/Citizen_Base/Textures/Straps_Pouches", _D.tJobModelConflicts1),
    [CharacterConstants.TOBIAN_BOTTOM_ACCESSORY_LEGPOUCH_01] = _h7('LegPouch01', "Characters/Citizen_Base/Textures/Straps_Pouches", _D.tJobModelConflicts1),
    [CharacterConstants.TOBIAN_BOTTOM_ACCESSORY_BELT_01] = _D.CharacterConstantsMA13,
    [CharacterConstants.MALE_BOTTOM_ACCESSORY_TOURISTSHORTS_01] = _h7('TouristShorts_M', "Characters/Citizen_Base/Textures/Tourist_Shorts_Male_01", _D.tJobModelConflicts1),
    [CharacterConstants.FEMALE_BOTTOM_ACCESSORY_TOURISTSHORTS_01] = _h7('TouristShorts_F', "Characters/Citizen_Base/Textures/Tourist_Shorts_Female_01", _D.tJobModelConflicts1),
    [CharacterConstants.MALE_BOTTOM_ACCESSORY_FAT_TOURISTSHORTS_01] = _h7('FatTouristShorts_M', "Characters/Citizen_Base/Textures/Tourist_Shorts_Male_01", _D.tJobModelConflicts1),
    [CharacterConstants.TOBIAN_BOTTOM_ACCESSORY_TOURISTSHORTS_01] = _h7('TouristShorts', "Characters/Citizen_Base/Textures/Tourist_Shorts_Male_01", _D.tJobModelConflicts1),
    [CharacterConstants.NO_REPLACE] = {
    },
    [CharacterConstants.SHAMON_BOTTOM_ACCESSORY_LEGPOUCH_01] = _h7('ShamonLegPouch01', "Characters/Citizen_Base/Textures/Straps_Pouches", _D.tJobModelConflicts1),
    [CharacterConstants.SHAMON_BOTTOM_ACCESSORY_BELT_01] = _h7('ShamonBelt01', "Characters/Citizen_Base/Textures/Straps_Pouches", _D.tJobModelConflicts1),
}
CharacterConstants.TOP_ACCESSORY_PREFIX = "_Character_Group_Group_Flipbook_Group_AC_UpBody_FBGroup_UpBody_AllTransB_UpBody_"
_D.tJobModelConflicts10 = {
    CharacterConstants.MINER,
    CharacterConstants.EMERGENCY,
    CharacterConstants.BARTENDER,
    CharacterConstants.BUILDER,
    CharacterConstants.TECHNICIAN,
    CharacterConstants.BOTANIST,
    CharacterConstants.SCIENTIST,
    CharacterConstants.DOCTOR,
}
_D.tJobModelConflicts11 = {
    CharacterConstants.MINER,
    CharacterConstants.EMERGENCY,
    CharacterConstants.BARTENDER,
    CharacterConstants.BOTANIST,
    CharacterConstants.SCIENTIST,
    CharacterConstants.DOCTOR,
}
_D.tJobModelConflicts12 = {
    CharacterConstants.BUILDER,
    CharacterConstants.TECHNICIAN,
    CharacterConstants.MINER,
    CharacterConstants.EMERGENCY,
}
_D.tJobModelConflicts16 = {
    CharacterConstants.MINER,
    CharacterConstants.EMERGENCY,
    CharacterConstants.TECHNICIAN,
    CharacterConstants.BUILDER,
    CharacterConstants.BARTENDER,
    CharacterConstants.BOTANIST,
    CharacterConstants.SCIENTIST,
    CharacterConstants.DOCTOR,
}
_D.CharacterConstantsMA19 = _h7('Vest01', "Characters/Citizen_Base/Textures/AC_UpBody02", _D.tJobModelConflicts1)
_D.CharacterConstantsMA20 = _h7('FatTouristShirt_M', "Characters/Citizen_Base/Textures/Tourist_Shirt_Male_02", _D.tJobModelConflicts1)
_D.CharacterConstantsMA21 = _h7('TouristShirt_M', "Characters/Citizen_Base/Textures/Tourist_Shirt_Male_02", _D.tJobModelConflicts1)
CharacterConstants.TOP_ACCESSORY_TYPE=
{
    [CharacterConstants.MALE_TOP_ACCESSORY_COLLAR_01] = _h7('M_Collar01', "Characters/Citizen_Base/Textures/Collar01", _D.tJobModelConflicts1),
    [CharacterConstants.MALE_TOP_ACCESSORY_FAT_COLLAR_01] = _h7('M_FatCollar01', "Characters/Citizen_Base/Textures/Collar01", _D.tJobModelConflicts1),
    [CharacterConstants.MALE_TOP_ACCESSORY_VEST_01] = {
        sModel = 'Vest01',
        sTexture = "Characters/Citizen_Base/Textures/AC_UpBody01",
        tJobModelConflicts = {
            CharacterConstants.BUILDER,
            CharacterConstants.TECHNICIAN,
            CharacterConstants.MINER,
            CharacterConstants.EMERGENCY,
            CharacterConstants.SCIENTIST,
            CharacterConstants.BARTENDER,
            CharacterConstants.BOTANIST,
            CharacterConstants.DOCTOR,
        },
    },
    [CharacterConstants.MALE_TOP_ACCESSORY_VEST_01_BEIGE] = _D.CharacterConstantsMA19,
    [CharacterConstants.FEMALE_TOP_ACCESSORY_COLLAR_01] = _h7('F_Collar01', "Characters/Citizen_Base/Textures/Collar01", _D.tJobModelConflicts1),
    [CharacterConstants.FEMALE_TOP_ACCESSORY_VEST_01] = _h7('Vest01', "Characters/Citizen_Base/Textures/AC_UpBody01", _D.tJobModelConflicts1),
    [CharacterConstants.FEMALE_TOP_ACCESSORY_VEST_01_BEIGE] = _D.CharacterConstantsMA19,
    [CharacterConstants.FEMALE_TOP_ACCESSORY_BANDOLIER_01] = _h7('Bandoleer_01_F', "Characters/Citizen_Base/Textures/Straps_Pouches", _D.tJobModelConflicts1),
    [CharacterConstants.FEMALE_TOP_ACCESSORY_FAT_BANDOLIER_01] = _h7('FatBandoleer_01_F', "Characters/Citizen_Base/Textures/Straps_Pouches", _D.tJobModelConflicts1),
 [CharacterConstants.FEMALE_TOP_ACCESSORY_BANDOLIER_02] = _h7('Bandoleer_02_F', "Characters/Citizen_Base/Textures/Straps_Pouches", _D.tJobModelConflicts1),
    [CharacterConstants.FEMALE_TOP_ACCESSORY_FAT_BANDOLIER_02] = _h7('FatBandoleer_02_F', "Characters/Citizen_Base/Textures/Straps_Pouches", _D.tJobModelConflicts1),
    [CharacterConstants.MALE_TOP_ACCESSORY_BANDOLIER_01] = _h7('Bandoleer_01_M', "Characters/Citizen_Base/Textures/Straps_Pouches", _D.tJobModelConflicts1),
    [CharacterConstants.MALE_TOP_ACCESSORY_BANDOLIER_02] = _h7('Bandoleer_02_M', "Characters/Citizen_Base/Textures/Straps_Pouches", _D.tJobModelConflicts1),
    [CharacterConstants.MALE_TOP_ACCESSORY_FAT_BANDOLIER_01] = _h7('FatBandoleer_01_M', "Characters/Citizen_Base/Textures/Straps_Pouches", _D.tJobModelConflicts1),
    [CharacterConstants.MALE_TOP_ACCESSORY_FAT_BANDOLIER_02] = _h7('FatBandoleer_02_M', "Characters/Citizen_Base/Textures/Straps_Pouches", _D.tJobModelConflicts1),
    [CharacterConstants.MALE_TOP_ACCESSORY_FAT_TOURIST_SHIRT_02] = _D.CharacterConstantsMA20,
    [CharacterConstants.MALE_TOP_ACCESSORY_FAT_TOURIST_SHIRT_03] = _h7('FatTouristShirt_M', "Characters/Citizen_Base/Textures/Tourist_Shirt_Male_03", _D.tJobModelConflicts1),
    [CharacterConstants.MALE_TOP_ACCESSORY_FAT_TOURIST_SHIRT_04] = _h7('FatTouristShirt_M', "Characters/Citizen_Base/Textures/Tourist_Shirt_Male_04", _D.tJobModelConflicts1),
    [CharacterConstants.MALE_TOP_ACCESSORY_FAT_TOURIST_SHIRT_05] = _D.CharacterConstantsMA20,
    [CharacterConstants.MALE_TOP_ACCESSORY_TOURIST_SHIRT_02] = _D.CharacterConstantsMA21,
    [CharacterConstants.MALE_TOP_ACCESSORY_TOURIST_SHIRT_03] = _h7('TouristShirt_M', "Characters/Citizen_Base/Textures/Tourist_Shirt_Male_03", _D.tJobModelConflicts1),
    [CharacterConstants.MALE_TOP_ACCESSORY_TOURIST_SHIRT_04] = _h7('TouristShirt_M', "Characters/Citizen_Base/Textures/Tourist_Shirt_Male_04", _D.tJobModelConflicts1),
    [CharacterConstants.MALE_TOP_ACCESSORY_TOURIST_SHIRT_05] = _D.CharacterConstantsMA21,
    [CharacterConstants.FEMALE_TOP_ACCESSORY_TOURIST_SHIRT_02] = _h7('TouristShirt_F', "Characters/Citizen_Base/Textures/Tourist_Shirt_Female_02", _D.tJobModelConflicts1),
    [CharacterConstants.FEMALE_TOP_ACCESSORY_TOURIST_SHIRT_03] = _h7('TouristShirt_F', "Characters/Citizen_Base/Textures/Tourist_Shirt_Female_03", _D.tJobModelConflicts1),
    [CharacterConstants.FEMALE_TOP_ACCESSORY_TOURIST_SHIRT_04] = _h7('TouristShirt_F', "Characters/Citizen_Base/Textures/Tourist_Shirt_Female_04", _D.tJobModelConflicts1),
    [CharacterConstants.FEMALE_TOP_ACCESSORY_TOURIST_SHIRT_05] = _h7('TouristShirt_F', "Characters/Citizen_Base/Textures/Tourist_Shirt_Female_05", _D.tJobModelConflicts1),
    [CharacterConstants.TOBIAN_TOP_ACCESSORY_COLLAR_01] = _h7('Collar01', "Characters/Citizen_Base/Textures/Collar01", _D.tJobModelConflicts1),
    [CharacterConstants.TOBIAN_TOP_ACCESSORY_VEST_01] = _h7('TobianVest01', "Characters/Citizen_Base/Textures/AC_UpBody01", _D.tJobModelConflicts1),
    [CharacterConstants.TOBIAN_TOP_ACCESSORY_VEST_01_BEIGE] = _h7('TobianVest01', "Characters/Citizen_Base/Textures/AC_UpBody02", _D.tJobModelConflicts1),
    [CharacterConstants.MALE_TOP_ACCESSORY_SEXYSHIRT_01] = _h7('M_RobeShirt01', "Characters/Citizen_Base/Textures/AC_UpBody03", _D.tJobModelConflicts11),
    [CharacterConstants.TOP_ACCESSORY_GAUNTLET_LEFT_01] = {
        sModel = 'Male01_Lf_ArmGauntlet',
        sTexture = "Characters/Citizen_Base/Textures/Arm_Gauntlet",
        tJobModelConflicts = {
            CharacterConstants.MINER,
            CharacterConstants.EMERGENCY,
        },
    },
    [CharacterConstants.TOP_ACCESSORY_GAUNTLET_RIGHT_01] = {
        sModel = 'Male01_Rt_ArmGauntlet1',
        sTexture = "Characters/Citizen_Base/Textures/Arm_Gauntlet",
        tJobModelConflicts = {
            CharacterConstants.MINER,
            CharacterConstants.EMERGENCY,
        },
    },
    [CharacterConstants.TOBIAN_TOP_ACCESSORY_ROBESHIRT_01] = _h7('TobianRobeShirt01', "Characters/Citizen_Base/Textures/AC_UpBody03", _D.tJobModelConflicts11),
    [CharacterConstants.TOBIAN_TOP_ACCESSORY_TOURIST_SHIRT_03] = {
        sModel = 'TobianTouristShirt',
        sTexture = "Characters/Citizen_Base/Textures/Tourist_Shirt_Male_03",
        tJobModelConflicts = {
            CharacterConstants.MINER,
            CharacterConstants.BUILDER,
            CharacterConstants.EMERGENCY,
            CharacterConstants.TECHNICIAN,
            CharacterConstants.BARTENDER,
            CharacterConstants.BOTANIST,
            CharacterConstants.SCIENTIST,
            CharacterConstants.DOCTOR,
        },
    },
    [CharacterConstants.TOBIAN_TOP_ACCESSORY_TOURIST_SHIRT_04] = _h7('TobianTouristShirt', "Characters/Citizen_Base/Textures/Tourist_Shirt_Male_04", _D.tJobModelConflicts16),
    [CharacterConstants.TOBIAN_TOP_ACCESSORY_TOURIST_SHIRT_05] = _h7('TobianTouristShirt', "Characters/Citizen_Base/Textures/Tourist_Shirt_Male_02", _D.tJobModelConflicts10),
    [CharacterConstants.MALE_TOP_ACCESSORY_TOURIST_SHIRT_02] = {
        sModel = 'TouristShirt_M',
        sTexture = "Characters/Citizen_Base/Textures/Tourist_Shirt_Male_02",
        tJobModelConflicts = {
            CharacterConstants.MINER,
            CharacterConstants.EMERGENCY,
            CharacterConstants.BARTENDER,
            CharacterConstants.TECHNICIAN,
            CharacterConstants.BUILDER,
            CharacterConstants.BOTANIST,
            CharacterConstants.SCIENTIST,
            CharacterConstants.DOCTOR,
        },
    },
    [CharacterConstants.MALE_TOP_ACCESSORY_TOURIST_SHIRT_03] = {
        sModel = 'TouristShirt_M',
        sTexture = "Characters/Citizen_Base/Textures/Tourist_Shirt_Male_03",
        tJobModelConflicts = {
            CharacterConstants.MINER,
            CharacterConstants.EMERGENCY,
            CharacterConstants.BUILDER,
            CharacterConstants.BARTENDER,
            CharacterConstants.TECHNICIAN,
            CharacterConstants.BOTANIST,
            CharacterConstants.SCIENTIST,
            CharacterConstants.DOCTOR,
        },
    },
    [CharacterConstants.MALE_TOP_ACCESSORY_FAT_TOURIST_SHIRT_02] = _h7('FatTouristShirt_M', "Characters/Citizen_Base/Textures/Tourist_Shirt_Male_02", _D.tJobModelConflicts10),
    [CharacterConstants.MALE_TOP_ACCESSORY_FAT_TOURIST_SHIRT_03] = _h7('FatTouristShirt_M', "Characters/Citizen_Base/Textures/Tourist_Shirt_Male_03", _D.tJobModelConflicts10),
    [CharacterConstants.NO_REPLACE] = {
    },
    [CharacterConstants.SHAMON_TOP_ACCESSORY_VEST_01] = _h7('ShamonVest01', "Characters/Citizen_Base/Textures/AC_UpBody01", _D.tJobModelConflicts1),
    [CharacterConstants.SHAMON_TOP_ACCESSORY_TOURIST_SHIRT_02] = {
        sModel = 'ShamonTouristShirt',
        sTexture = "Characters/Citizen_Base/Textures/Tourist_Shirt_Female_02",
        tJobModelConflicts = {
            CharacterConstants.MINER,
            CharacterConstants.EMERGENCY,
            CharacterConstants.BUILDER,
            CharacterConstants.TECHNICIAN,
            CharacterConstants.BARTENDER,
            CharacterConstants.BOTANIST,
            CharacterConstants.SCIENTIST,
            CharacterConstants.DOCTOR,
        },
    },
    [CharacterConstants.SHAMON_TOP_ACCESSORY_TOURIST_SHIRT_03] = {
        sModel = 'ShamonTouristShirt',
        sTexture = "Characters/Citizen_Base/Textures/Tourist_Shirt_Female_03",
        tJobModelConflicts = {
            CharacterConstants.MINER,
            CharacterConstants.BUILDER,
            CharacterConstants.EMERGENCY,
            CharacterConstants.BARTENDER,
            CharacterConstants.TECHNICIAN,
            CharacterConstants.BOTANIST,
            CharacterConstants.SCIENTIST,
            CharacterConstants.DOCTOR,
        },
    },
    [CharacterConstants.SHAMON_TOP_ACCESSORY_TOURIST_SHIRT_04] = _h7('ShamonTouristShirt', "Characters/Citizen_Base/Textures/Tourist_Shirt_Female_04", _D.tJobModelConflicts16),
    [CharacterConstants.SHAMON_TOP_ACCESSORY_TOURIST_SHIRT_05] = {
        sModel = 'ShamonTouristShirt',
        sTexture = "Characters/Citizen_Base/Textures/Tourist_Shirt_Female_05",
        tJobModelConflicts = {
            CharacterConstants.MINER,
            CharacterConstants.TECHNICIAN,
            CharacterConstants.EMERGENCY,
            CharacterConstants.BUILDER,
            CharacterConstants.BARTENDER,
            CharacterConstants.BOTANIST,
            CharacterConstants.SCIENTIST,
            CharacterConstants.DOCTOR,
        },
    },
    [CharacterConstants.SHAMON_TOP_ACCESSORY_SEXYSHIRT_01] = _h7('ShamonRobeShirt01', "Characters/Citizen_Base/Textures/AC_UpBody03", _D.tJobModelConflicts11),
    [CharacterConstants.SHAMON_TOP_ACCESSORY_VEST_01_BEIGE] = _h7('ShamonVest01', "Characters/Citizen_Base/Textures/AC_UpBody02", _D.tJobModelConflicts1),
    [CharacterConstants.TOP_ACCESSORY_HUMANVISOR_01] = _h7('Human_Visor01', "Characters/Citizen_Base/Textures/Visor01", _D.tJobModelConflicts12),
    [CharacterConstants.TOP_ACCESSORY_CATVISOR_01] = _h7('Cat_Visor01', "Characters/Citizen_Base/Textures/Visor01", _D.tJobModelConflicts12),
    [CharacterConstants.TOP_ACCESSORY_BIRDSHARKVISOR_01] = _h7('Birdshark_Visor01', "Characters/Citizen_Base/Textures/Visor01", _D.tJobModelConflicts12),
    [CharacterConstants.TOP_ACCESSORY_SHAMONVISOR_01] = _h7('Shamon_Visor01', "Characters/Citizen_Base/Textures/Visor01", _D.tJobModelConflicts12),
}
_D.CharacterConstantsTO9 = {
    tTopAccessories = {
    CharacterConstants.TOBIAN_TOP_ACCESSORY_VEST_01,
    CharacterConstants.TOBIAN_TOP_ACCESSORY_VEST_01_BEIGE,
    CharacterConstants.TOBIAN_TOP_ACCESSORY_ROBESHIRT_01,
    CharacterConstants.TOBIAN_TOP_ACCESSORY_TOURIST_SHIRT_03,
    CharacterConstants.TOBIAN_TOP_ACCESSORY_TOURIST_SHIRT_04,
    CharacterConstants.TOBIAN_TOP_ACCESSORY_TOURIST_SHIRT_05,
    },
    tBottomAccessories = {
    CharacterConstants.TOBIAN_BOTTOM_ACCESSORY_BELT_01,
    CharacterConstants.TOBIAN_BOTTOM_ACCESSORY_LEGPOUCH_01,
    CharacterConstants.TOBIAN_BOTTOM_ACCESSORY_TOURISTSHORTS_01,
    },
}
_D.tBottomAccessories17 = {
    CharacterConstants.FEMALE_BOTTOM_ACCESSORY_LEGPOUCH_01,
    CharacterConstants.FEMALE_BOTTOM_ACCESSORY_BELT_01,
    CharacterConstants.FEMALE_BOTTOM_ACCESSORY_TOURISTSHORTS_01,
}
_D.tBottomAccessories22 = {
    CharacterConstants.MALE_BOTTOM_ACCESSORY_LEGPOUCH_01,
    CharacterConstants.MALE_BOTTOM_ACCESSORY_BELT_01,
    CharacterConstants.MALE_BOTTOM_ACCESSORY_TOURISTSHORTS_01,
}
_D.tBottomAccessories23 = {
    CharacterConstants.MALE_BOTTOM_ACCESSORY_FAT_LEGPOUCH_01,
    CharacterConstants.MALE_BOTTOM_ACCESSORY_FAT_BELT_01,
    CharacterConstants.MALE_BOTTOM_ACCESSORY_FAT_TOURISTSHORTS_01,
}
CharacterConstants.ACCESSORY_SET_TYPE=
{
    [CharacterConstants.HUMAN_MALE] = {
        tTopAccessories = {
            CharacterConstants.MALE_TOP_ACCESSORY_VEST_01,
            CharacterConstants.MALE_TOP_ACCESSORY_VEST_01_BEIGE,
            CharacterConstants.MALE_TOP_ACCESSORY_SEXYSHIRT_01,
            CharacterConstants.MALE_TOP_ACCESSORY_BANDOLIER_01,
            CharacterConstants.MALE_TOP_ACCESSORY_BANDOLIER_02,
            CharacterConstants.MALE_TOP_ACCESSORY_TOURIST_SHIRT_02,
            CharacterConstants.MALE_TOP_ACCESSORY_TOURIST_SHIRT_03,
            CharacterConstants.MALE_TOP_ACCESSORY_TOURIST_SHIRT_04,
            CharacterConstants.MALE_TOP_ACCESSORY_TOURIST_SHIRT_05,
            CharacterConstants.TOP_ACCESSORY_GAUNTLET_LEFT_01,
            CharacterConstants.TOP_ACCESSORY_GAUNTLET_RIGHT_01,
            CharacterConstants.TOP_ACCESSORY_HUMANVISOR_01,
        },
        tBottomAccessories = _D.tBottomAccessories22,
    },
    [CharacterConstants.HUMAN_FEMALE] = {
        tTopAccessories = {
            CharacterConstants.FEMALE_TOP_ACCESSORY_VEST_01,
            CharacterConstants.FEMALE_TOP_ACCESSORY_VEST_01_BEIGE,
            CharacterConstants.FEMALE_TOP_ACCESSORY_BANDOLIER_01,
            CharacterConstants.FEMALE_TOP_ACCESSORY_BANDOLIER_02,
            CharacterConstants.FEMALE_TOP_ACCESSORY_TOURIST_SHIRT_02,
            CharacterConstants.FEMALE_TOP_ACCESSORY_TOURIST_SHIRT_03,
            CharacterConstants.FEMALE_TOP_ACCESSORY_TOURIST_SHIRT_04,
            CharacterConstants.FEMALE_TOP_ACCESSORY_TOURIST_SHIRT_05,
            CharacterConstants.TOP_ACCESSORY_GAUNTLET_LEFT_01,
            CharacterConstants.TOP_ACCESSORY_GAUNTLET_RIGHT_01,
            CharacterConstants.TOP_ACCESSORY_HUMANVISOR_01,
        },
        tBottomAccessories = _D.tBottomAccessories17,
    },
    [CharacterConstants.JELLY_FEMALE] = {
        tTopAccessories = {
            CharacterConstants.FEMALE_TOP_ACCESSORY_VEST_01,
            CharacterConstants.FEMALE_TOP_ACCESSORY_VEST_01_BEIGE,
            CharacterConstants.FEMALE_TOP_ACCESSORY_BANDOLIER_01,
            CharacterConstants.FEMALE_TOP_ACCESSORY_BANDOLIER_02,
            CharacterConstants.FEMALE_TOP_ACCESSORY_TOURIST_SHIRT_02,
            CharacterConstants.FEMALE_TOP_ACCESSORY_TOURIST_SHIRT_03,
            CharacterConstants.FEMALE_TOP_ACCESSORY_TOURIST_SHIRT_04,
            CharacterConstants.FEMALE_TOP_ACCESSORY_TOURIST_SHIRT_05,
            CharacterConstants.TOP_ACCESSORY_GAUNTLET_LEFT_01,
            CharacterConstants.TOP_ACCESSORY_GAUNTLET_RIGHT_01,
        },
        tBottomAccessories = _D.tBottomAccessories17,
    },
    [CharacterConstants.JELLY_FAT_FEMALE] = {
        tTopAccessories = {
            CharacterConstants.FEMALE_TOP_ACCESSORY_VEST_01,
            CharacterConstants.FEMALE_TOP_ACCESSORY_VEST_01_BEIGE,
            CharacterConstants.FEMALE_TOP_ACCESSORY_FAT_BANDOLIER_01,
            CharacterConstants.FEMALE_TOP_ACCESSORY_FAT_BANDOLIER_02,
            CharacterConstants.TOP_ACCESSORY_GAUNTLET_LEFT_01,
            CharacterConstants.TOP_ACCESSORY_GAUNTLET_RIGHT_01,
        },
        tBottomAccessories = _D.tBottomAccessories17,
    },
    [CharacterConstants.TOBIAN] = _D.CharacterConstantsTO9,
    [CharacterConstants.CAT_MALE] = {
        tTopAccessories = {
            CharacterConstants.MALE_TOP_ACCESSORY_VEST_01,
            CharacterConstants.MALE_TOP_ACCESSORY_VEST_01_BEIGE,
            CharacterConstants.MALE_TOP_ACCESSORY_BANDOLIER_01,
            CharacterConstants.MALE_TOP_ACCESSORY_BANDOLIER_02,
            CharacterConstants.MALE_TOP_ACCESSORY_TOURIST_SHIRT_02,
            CharacterConstants.MALE_TOP_ACCESSORY_TOURIST_SHIRT_03,
            CharacterConstants.MALE_TOP_ACCESSORY_TOURIST_SHIRT_04,
            CharacterConstants.MALE_TOP_ACCESSORY_TOURIST_SHIRT_05,
            CharacterConstants.TOP_ACCESSORY_GAUNTLET_LEFT_01,
            CharacterConstants.TOP_ACCESSORY_GAUNTLET_RIGHT_01,
            CharacterConstants.TOP_ACCESSORY_CATVISOR_01,
        },
        tBottomAccessories = _D.tBottomAccessories22,
    },
    [CharacterConstants.CAT_FEMALE] = {
        tTopAccessories = {
            CharacterConstants.FEMALE_TOP_ACCESSORY_VEST_01,
            CharacterConstants.FEMALE_TOP_ACCESSORY_VEST_01_BEIGE,
            CharacterConstants.FEMALE_TOP_ACCESSORY_BANDOLIER_01,
            CharacterConstants.FEMALE_TOP_ACCESSORY_BANDOLIER_02,
            CharacterConstants.FEMALE_TOP_ACCESSORY_TOURIST_SHIRT_02,
            CharacterConstants.FEMALE_TOP_ACCESSORY_TOURIST_SHIRT_03,
            CharacterConstants.FEMALE_TOP_ACCESSORY_TOURIST_SHIRT_04,
            CharacterConstants.FEMALE_TOP_ACCESSORY_TOURIST_SHIRT_05,
            CharacterConstants.TOP_ACCESSORY_GAUNTLET_LEFT_01,
            CharacterConstants.TOP_ACCESSORY_GAUNTLET_RIGHT_01,
            CharacterConstants.TOP_ACCESSORY_CATVISOR_01,
        },
        tBottomAccessories = _D.tBottomAccessories17,
    },
    [CharacterConstants.CAT_FAT_MALE] = {
        tTopAccessories = {
            CharacterConstants.MALE_TOP_ACCESSORY_VEST_01,
            CharacterConstants.MALE_TOP_ACCESSORY_VEST_01_BEIGE,
            CharacterConstants.MALE_TOP_ACCESSORY_FAT_BANDOLIER_01,
            CharacterConstants.MALE_TOP_ACCESSORY_FAT_BANDOLIER_02,
            CharacterConstants.MALE_TOP_ACCESSORY_FAT_TOURIST_SHIRT_02,
            CharacterConstants.MALE_TOP_ACCESSORY_FAT_TOURIST_SHIRT_03,
            CharacterConstants.MALE_TOP_ACCESSORY_FAT_TOURIST_SHIRT_04,
            CharacterConstants.MALE_TOP_ACCESSORY_FAT_TOURIST_SHIRT_05,
            CharacterConstants.TOP_ACCESSORY_GAUNTLET_LEFT_01,
            CharacterConstants.TOP_ACCESSORY_GAUNTLET_RIGHT_01,
            CharacterConstants.TOP_ACCESSORY_CATVISOR_01,
        },
        tBottomAccessories = _D.tBottomAccessories23,
    },
    [CharacterConstants.CAT_FAT_FEMALE] = {
        tTopAccessories = {
            CharacterConstants.FEMALE_TOP_ACCESSORY_VEST_01,
            CharacterConstants.FEMALE_TOP_ACCESSORY_VEST_01_BEIGE,
            CharacterConstants.FEMALE_TOP_ACCESSORY_FAT_BANDOLIER_01,
            CharacterConstants.FEMALE_TOP_ACCESSORY_FAT_BANDOLIER_02,
            CharacterConstants.TOP_ACCESSORY_GAUNTLET_LEFT_01,
            CharacterConstants.TOP_ACCESSORY_GAUNTLET_RIGHT_01,
            CharacterConstants.TOP_ACCESSORY_CATVISOR_01,
        },
        tBottomAccessories = {
            CharacterConstants.FEMALE_BOTTOM_ACCESSORY_FAT_LEGPOUCH_01,
            CharacterConstants.FEMALE_BOTTOM_ACCESSORY_FAT_BELT_01,
        },
    },
    [CharacterConstants.BIRDSHARK_MALE] = {
        tTopAccessories = {
            CharacterConstants.MALE_TOP_ACCESSORY_VEST_01,
            CharacterConstants.MALE_TOP_ACCESSORY_VEST_01_BEIGE,
            CharacterConstants.MALE_TOP_ACCESSORY_BANDOLIER_01,
            CharacterConstants.MALE_TOP_ACCESSORY_BANDOLIER_02,
            CharacterConstants.MALE_TOP_ACCESSORY_TOURIST_SHIRT_02,
            CharacterConstants.MALE_TOP_ACCESSORY_TOURIST_SHIRT_03,
            CharacterConstants.MALE_TOP_ACCESSORY_TOURIST_SHIRT_04,
            CharacterConstants.MALE_TOP_ACCESSORY_TOURIST_SHIRT_05,
            CharacterConstants.TOP_ACCESSORY_GAUNTLET_LEFT_01,
            CharacterConstants.TOP_ACCESSORY_GAUNTLET_RIGHT_01,
            CharacterConstants.TOP_ACCESSORY_BIRDSHARKVISOR_01,
        },
        tBottomAccessories = _D.tBottomAccessories22,
    },
    [CharacterConstants.BIRDSHARK_FEMALE] = {
        tTopAccessories = {
            CharacterConstants.FEMALE_TOP_ACCESSORY_VEST_01,
            CharacterConstants.FEMALE_TOP_ACCESSORY_VEST_01_BEIGE,
            CharacterConstants.FEMALE_TOP_ACCESSORY_BANDOLIER_01,
            CharacterConstants.FEMALE_TOP_ACCESSORY_BANDOLIER_02,
            CharacterConstants.FEMALE_TOP_ACCESSORY_TOURIST_SHIRT_02,
            CharacterConstants.FEMALE_TOP_ACCESSORY_TOURIST_SHIRT_03,
            CharacterConstants.FEMALE_TOP_ACCESSORY_TOURIST_SHIRT_04,
            CharacterConstants.FEMALE_TOP_ACCESSORY_TOURIST_SHIRT_05,
            CharacterConstants.TOP_ACCESSORY_GAUNTLET_LEFT_01,
            CharacterConstants.TOP_ACCESSORY_GAUNTLET_RIGHT_01,
            CharacterConstants.TOP_ACCESSORY_BIRDSHARKVISOR_01,
        },
        tBottomAccessories = {
            CharacterConstants.FEMALE_BOTTOM_ACCESSORY_LEGPOUCH_01,
            CharacterConstants.FEMALE_BOTTOM_ACCESSORY_BELT_01,
        },
    },
    [CharacterConstants.BIRDSHARK_FAT_MALE] = {
        tTopAccessories = {
            CharacterConstants.MALE_TOP_ACCESSORY_VEST_01,
            CharacterConstants.MALE_TOP_ACCESSORY_VEST_01_BEIGE,
            CharacterConstants.MALE_TOP_ACCESSORY_FAT_BANDOLIER_01,
            CharacterConstants.MALE_TOP_ACCESSORY_FAT_BANDOLIER_02,
            CharacterConstants.MALE_TOP_ACCESSORY_FAT_TOURIST_SHIRT_02,
            CharacterConstants.MALE_TOP_ACCESSORY_FAT_TOURIST_SHIRT_03,
            CharacterConstants.MALE_TOP_ACCESSORY_FAT_TOURIST_SHIRT_04,
            CharacterConstants.MALE_TOP_ACCESSORY_FAT_TOURIST_SHIRT_05,
            CharacterConstants.TOP_ACCESSORY_GAUNTLET_LEFT_01,
            CharacterConstants.TOP_ACCESSORY_GAUNTLET_RIGHT_01,
            CharacterConstants.TOP_ACCESSORY_BIRDSHARKVISOR_01,
        },
        tBottomAccessories = _D.tBottomAccessories23,
    },
    [CharacterConstants.BIRDSHARK_FAT_FEMALE] = {
        tTopAccessories = {
            CharacterConstants.FEMALE_TOP_ACCESSORY_VEST_01,
            CharacterConstants.FEMALE_TOP_ACCESSORY_VEST_01_BEIGE,
            CharacterConstants.FEMALE_TOP_ACCESSORY_FAT_BANDOLIER_01,
            CharacterConstants.FEMALE_TOP_ACCESSORY_FAT_BANDOLIER_02,
            CharacterConstants.TOP_ACCESSORY_GAUNTLET_LEFT_01,
            CharacterConstants.TOP_ACCESSORY_GAUNTLET_RIGHT_01,
            CharacterConstants.TOP_ACCESSORY_BIRDSHARKVISOR_01,
        },
        tBottomAccessories = {
            CharacterConstants.FEMALE_BOTTOM_ACCESSORY_LEGPOUCH_01,
            CharacterConstants.FEMALE_BOTTOM_ACCESSORY_BELT_01,
        },
    },
    [CharacterConstants.CHICKEN_MALE] = _D.CharacterConstantsTO9,
    [CharacterConstants.CHICKEN_FEMALE] = _D.CharacterConstantsTO9,
    [CharacterConstants.SHAMON_MALE] = {
        tTopAccessories = {
            CharacterConstants.SHAMON_TOP_ACCESSORY_VEST_01,
            CharacterConstants.SHAMON_TOP_ACCESSORY_VEST_01_BEIGE,
            CharacterConstants.SHAMON_TOP_ACCESSORY_SEXYSHIRT_01,
            CharacterConstants.MALE_TOP_ACCESSORY_BANDOLIER_01,
            CharacterConstants.SHAMON_TOP_ACCESSORY_TOURIST_SHIRT_02,
            CharacterConstants.SHAMON_TOP_ACCESSORY_TOURIST_SHIRT_03,
            CharacterConstants.SHAMON_TOP_ACCESSORY_TOURIST_SHIRT_04,
            CharacterConstants.SHAMON_TOP_ACCESSORY_TOURIST_SHIRT_05,
            CharacterConstants.TOP_ACCESSORY_GAUNTLET_LEFT_01,
            CharacterConstants.TOP_ACCESSORY_GAUNTLET_RIGHT_01,
            CharacterConstants.TOP_ACCESSORY_SHAMONVISOR_01,
        },
        tBottomAccessories = {
            CharacterConstants.SHAMON_BOTTOM_ACCESSORY_LEGPOUCH_01,
            CharacterConstants.SHAMON_BOTTOM_ACCESSORY_BELT_01,
        },
    },
    [CharacterConstants.MURDERFACE_MALE] = {
        tTopAccessories = {
            CharacterConstants.TOBIAN_TOP_ACCESSORY_VEST_01,
            CharacterConstants.TOBIAN_TOP_ACCESSORY_VEST_01_BEIGE,
            CharacterConstants.TOBIAN_TOP_ACCESSORY_ROBESHIRT_01,
        },
        tBottomAccessories = {
            CharacterConstants.TOBIAN_BOTTOM_ACCESSORY_BELT_01,
            CharacterConstants.TOBIAN_BOTTOM_ACCESSORY_LEGPOUCH_01,
            CharacterConstants.TOBIAN_BOTTOM_ACCESSORY_TOURISTSHORTS_01,
        },
    },
    [CharacterConstants.HUMAN_FAT_MALE] = {
        tTopAccessories = {
            CharacterConstants.MALE_TOP_ACCESSORY_VEST_01,
            CharacterConstants.MALE_TOP_ACCESSORY_VEST_01_BEIGE,
            CharacterConstants.MALE_TOP_ACCESSORY_FAT_BANDOLIER_01,
            CharacterConstants.MALE_TOP_ACCESSORY_FAT_BANDOLIER_02,
            CharacterConstants.MALE_TOP_ACCESSORY_FAT_TOURIST_SHIRT_02,
            CharacterConstants.MALE_TOP_ACCESSORY_FAT_TOURIST_SHIRT_03,
            CharacterConstants.MALE_TOP_ACCESSORY_FAT_TOURIST_SHIRT_04,
            CharacterConstants.MALE_TOP_ACCESSORY_FAT_TOURIST_SHIRT_05,
            CharacterConstants.TOP_ACCESSORY_GAUNTLET_LEFT_01,
            CharacterConstants.TOP_ACCESSORY_GAUNTLET_RIGHT_01,
            CharacterConstants.TOP_ACCESSORY_HUMANVISOR_01,
        },
        tBottomAccessories = _D.tBottomAccessories23,
    },
    [CharacterConstants.HUMAN_FAT_FEMALE] = {
        tTopAccessories = {
            CharacterConstants.FEMALE_TOP_ACCESSORY_VEST_01,
            CharacterConstants.FEMALE_TOP_ACCESSORY_VEST_01_BEIGE,
            CharacterConstants.FEMALE_TOP_ACCESSORY_FAT_BANDOLIER_01,
            CharacterConstants.FEMALE_TOP_ACCESSORY_FAT_BANDOLIER_02,
            CharacterConstants.TOP_ACCESSORY_GAUNTLET_LEFT_01,
            CharacterConstants.TOP_ACCESSORY_GAUNTLET_RIGHT_01,
            CharacterConstants.TOP_ACCESSORY_HUMANVISOR_01,
        },
        tBottomAccessories = {
            CharacterConstants.FEMALE_BOTTOM_ACCESSORY_FAT_LEGPOUCH_01,
            CharacterConstants.FEMALE_BOTTOM_ACCESSORY_FAT_BELT_01,
            CharacterConstants.FEMALE_BOTTOM_ACCESSORY_FAT_TOURISTSHORTS_01,
        },
    },
}
_D.CharacterConstantsRA14 = _h8({ sModel = 'Raider_Suit02', sTexture = 'Characters/Citizen_Base/Textures/Raider01' }, { sModel = 'Raider_Suit02', sTexture = 'Characters/Citizen_Base/Textures/Raider01' }, { sModel = 'Raider_Suit02', sTexture = 'Characters/Citizen_Base/Textures/Raider01' })
_D.CharacterConstantsEM15 = _h8({ sModel = 'Emergency_Suit02', sTexture = 'Characters/Citizen_Base/Textures/Emergency01' }, { sModel = 'Emergency_Suit02', sTexture = 'Characters/Citizen_Base/Textures/Emergency02' }, { sModel = 'Emergency_Suit02', sTexture = 'Characters/Citizen_Base/Textures/Emergency03' })
CharacterConstants.JOB_OUTFIT_TYPE=
{
    [CharacterConstants.DOCTOR_BASE_NORMAL] = { sModel = 'Doctor_Suit02', sTexture = 'Characters/Citizen_Base/Textures/Scientist01' },
    [CharacterConstants.DOCTOR_BASE_FAT] = { sModel = 'Doctor_FatSuit02', sTexture = 'Characters/Citizen_Base/Textures/Scientist01' },
    [CharacterConstants.SCIENTIST_BASE_NORMAL] = { sModel = 'Doctor_Suit02', sTexture = 'Characters/Citizen_Base/Textures/Scientist01' },
    [CharacterConstants.SCIENTIST_BASE_FAT] = { sModel = 'Doctor_FatSuit02', sTexture = 'Characters/Citizen_Base/Textures/Scientist01' },
    [CharacterConstants.BUILDER_BASE_NORMAL] = { sModel = 'Builder_Suit02', sTexture = 'Characters/Citizen_Base/Textures/Builder01' },
    [CharacterConstants.BUILDER_BASE_FAT] = { sModel = 'Builder_FatSuit02', sTexture = 'Characters/Citizen_Base/Textures/Builder01' },
    [CharacterConstants.BUILDER_TOBIAN_NO_HELMET] = { sModel = 'Builder_Suit02', sTexture = 'Characters/Citizen_Base/Textures/Builder01' },
    [CharacterConstants.BUILDER_BASE_NORMAL_HOOF_BOOT] = { sModel = 'Builder_Suit03', sTexture = 'Characters/Citizen_Base/Textures/Builder01' },
    [CharacterConstants.TECHNICIAN_BASE_NORMAL] = { sModel = 'Tech_Suit02', sTexture = 'Characters/Citizen_Base/Textures/Technician01' },
    [CharacterConstants.TECHNICIAN_BASE_FAT] = { sModel = 'Tech_FatSuit02', sTexture = 'Characters/Citizen_Base/Textures/Technician01' },
    [CharacterConstants.TECHNICIAN_TOBIAN] = { sModel = 'Tech_Suit02', sTexture = 'Characters/Citizen_Base/Textures/Technician01' },
    [CharacterConstants.MINER_BASE_NORMAL] = { sModel = 'Miner_Suit02', sTexture = 'Characters/Citizen_Base/Textures/Miner01' },
    [CharacterConstants.MINER_BASE_FAT] = { sModel = 'Miner_FatSuit02', sTexture = 'Characters/Citizen_Base/Textures/Miner01' },
    [CharacterConstants.MINER_TOBIAN] = { sModel = 'Miner_Suit02', sTexture = 'Characters/Citizen_Base/Textures/Miner01' },
    [CharacterConstants.MINER_BASE_NORMAL_HOOF_BOOT] = { sModel = 'Miner_Suit03', sTexture = 'Characters/Citizen_Base/Textures/Miner01' },
    [CharacterConstants.EMERGENCY_BASE_NORMAL] = _D.CharacterConstantsEM15,
    [CharacterConstants.EMERGENCY_BASE_FAT] = _h8({ sModel = 'Emergency_FatSuit02', sTexture = 'Characters/Citizen_Base/Textures/Emergency01' }, { sModel = 'Emergency_FatSuit02', sTexture = 'Characters/Citizen_Base/Textures/Emergency02' }, { sModel = 'Emergency_FatSuit02', sTexture = 'Characters/Citizen_Base/Textures/Emergency03' }),
    [CharacterConstants.EMERGENCY_TOBIAN] = _D.CharacterConstantsEM15,
    [CharacterConstants.EMERGENCY_BASE_NORMAL_HOOF_BOOT] = _h8({ sModel = 'Emergency_Suit03', sTexture = 'Characters/Citizen_Base/Textures/Emergency01' }, { sModel = 'Emergency_Suit03', sTexture = 'Characters/Citizen_Base/Textures/Emergency02' }, { sModel = 'Emergency_Suit03', sTexture = 'Characters/Citizen_Base/Textures/Emergency03' }),
    [CharacterConstants.RAIDER_BASE_NORMAL] = _D.CharacterConstantsRA14,
    [CharacterConstants.RAIDER_BASE_FAT] = _h8({ sModel = 'Raider_FatSuit02', sTexture = 'Characters/Citizen_Base/Textures/Raider01' }, { sModel = 'Raider_FatSuit02', sTexture = 'Characters/Citizen_Base/Textures/Raider01' }, { sModel = 'Raider_FatSuit02', sTexture = 'Characters/Citizen_Base/Textures/Raider01' }),
    [CharacterConstants.RAIDER_TOBIAN_NO_HELMET] = _D.CharacterConstantsRA14,
    [CharacterConstants.BARTENDER_BASE_NORMAL] = { sModel = 'Bartender_Suit02_M', sTexture = "Characters/Citizen_Base/Textures/Tourist_Shirt_Male_01", },
    [CharacterConstants.BARTENDER_BASE_FAT] = { sModel = 'Bartender_FatSuit02_M', sTexture = "Characters/Citizen_Base/Textures/Tourist_Shirt_Male_01", },
    [CharacterConstants.BARTENDER_BASE_NORMAL_FEMALE] = { sModel = 'Bartender_Suit02_F', sTexture = "Characters/Citizen_Base/Textures/Tourist_Shirt_Female_01", },
    [CharacterConstants.BARTENDER_BASE_FAT_FEMALE] = { sModel = 'Bartender_FatSuit02_F', sTexture = "Characters/Citizen_Base/Textures/Tourist_Shirt_Female_01", },
    [CharacterConstants.BARTENDER_TOBIAN] = { sModel = 'Bartender_Suit02', sTexture = "Characters/Citizen_Base/Textures/Tourist_Shirt_Male_01", },
    [CharacterConstants.BARTENDER_SHAMON] = { sModel = 'Bartender_Suit03', sTexture = "Characters/Citizen_Base/Textures/Tourist_Shirt_Female_01", },
}
CharacterConstants.JOB_HELMET_PREFIX = '_Character_Group_Group_Flipbook_Group_Helmet_FBGroup_Helmets_Head_Helmets_'
CharacterConstants.JOB_HELMET_TYPE=
{
    [CharacterConstants.BUILDER_BASE_HELMET] = { sModel = 'Builder_Helmet01', sTexture = 'Characters/Citizen_Base/Textures/Builder01' },
    [CharacterConstants.MINER_BASE_HELMET] = { sModel = 'Miner_Helmet01', sTexture = 'Characters/Citizen_Base/Textures/Miner01' },
    [CharacterConstants.MINER_TOBIAN_HELMET] = { sModel = 'Miner_TobianHelmet01', sTexture = 'Characters/Citizen_Base/Textures/Miner01' },
    [CharacterConstants.EMERGENCY_BASE_HELMET] = _h8({ sModel = 'Emergency_Helmet01', sTexture = 'Characters/Citizen_Base/Textures/Emergency01' }, { sModel = 'Emergency_Helmet01', sTexture = 'Characters/Citizen_Base/Textures/Emergency02' }, { sModel = 'Emergency_Helmet02', sTexture = 'Characters/Citizen_Base/Textures/Emergency03' }),
    [CharacterConstants.EMERGENCY_TOBIAN_HELMET] = _h8({ sModel = 'Emergency_TobianHelmet01', sTexture = 'Characters/Citizen_Base/Textures/Emergency01' }, { sModel = 'Emergency_TobianHelmet01', sTexture = 'Characters/Citizen_Base/Textures/Emergency02' }, { sModel = 'Emergency_TobianHelmet02', sTexture = 'Characters/Citizen_Base/Textures/Emergency03' }),
    [CharacterConstants.RAIDER_BASE_HELMET] = { sModel = 'Raider_Helmet01', sTexture = 'Characters/Citizen_Base/Textures/Raider01' },
}
function CharacterConstants.getDefaultJobOutfit(nJob,bFat)
    if nJob == CharacterConstants.BUILDER then
        return (bFat and CharacterConstants.BUILDER_BASE_FAT) or CharacterConstants.BUILDER_BASE_NORMAL
    elseif nJob == CharacterConstants.TECHNICIAN then
        return (bFat and CharacterConstants.TECHNICIAN_BASE_FAT) or CharacterConstants.TECHNICIAN_BASE_NORMAL
    elseif nJob == CharacterConstants.MINER then
        return (bFat and CharacterConstants.MINER_BASE_FAT) or CharacterConstants.MINER_BASE_NORMAL
    elseif nJob == CharacterConstants.EMERGENCY then
        return (bFat and CharacterConstants.EMERGENCY_BASE_FAT) or CharacterConstants.EMERGENCY_BASE_NORMAL
    elseif nJob == CharacterConstants.RAIDER then
        return (bFat and CharacterConstants.RAIDER_BASE_FAT) or CharacterConstants.RAIDER_BASE_NORMAL
    elseif nJob == CharacterConstants.BARTENDER then
        return (bFat and CharacterConstants.BARTENDER_BASE_FAT) or CharacterConstants.BARTENDER_BASE_NORMAL
    elseif nJob == CharacterConstants.BOTANIST then
        return CharacterConstants.BOTANIST_BASE_NORMAL
    elseif nJob == CharacterConstants.SCIENTIST then
        return (bFat and CharacterConstants.SCIENTIST_BASE_FAT) or CharacterConstants.SCIENTIST_BASE_NORMAL
    elseif nJob == CharacterConstants.DOCTOR then
        return (bFat and CharacterConstants.DOCTOR_BASE_FAT) or CharacterConstants.DOCTOR_BASE_NORMAL
    else
        assert(false)
    end
end
return CharacterConstants
