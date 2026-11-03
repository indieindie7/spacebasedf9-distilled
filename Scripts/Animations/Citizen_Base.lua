local function _h1(a0) return {sFilename=a0} end
local function _h2(a0,a1) return {sFilename=a0,sAccessory=a1} end
local DFUtil = require('DFCommon.Util')
local Character = require('CharacterConstants')
local tAnimations = {}
tAnimations.sBasePath = 'Characters/Citizen_Base/Animations/'
tAnimations['walk'] = _h1('Citizen_Walk.anim')
tAnimations['walk_sad'] = _h1('Citizen_Walk_Sad.anim')
tAnimations['walk_happy'] = _h1('Citizen_Walk_Happy.anim')
tAnimations['walk_low_oxygen'] = _h1('Citizen_Walk_LowOxygen.anim')
tAnimations['interact'] = _h1('Citizen_Interact.anim')
tAnimations['tantrum'] = _h1('Citizen_Tantrum.anim')
tAnimations['walk_tantrum'] =
{
    sFilename='Citizen_Tantrum_Run.anim',
    bUseRunSpeed=true,
}
tAnimations['sabotage_fists'] = _h1('Citizen_SabotageMachine_Fists.anim')
tAnimations['sabotage_extinguisher'] = _h1('Citizen_SabotageMachine_Extinguisher.anim')
tAnimations['maintain'] = _h2('Citizen_TechnicianMaintain.anim', 'Datapad')
tAnimations['build'] = _h2('Citizen_BuilderConstruct.anim', 'Builder')
tAnimations['vaporize'] = _h2('Citizen_BuilderVaporize.anim', 'Builder')
tAnimations['talk_greet'] =
{
    tFilenames={
		'Citizen_Greet.anim',
	},
}
tAnimations['talk_introduce'] =
{
    tFilenames={
		'Citizen_Greet.anim',
	},
}
tAnimations['talk_speak'] =
{
    tFilenames={
		'Citizen_Talking.anim',
	},
}
tAnimations['talk_react_positive'] =
{
    tFilenames={
		'Citizen_PositiveReact.anim',
	},
}
tAnimations['talk_react_negative'] =
{
    tFilenames={
		'Citizen_NegativeReact.anim',
	},
}
tAnimations['talk_listen'] =
{
    tFilenames={
        'Citizen_Listening.anim',
	},
}
tAnimations['talk_laugh'] =
{
    tFilenames={
        'Citizen_Laughing.anim',
	},
}
tAnimations['talk_bye'] =
{
    tFilenames={
		'Citizen_Talking.anim',
	},
}
tAnimations['talk_bye_positive'] =
{
    tFilenames={
		'Citizen_HappyGoodbye.anim',
	},
}
tAnimations['talk_bye_negative'] =
{
    tFilenames={
		'Citizen_UnhappyGoodbye.anim',
	},
}
tAnimations['become_friends'] =
{
    tFilenames={
        'Citizen_BecomeFriends.anim',
	},
}
tAnimations['what_gives'] =
{
    tFilenames={
        'Citizen_WhatGives.anim',
	},
}
tAnimations['give_present'] =
{
    tFilenames={
        'Citizen_GivePresent.anim',
	},
}
tAnimations['take_present'] =
{
    tFilenames={
        'Citizen_TakePresent.anim',
	},
}
tAnimations['watch_tv'] =
{
    tFilenames={
        'Citizen_WatchTV.anim',
	},
}
tAnimations['watch_tv_like'] =
{
    tFilenames={
        'Citizen_WatchTV_Enjoy.anim',
	},
}
tAnimations['watch_tv_dislike'] =
{
    tFilenames={
        'Citizen_WatchTV_Dislike.anim',
	},
}
tAnimations['laser_cuffs_loop'] =
{
    tFilenames={
        'Citizen_LaserCuffs_Loop.anim',
	},
}
tAnimations['laser_cuffs_walk'] =
{
    tFilenames={
        'Citizen_LaserCuffs_Walk.anim',
	},
}
tAnimations['laser_cuffs_get_up'] =
{
    tFilenames={
        'Citizen_LaserCuffs_GetUp.anim',
	},
}
tAnimations['sit'] = _h1('Citizen_Idle_A.anim')
tAnimations['breathe'] =
{
    tFilenames={
		'Citizen_Idle_A.anim',
    	'Citizen_Idle_B.anim',
	},
}
tAnimations['drinkbooze'] =
{
    tFilenames={
		'Citizen_Drink.anim',
	},
    sAccessory = 'Mug',
}
tAnimations['incapacitated'] = _h1('Citizen_WoundedOnGround.anim')
tAnimations['incapacitated_cuffed'] = _h1('Citizen_LaserCuffs_Loop.anim')
tAnimations['sleep'] =
{
    sFilename='Citizen_Sleeping.anim',
	sInto='Citizen_Goto_Sleep.anim',
	sOutOf='Citizen_Wakeup.anim',
}
tAnimations['death_fire'] = _h1('Citizen_Fire_Death.anim')
tAnimations['death_suffocate'] = _h1('Citizen_Shot_Death.anim')
tAnimations['death_shot'] = _h1('Citizen_Shot_Death.anim')
tAnimations['death_pose'] = _h1('Citizen_DeadPose.anim')
tAnimations['panic_breathe']= _h1('Citizen_Panic_Idle.anim')
tAnimations['panic_walk']= _h1('Citizen_Panic_Walk.anim')
tAnimations['on_fire_breathe']= _h1('Citizen_On_Fire.anim')
tAnimations['fight_fire_armed']= _h2('Citizen_FightFire_Armed.anim', 'Extinguisher')
tAnimations['fight_fire_unarmed']= _h1('Citizen_FightFire_Unarmed.anim')
tAnimations['space_flail']= _h1('Citizen_SpaceFlail.anim')
tAnimations['melee']= _h1('Citizen_Box.anim')
tAnimations['nonviolent_takedown_victim']= _h1('Stun_Takedown.anim')
tAnimations['cower']= _h1('Citizen_Cower.anim')
tAnimations['pushups']= _h1('Citizen_Pushups.anim')
tAnimations['situps']= _h1('Citizen_Situps.anim')
tAnimations['jumping_jacks']= _h1('Citizen_JumpingJacks.anim')
tAnimations['gaming_idle']= _h2('Citizen_GamingIdle.anim', 'GameSystem')
tAnimations['gaming_frustration']= _h2('Citizen_GamingFrustration.anim', 'GameSystem')
tAnimations['eat_replicator']=
{
   sFilename='Citizen_Eat.anim',
   sAccessory='FoodBar',
   tRaceOverrides = {
        [Character.RACE_BIRDSHARK] = 'Citizen_Eat_Birdshark.anim',
   },
}
tAnimations['eat_vegetable']=
{
   sFilename='Citizen_Eat_Vegetable.anim',
   sAccessory='FoodVegetable',
   tRaceOverrides = {
        [Character.RACE_BIRDSHARK] = 'Citizen_Eat_Vegetable_Birdshark.anim',
   },
}
tAnimations['eat_cooked_food']=
{
   sFilename='Citizen_Eat_Fork.anim',
   sAccessory='FoodFork',
   tRaceOverrides = {
        [Character.RACE_BIRDSHARK] = 'Citizen_Eat_Fork_Birdshark.anim',
   },
}
tAnimations['cook']= _h2('Citizen_Cooking.anim', 'FryingPan')
tAnimations['carry_breathe']= _h1('Citizen_Carry.anim')
tAnimations['carry_walk']= _h1('Citizen_WalkCarry.anim')
tAnimations['carry_walk_corpse']= _h1('Citizen_WalkCarry_Body.anim')
tAnimations['carry_breathe_corpse']= _h1('Citizen_Breathe_BodyBag.anim')
tAnimations['drop_off_corpse']= _h1('Citizen_DropOff_BodyBag.anim')
tAnimations['fridge']= _h1('Citizen_Fridge.anim')
tAnimations['bartender_mix']= _h1('Citizen_BartenderMix.anim')
tAnimations['harvest']= _h1('Citizen_Harvest.anim')
tAnimations['workout_dumbell']= _h2('Citizen_CurlDumbell.anim', 'Dumbell')
tAnimations['workout_benchpress']= _h2('Citizen_BenchPress.anim', 'Barbell')
tAnimations['run']=
{
   sFilename='Citizen_Run_WithIntent.anim',
   bUseRunSpeed=true,
}
tAnimations['yawn']= _h1('Citizen_Yawn.anim')
tAnimations['sneeze']= _h1('Citizen_Yawn.anim')
tAnimations['startle']= _h1('Citizen_Startle.anim')
tAnimations['stance']={}
local tPistolStance={
    walk={
        sFilename='Citizen_Run_WithGun.anim',
        sAccessory='Pistol',
        bUseRunSpeed=true,
    },
    shoot= _h2('Citizen_EmergencyShoot_Pistol.anim', 'Pistol'),
    breathe= _h2('Citizen_EmergencyStance.anim', 'Pistol'),
}
tAnimations['stance']['pistol'] = tPistolStance
local tRifleStance={
    walk={
        sFilename='Citizen_Run_WithGun.anim',
        sAccessory='Rifle',
        bUseRunSpeed=true,
    },
    shoot= _h2('Citizen_EmergencyShoot.anim', 'Rifle'),
    breathe= _h2('Citizen_EmergencyStance.anim', 'Rifle'),
}
tAnimations['stance']['rifle'] = tRifleStance
local tStunnerStance={
    walk={
        sFilename='Citizen_Run_WithGun.anim',
        sAccessory='Pistol',
        bUseRunSpeed=true,
    },
    shoot= _h2('Citizen_EmergencyShoot_Pistol.anim', 'Pistol'),
    breathe= _h2('Citizen_EmergencyStance.anim', 'Pistol'),
}
tAnimations['stance']['stunner'] = tStunnerStance
local tMeleeStance={
    walk={
        sFilename='Citizen_Run_WithIntent.anim',
        bUseRunSpeed=true,
    },
}
tAnimations['stance']['melee'] = tMeleeStance
local tCuffedStance={
    walk= _h1('Citizen_LaserCuffs_Walk.anim'),
    breathe= _h1('Citizen_LaserCuffs_Standing.anim'),
    talk_greet= _h1('Citizen_LaserCuffs_Standing.anim'),
    talk_introduce= _h1('Citizen_LaserCuffs_Standing.anim'),
    talk_speak= _h1('Citizen_LaserCuffs_Standing.anim'),
    talk_react_positive= _h1('Citizen_LaserCuffs_Standing.anim'),
    talk_react_negative= _h1('Citizen_LaserCuffs_Standing.anim'),
    talk_listen= _h1('Citizen_LaserCuffs_Standing.anim'),
    talk_laugh= _h1('Citizen_LaserCuffs_Standing.anim'),
    talk_bye= _h1('Citizen_LaserCuffs_Standing.anim'),
    talk_bye_positive= _h1('Citizen_LaserCuffs_Standing.anim'),
    talk_bye_negative= _h1('Citizen_LaserCuffs_Standing.anim'),
    become_friends= _h1('Citizen_LaserCuffs_Standing.anim'),
    what_gives= _h1('Citizen_LaserCuffs_Standing.anim'),
    panic_walk= _h1('Citizen_LaserCuffs_Walk.anim'),
    panic_breathe= _h1('Citizen_LaserCuffs_Standing.anim'),
    on_fire_breathe= _h1('Citizen_LaserCuffs_Standing.anim'),
    cower= _h1('Citizen_LaserCuffs_Standing.anim'),
    run={
        sFilename='Citizen_LaserCuffs_Walk.anim',
        bUseRunSpeed=true,
    },
    startle= _h1('Citizen_LaserCuffs_Standing.anim'),
    sleep= _h1('Citizen_LaserCuffs_Standing.anim'),
}
tAnimations['stance']['cuffed'] = tCuffedStance
return tAnimations
