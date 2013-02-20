class MutMomentumReflectorGun extends Mutator;

var() class<MomentumReflectorGun> MRGClass;

function ModifyPlayer( Pawn Other )
{
	super.ModifyPlayer( Other );
	if( Other != none )
	{
		Other.GiveWeapon( string(MRGClass) );
	}
}

defaultproperties
{
	MRGClass=class'MomentumReflectorGun'

	FriendlyName="Momentum Reflector Gun"
	Description="Gives every player the Momentum Reflector Gun. The Momentum Reflector Gun is a self momentum building weapon, it is used to achieve boosts of great lengths and height by professional players to reach certain goals in mythic worlds. Created by Eliot Van Uytfanghe."
	RulesGroup="MomentumReflectorGun"
	Group="MomentumReflectorGun"
}
