//==============================================================================
//	MomentumReflectorGun (C) 2010 Eliot Van Uytfanghe All Rights Reserved.
//==============================================================================
class MomentumReflectorFire extends LinkAltFire;

var protected Material MuzSkin;

function Projectile SpawnProjectile( Vector Start, Rotator Dir )
{
	return super(ProjectileFire).SpawnProjectile( Start, Dir );
}

simulated function bool AllowFire()
{
    return super(ProjectileFire).AllowFire();
}

function FlashMuzzleFlash()
{
	if( FlashEmitter != none )
	{
		FlashEmitter.Skins[0] = MuzSkin;
	}
	super(ProjectileFire).FlashMuzzleFlash();
}

function ServerPlayFiring()
{
	super(ProjectileFire).ServerPlayFiring();
}

function PlayFiring()
{
	super(ProjectileFire).PlayFiring();
}

defaultproperties
{
	AmmoClass=none
    AmmoPerFire=0

	FireRate=0.14
	ProjectileClass=Class'MomentumReflectorProjectile'

	MuzSkin=FinalBlend'LinkMuzProjTealFB'
}
