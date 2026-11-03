local function _h1(a0) return {sFilename=a0} end
local DFUtil = require('DFCommon.Util')
local Character = require('CharacterConstants')
local tAnimations = {}
tAnimations.sBasePath = 'Characters/Spacesuit/Animations/'
tAnimations['breathe']= _h1('Spacewalk_Idle.anim')
tAnimations['carry_breathe']= _h1('Spacewalk_Idle.anim')
tAnimations['walk']= _h1('Spacewalk_Walk.anim')
tAnimations['carry_walk']= _h1('Spacewalk_Walk.anim')
tAnimations['walk_rock']= _h1('Spacewalk_Walk_Rock.anim')
tAnimations['mining']= _h1('Spacewalk_Mining.anim')
tAnimations['build']= _h1('Spacewalk_Build.anim')
tAnimations['death_shot']= _h1('Spacewalk_Death.anim')
tAnimations['death_fire']= _h1('Spacewalk_Death.anim')
tAnimations['death_flail']= _h1('Spacewalk_Death.anim')
tAnimations['death_suffocate']= _h1('Spacewalk_Death.anim')
tAnimations['death_pose']= _h1('Spacewalk_Death.anim')
tAnimations['melee']= _h1('Spacewalk_FireGun.anim')
tAnimations['stance']={}
local tPistolStance={
    shoot={
        sFilename='Spacewalk_FireGun.anim',
        sAccessory='Pistol',
    },
    idle={
        sFilename='Spacewalk_Idle_HoldGun.anim',
        sAccessory='Pistol',
    },
}
tAnimations['stance']['pistol'] = tPistolStance
local tRifleStance={
    shoot={
        sFilename='Spacewalk_FireGun.anim',
        sAccessory='Rifle',
    },
    idle={
        sFilename='Spacewalk_Idle_HoldGun.anim',
        sAccessory='Rifle',
    },
}
tAnimations['stance']['rifle'] = tRifleStance
return tAnimations
