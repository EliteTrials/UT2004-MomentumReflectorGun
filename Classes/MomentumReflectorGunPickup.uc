//==============================================================================
//	MomentumReflectorGun (C) 2010 Eliot Van Uytfanghe All Rights Reserved.
//==============================================================================
class MomentumReflectorGunPickup extends LinkGunPickup;

static function StaticPrecache( LevelInfo L )
{
	L.AddPrecacheMaterial( Shader'MRGShader' );
	L.AddPrecacheMaterial( Material'PipeTexture' );
	L.AddPrecacheMaterial( FinalBlend'LinkMuzProjTealFB' );
	L.AddPrecacheMaterial( Material'momentumblastmark' );
	L.AddPrecacheMaterial( FinalBlend'LinkProjTealFB' );
	L.AddPrecacheMaterial( Texture'link_spark_teal' );
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial( Shader'MRGShader' );
	Level.AddPrecacheMaterial( Material'PipeTexture' );
	Level.AddPrecacheMaterial( FinalBlend'LinkMuzProjTealFB' );
	Level.AddPrecacheMaterial( Material'momentumblastmark' );
	Level.AddPrecacheMaterial( FinalBlend'LinkProjTealFB' );
	Level.AddPrecacheMaterial( Texture'link_spark_teal' );
	super.UpdatePrecacheMaterials();
}

defaultproperties
{
    InventoryType=Class'MomentumReflectorGun'
    PickupMessage="You got the Momentum Reflector Gun."

	Skins(0)=Shader'MRGShader'
	Skins(1)=PipeTexture
}
