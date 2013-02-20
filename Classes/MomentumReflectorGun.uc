//==============================================================================
//	MomentumReflectorGun (C) 2010 Eliot Van Uytfanghe All Rights Reserved.
//==============================================================================
class MomentumReflectorGun extends LinkGun;

// Gun skin and skin shader made by Haydon 'Billa' jameson
#exec obj load file="MRGSkins.utx" package="MomentumReflectorGun"

simulated function UpdateLinkColor( LinkAttachment.ELinkColor Color );

simulated event RenderOverlays( Canvas Canvas )
{
	super(Weapon).RenderOverlays( Canvas );
}

simulated function Destroyed()
{
	super(Weapon).Destroyed();
}

function bool CanHeal( Actor Other )
{
	return false;
}

simulated function bool PutDown()
{
    return super(Weapon).PutDown();
}

simulated function BringUp( optional Weapon PrevWeapon )
{
    super(Weapon).BringUp( PrevWeapon );
}

simulated event WeaponTick( float dt )
{
	super(Weapon).WeaponTick( dt );
}

function bool ConsumeAmmo( int Mode, float load, optional bool bAmountNeededIsMax )
{
	return true;
}

simulated function bool HasAmmo()
{
	return true;
}

defaultproperties
{
	ItemName="Momentum Reflector Gun"
	Description="The Momentum Reflector Gun is a self momentum building weapon, it is used to achieve boosts of great lengths and height by professional players to reach certain goals in mythic worlds."
	FireModeClass(0)=Class'MomentumReflectorFire'
	FireModeClass(1)=Class'MomentumReflectorAltFire'
	Skins(0)=Shader'MRGShader'
	Skins(1)=PipeTexture
	AttachmentClass=Class'MomentumReflectorAttachment'
	PickupClass=Class'MomentumReflectorGunPickup'

	IconMaterial=Texture'MRGHudIcon'
    IconCoords=(X1=23,Y1=41,X2=100,Y2=85)

    HudColor=(R=0,G=255,B=255,A=255)
	CustomCrosshairColor=(R=0,G=255,B=255,A=255)
}
