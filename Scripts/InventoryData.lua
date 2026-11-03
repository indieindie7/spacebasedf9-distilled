local function _h1(a0,a1,a2,a3,a4,a5) return {sName=a0,sDesc=a1,bStuff=a2,Job=a3,tPossibleTags=a4,bJobTool=a5} end
local function _h2(a0,a1,a2,a3,a4,a5,a6) return {bStuff=a0,bDisplayable=a1,sPortraitSprite=a2,sSuffix=a3,sDesc=a4,tPossibleTags=a5,tForcedTags=a6} end
local function _h3(a0,a1,a2,a3,a4,a5,a6) return {bStuff=a0,bDisplayable=a1,sPortraitSprite=a2,sTintSprite=a3,sSuffix=a4,sDesc=a5,tPossibleTags=a6} end
local Character=require('CharacterConstants')
local InventoryData = {}
InventoryData.MINE_PICKUP_NAME = 'Rock'
InventoryData.DEFAULT_SPRITE_SHEET = 'Environments/Objects'
InventoryData.DEFAULT_AFFINITY_DECAY = .016
InventoryData.tTags=
{
    Color={
        Red=    { lc='TAGSXX001TEXT', color={220/255,20/255,60/255}, },
        Orange= { lc='TAGSXX002TEXT', color={255/255,153/255,18/255}, },
        Yellow= { lc='TAGSXX003TEXT', color={255/255,255/255,0/255}, },
        Green=  { lc='TAGSXX004TEXT', color={0,205/255,0}, },
        Cyan=   { lc='TAGSXX005TEXT', color={0,238/255,238/255}, },
        Blue=   { lc='TAGSXX006TEXT', color={24/255,116/255,205/255}, },
        Purple= { lc='TAGSXX007TEXT', color={186/255,85/255,211/255}, },
        Magenta={ lc='TAGSXX008TEXT', color={1,0,1}, },
        Black=  { lc='TAGSXX009TEXT', color={0,0,0}, },
        White=  { lc='TAGSXX010TEXT', color={1,1,1}, },
        Grey=   { lc='TAGSXX011TEXT', color={.5,.5,.5}, },
        Brown=  { lc='TAGSXX012TEXT', color={139/255,69/255,19/255}, },
		Beige=  { lc='TAGSXX032TEXT', color={216/255,176/255,150/255}, },
        Gold=   { lc='TAGSXX033TEXT', color={255/255,200/255,10/255}, },
    },
    Material={
        Stone={ lc='TAGSXX013TEXT', },
        Steel={ lc='TAGSXX014TEXT', },
        Wood={ lc='TAGSXX015TEXT', },
        Rubber={ lc='TAGSXX029TEXT', },
        Velvet={ lc='TAGSXX030TEXT', },
    },
    Texture={
        Fuzzy={ lc='TAGSXX016TEXT', },
        Bumpy={ lc='TAGSXX017TEXT', },
        Sticky={ lc='TAGSXX018TEXT', },
        Spiky={ lc='TAGSXX019TEXT', },
        Smooth={ lc='TAGSXX031TEXT', },
    },
    Shape={
        Round={ lc='TAGSXX020TEXT', },
        Flat={ lc='TAGSXX021TEXT', },
        Square={ lc='TAGSXX022TEXT', },
        Conical={ lc='TAGSXX023TEXT', },
    },
    Style={
        Elegant={ lc='TAGSXX024TEXT', },
        Bizarre={ lc='TAGSXX025TEXT', },
        Gaudy={ lc='TAGSXX026TEXT', },
        Punk={ lc='TAGSXX027TEXT', },
        Hip={ lc='TAGSXX028TEXT', },
    },
}
InventoryData.sDefaultPickup = 'TransientCrate'
InventoryData.nDefaultMaxStacks = 20
InventoryData.tTemplates=
{
    FryingPan=
    {
        bHeldOnly=true,
        bDisappearOnDrop=true,
        Pickup='FryingPan',
        sName='PROPSX035TEXT',
        sDesc='PROPSX036TEXT',
    },
    FoodBar=
    {
        bHeldOnly=true,
        bDisappearOnDrop=true,
        Pickup='FoodBar',
        sName='PROPSX035TEXT',
        sDesc='PROPSX036TEXT',
    },
    CookedMeal=
    {
        bHeldOnly=true,
        bDisappearOnDrop=true,
        Pickup='CookedMeal',
        sName='PROPSX044TEXT',
        sDesc='PROPSX045TEXT',
    },
    Rock=
    {
        sName='PROPSX023TEXT',
        sDesc='PROPSX024TEXT',
        bHeldOnly=true,
        Pickup='Rock',
        Job=Character.MINER,
        bStackable=true,
        nMaxStacks=6,
        bSatisfier=true,
		Texture='Bumpy',
		Color='Brown',
		Material='Stone',
    },
    Corpse=
    {
        bHeldOnly=true,
        Pickup='Corpse',
        Job=Character.DOCTOR,
        bSatisfier=true,
        sName='PROPSX082TEXT',
        sDesc='PROPSX083TEXT',
		Color='Blue',
    },
    ResearchDatacube=
    {
        sName='PROPSX070TEXT',
        sDesc='PROPSX071TEXT',
        Pickup='TransientCrate',
        bHeldOnly=true,
        bDisplayable=true,
        sPortraitSprite = 'Env_Datacube',
        Job=Character.SCIENTIST,
        bSatisfier=true,
        nPortraitScl=1.2,
        nPortraitOffX=-100,
        nPortraitOffY=-200,
    },
    FoodCrate=
    {
        sName='PROPSX035TEXT',
        sDesc='PROPSX036TEXT',
        bContainer=true,
        bHeldOnly=true,
        Job=Character.BARTENDER,
        Pickup='TransientCrate',
		Shape='Square',
		Material='Steel',
    },
    Corn=
    {
        bStackable=true,
        sName='FOODSX001TEXT',
        Color='Yellow',
		Texture='Bumpy',
    },
    Pod=
    {
        bStackable=true,
        sName='FOODSX002TEXT',
        Shape='Round',
        Color='Brown',
		Texture='Sticky',
    },
    Glowfruit=
    {
        bStackable=true,
        sName='FOODSX003TEXT',
        Color='Cyan',
		Texture='Fuzzy',
    },
    CandyCane=
    {
        sName='FOODSX004TEXT',
        bStackable=true,
        Style='Gaudy',
    },
	ArmorLevel0=
	{
        sName='INVOBJ019TEXT',
        sDesc='INVOBJ020TEXT',
        Job=Character.EMERGENCY,
        sOutfit='Level1',
        bDisappearOnDrop=true,
        nDodgeChance=.1,
        nDamageReduction=0.15,
        bJobTool=true,
	},
	ArmorLevel1=
	{
        sName='INVOBJ018TEXT',
        sDesc='INVOBJ021TEXT',
        Job=Character.EMERGENCY,
        sOutfit='Level1',
        bDisappearOnDrop=true,
        nDodgeChance=.15,
        nDamageReduction=0.35,
        bJobTool=true,
	},
	ArmorLevel2=
	{
        sName='INVOBJ015TEXT',
        sDesc='INVOBJ016TEXT',
        Job=Character.EMERGENCY,
        sOutfit='Level2',
        bDisappearOnDrop=true,
        nDodgeChance=.2,
        nDamageReduction=0.5,
        bJobTool=true,
	},
	ArmorLevel3=
	{
        sName='INVOBJ014TEXT',
        sDesc='INVOBJ017TEXT',
        bStuff=true,
        Job=Character.EMERGENCY,
        sOutfit='Level3',
        nDodgeChance=.25,
        nDamageReduction=0.65,
        bJobTool=true,
	},
	Pistol=
	{
        sName='INVOBJ022TEXT',
        sDesc='INVOBJ023TEXT',
        Job=Character.EMERGENCY,
        bJobTool=true,
        sStance = 'pistol',
        bDisappearOnDrop=true,
        nDamage = 15,
        nRange=18,
        nDamageType = Character.DAMAGE_TYPE.Laser,
	},
	KillbotRifle=
	{
        sName='INVOBJ024TEXT',
        sDesc='INVOBJ025TEXT',
        bDisappearOnDrop=true,
        nDamage = 20,
        nRange=18,
        nDamageType = Character.DAMAGE_TYPE.Laser,
	},
	LaserRifle=
	{
        sName='INVOBJ026TEXT',
        sDesc='INVOBJ027TEXT',
        Job=Character.EMERGENCY,
        bJobTool=true,
        sStance = 'rifle',
        bDisappearOnDrop=true,
        nDamage = 30,
        nRange=18,
        nDamageType = Character.DAMAGE_TYPE.Laser,
	},
	Stunner=
	{
        sName='INVOBJ028TEXT',
        sDesc='INVOBJ054TEXT',
        bDisappearOnDrop=true,
        Job=Character.EMERGENCY,
        bJobTool=true,
        sStance = 'stunner',
        nDamage = 15,
        nRange=3,
        nDamageType = Character.DAMAGE_TYPE.Stunner,
	},
	SuperStunner=
	{
        sName='INVOBJ028TEXT',
        sDesc='INVOBJ055TEXT',
        bStuff=true,
        Job=Character.EMERGENCY,
        tPossibleTags={'Color','Style','Texture'},
        bJobTool=true,
        sStance = 'stunner',
        nDamage = 30,
        nRange=6,
        nDamageType = Character.DAMAGE_TYPE.Stunner,
	},
	PlasmaRifle=
	{
        sName='INVOBJ030TEXT',
        sDesc='INVOBJ056TEXT',
        bStuff=true,
        Job=Character.EMERGENCY,
        tPossibleTags={'Color','Style','Texture'},
        bJobTool=true,
        sStance = 'rifle',
        nDamage = 45,
        nRange=18,
        nDamageType = Character.DAMAGE_TYPE.Laser,
	},
    SuperMaintainer= _h1('INVOBJ031TEXT', 'INVOBJ057TEXT', true, Character.TECHNICIAN, {'Color','Style','Texture','Shape'}, true),
    SuperBuilder= _h1('INVOBJ032TEXT', 'INVOBJ058TEXT', true, Character.BUILDER, {'Color','Style','Texture','Shape'}, true),
    EfficientMiner= _h1('INVOBJ033TEXT', 'INVOBJ059TEXT', true, Character.MINER, {'Color','Style','Texture','Shape'}, true),
    SuperGreenThumb= _h1('INVOBJ034TEXT', 'INVOBJ060TEXT', true, Character.BOTANIST, {'Color','Style','Texture','Shape'}, true),
    SuperDoctorTool= _h1('INVOBJ035TEXT', 'INVOBJ061TEXT', true, Character.DOCTOR, {'Color','Style','Texture','Shape'}, true),
    AlarmClock= _h2(true, true, 'StuffAlarmClock', 'INVOBJ041TEXT', 'INVOBJ062TEXT', {'Style','Texture','Material'}, {Color='Red',Shape='Square'}),
    Baseball= _h2(true, true, 'StuffBaseball', 'INVOBJ042TEXT', 'INVOBJ063TEXT', {'Style','Texture','Material'}, {Color='White',Shape='Round'}),
    Basketball= _h2(true, true, 'StuffBasketball', 'INVOBJ043TEXT', 'INVOBJ064TEXT', {'Style','Texture','Material'}, {Color='Orange',Shape='Round'}),
    CandyBucket= _h2(true, true, 'StuffCandyBucket', 'INVOBJ044TEXT', 'INVOBJ065TEXT', {'Style','Texture','Material'}, {Color='Orange',Shape='Round'}),
	CowSkull= _h2(true, true, 'StuffCowSkull', 'INVOBJ012TEXT', 'INVOBJ066TEXT', {'Style','Texture','Material'}, {Color='White'}),
	DeadGlobe= _h2(true, true, 'StuffDeadEarthGlobe', 'INVOBJ037TEXT', 'INVOBJ067TEXT', {'Style','Texture','Material'}, {Color='Brown',Shape='Round'}),
	Ducky= _h2(true, true, 'StuffDucky', 'INVOBJ009TEXT', 'INVOBJ069TEXT', {'Style','Texture','Material'}, {Color='Yellow'}),
	Globe= _h2(true, true, 'StuffEarthGlobe', 'INVOBJ046TEXT', 'INVOBJ068TEXT', {'Style','Texture','Material'}, {Color='Green',Shape='Round'}),
	GardenGnome=
	{
		bStuff=true,
        bDisplayable=true,
        sPortraitSprite='StuffGnome',
        sTintSprite='StuffGnome_tint',
        sSuffix='INVOBJ038TEXT',
        sDesc='INVOBJ070TEXT',
        tPossibleTags={'Color','Style','Texture','Material'},
		tForcedTags={Shape='Conical'},
	},
	HumanSkull= _h2(true, true, 'StuffHumanSkull', 'INVOBJ012TEXT', 'INVOBJ071TEXT', {'Style','Texture','Material'}, {Color='Beige'}),
	Kitty= _h3(true, true, 'StuffKitty', 'StuffKitty_tint', 'INVOBJ003TEXT', 'INVOBJ072TEXT', {'Color','Style','Texture','Material'}),
	LavaLamp= _h2(true, true, 'StuffLavalamp', 'INVOBJ039TEXT', 'INVOBJ073TEXT', {'Style','Texture','Material'}, {Color='Magenta',}),
	Cactus= _h2(true, true, 'StuffLittleCactus', 'INVOBJ040TEXT', 'INVOBJ074TEXT', {'Style','Material'}, {Color='Green',Texture='Spiky'}),
	MoaiHead= _h2(true, true, 'StuffMoaiHead', 'INVOBJ047TEXT', 'INVOBJ075TEXT', {'Style','Texture','Material'}, {Color='Grey',}),
	ToySpacebus= _h2(true, true, 'StuffModelSpacebus', 'INVOBJ048TEXT', 'INVOBJ076TEXT', {'Style','Texture','Material'}, {Color='Grey',}),
    Mug= _h3(true, true, 'StuffMug', 'StuffMug_tint', 'INVOBJ002TEXT', 'INVOBJ077TEXT', {'Color','Style','Texture','Material'}),
	MusicBox=
	{
		bStuff=true,
        bDisplayable=true,
        sPortraitSprite='StuffMusicBox',
        sSuffix='INVOBJ049TEXT',
        sDesc='INVOBJ078TEXT',
        tPossibleTags={'Style','Texture','Material'},
	},
	OldComputer= _h2(true, true, 'StuffOldComputer', 'INVOBJ010TEXT', 'INVOBJ079TEXT', {'Style','Texture','Material'}, {Color='Beige',}),
	PictureFrame=
	{
		bStuff=true,
        bDisplayable=true,
		tPortraitSprites={'StuffPictureFrame01','StuffPictureFrame02','StuffPictureFrame03'},
        sSuffix='INVOBJ050TEXT',
        sDesc='INVOBJ080TEXT',
        tPossibleTags={'Style','Material'},
		tForcedTags={Shape='Flat',},
	},
	PocketWatch= _h2(true, true, 'StuffPocketWatch', 'INVOBJ011TEXT', 'INVOBJ081TEXT', {'Style','Texture','Material'}, {Color='Gold',Shape='Round',}),
	PuzzleCube= _h2(true, true, 'StuffPuzzleCube', 'INVOBJ007TEXT', 'INVOBJ082TEXT', {'Style','Texture','Material'}, {Color='Gold',Shape='Square',}),
	Radio= _h2(true, true, 'StuffRadio', 'INVOBJ004TEXT', 'INVOBJ083TEXT', {'Style','Texture','Material'}, {Color='Brown'}),
	TeddyBear= _h3(true, true, 'StuffTeddyBear', 'StuffTeddyBear_tint', 'INVOBJ005TEXT', 'INVOBJ084TEXT', {'Color','Style','Texture','Material'}),
	TentacleMonster= _h2(true, true, 'StuffTentacleMonster', 'INVOBJ006TEXT', 'INVOBJ085TEXT', {'Style','Texture','Material'}, {Color='Blue'}),
    ToyBall= _h3(true, true, 'StuffToyBall', 'StuffToyBall_tint', 'INVOBJ001TEXT', 'INVOBJ086TEXT', {'Color','Style','Texture','Material'}),
    ParasiteActionFigure=
    {
        bStuff=true,
        bDisplayable=true,
        sPortraitSprite='StuffToyParasite',
        sSuffix='INVOBJ051TEXT',
        sDesc='INVOBJ087TEXT',
        tPossibleTags={'Style','Texture','Material'},
    },
    LadyActionFigure= _h2(true, true, 'StuffToySpacelady', 'INVOBJ052TEXT', 'INVOBJ088TEXT', {'Style','Texture','Material'}, {Color='Purple'}),
    GuyActionFigure=
    {
        bStuff=true,
        bDisplayable=true,
        sPortraitSprite='StuffToySpaceman',
        sSuffix='INVOBJ052TEXT',
        sDesc='INVOBJ089TEXT',
        tPossibleTags={'Style','Texture','Material'},
    },
    WizardActionFigure= _h2(true, true, 'StuffToyWizard', 'INVOBJ053TEXT', 'INVOBJ091TEXT', {'Style','Texture','Material'}, {Color='Grey'}),
	Fossil= _h2(true, true, 'StuffTrilobiteFossil', 'INVOBJ013TEXT', 'INVOBJ090TEXT', {'Style','Texture','Material'}, {Color='Beige'}),
}
function InventoryData.recalcStuffNames()
    InventoryData.tStuffNames = {}
    for k,v in pairs(InventoryData.tTemplates) do
        if v.bStuff then
            table.insert(InventoryData.tStuffNames,k)
        end
    end
end
InventoryData.recalcStuffNames()
return InventoryData
