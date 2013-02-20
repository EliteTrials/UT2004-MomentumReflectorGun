//==============================================================================
//	MomentumReflectorGun (C) 2010 Eliot Van Uytfanghe All Rights Reserved.
//==============================================================================
class MomentumReflectorProjectile extends LinkProjectile;

var() float SelfDamage;

simulated function LinkAdjust();

// Copied from parent class to change the hardcoded linktrail class...
simulated function PostNetBeginPlay()
{
	local float dist;
	local PlayerController PC;

    Acceleration = Normal(Velocity) * 3000.0;

	if ( (Level.NetMode != NM_DedicatedServer) && (Level.DetailMode != DM_Low) )
		Trail = Spawn(class'MomentumReflectorTrail',self);
	if ( (Trail != None) && (Instigator != None) && Instigator.IsLocallyControlled() )
	{
		if ( Role == ROLE_Authority )
			Trail.Delay(0.1);
		else
		{
			dist = VSize(Location - Instigator.Location);
			if ( dist < 100 )
				Trail.Delay(0.1 - dist/1000);
		}
	}

    if ( Level.NetMode == NM_DedicatedServer )
		return;

	if ( Level.bDropDetail || (Level.DetailMode == DM_Low) )
	{
		bDynamicLight = false;
		LightType = LT_None;
	}
	else
	{
		PC = Level.GetLocalPlayerController();
		if ( (PC == None) || (Instigator == None) || (PC != Instigator.Controller) )
		{
			bDynamicLight = false;
			LightType = LT_None;
		}
	}
}

// Pure copy from Projectile.uc, reason is to make it ignore the instigator but remain having damage for enemies like monsters.
simulated function HurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation )
{
	local actor Victims;
	local float damageScale, dist;
	local vector dir;
	local float Dmg;

	if ( bHurtEntry )
		return;

	bHurtEntry = true;
	foreach VisibleCollidingActors( class 'Actor', Victims, DamageRadius, HitLocation )
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if( (Victims != self) && (Hurtwall != Victims) && (Victims.Role == ROLE_Authority) && !Victims.IsA('FluidSurfaceInfo') )
		{
			if ( Instigator == None || Instigator.Controller == None )
				Victims.SetDelayedDamageInstigatorController( InstigatorController );

			if ( Victims == LastTouched )
				LastTouched = None;

			dir = Victims.Location - HitLocation;
			dist = FMax(1,VSize(dir));
			dir /= dist;
			damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius);

			if( victims != Instigator )
			{
				Dmg = damageScale * DamageAmount;

				if (Vehicle(Victims) != None && Vehicle(Victims).Health > 0)
					Vehicle(Victims).DriverRadiusDamage(DamageAmount, DamageRadius, InstigatorController, DamageType, Momentum, HitLocation);
			}
			else
			{
				Dmg = SelfDamage;
			}

			Victims.TakeDamage
			(
				Dmg,
				Instigator,
				Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
				(damageScale * Momentum * dir),
				DamageType
			);
		}
	}
	if ( (LastTouched != None) && (LastTouched != self) && (LastTouched.Role == ROLE_Authority) && !LastTouched.IsA('FluidSurfaceInfo') )
	{
		Victims = LastTouched;
		LastTouched = None;

		if ( Instigator == None || Instigator.Controller == None )
			Victims.SetDelayedDamageInstigatorController(InstigatorController);

		dir = Victims.Location - HitLocation;
		dist = FMax(1,VSize(dir));
		dir /= dist;
		damageScale = FMax(Victims.CollisionRadius/(Victims.CollisionRadius + Victims.CollisionHeight),1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius));

		if( victims != Instigator )
		{
			Dmg = damageScale * DamageAmount;

			if (Vehicle(Victims) != None && Vehicle(Victims).Health > 0)
				Vehicle(Victims).DriverRadiusDamage(DamageAmount, DamageRadius, InstigatorController, DamageType, Momentum, HitLocation);
		}
		else
		{
			Dmg = SelfDamage;
		}

		Victims.TakeDamage
		(
			Dmg,
			Instigator,
			Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
			(damageScale * Momentum * dir),
			DamageType
		);
	}

	bHurtEntry = false;
}

simulated function ProcessTouch( Actor Other, Vector HitLocation )
{
	if( Other != Instigator )
	{
		//Other.TakeDamage( Damage, Instigator, HitLocation, MomentumTransfer * Normal( Velocity ), MyDamageType );
		Explode( HitLocation, Normal(HitLocation - Other.Location) );
	}
}

// Copied from parent class to change the hardcoded sparks class...
simulated function Explode( Vector HitLocation, Vector HitNormal )
{
    if ( EffectIsRelevant(Location,false) )
	{
        Spawn(class'MomentumReflectorSparks',,, HitLocation, rotator(HitNormal));
	}
    PlaySound(Sound'WeaponSounds.BioRifle.BioRifleGoo2');

    if( Role == ROLE_Authority )
    	HurtRadius( Damage, DamageRadius, MyDamageType, MomentumTransfer, HitLocation );

	Destroy();
}

defaultproperties
{
	ExplosionDecal=class'MomentumReflectorScorch'

    SelfDamage=0.0f
	Damage=47
	DamageRadius=147
	MomentumTransfer=190000

	LightHue=127

	Skins(0)=FinalBlend'LinkProjTealFB'
}
