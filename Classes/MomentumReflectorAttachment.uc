//==============================================================================
//	MomentumReflectorGun (C) 2010 Eliot Van Uytfanghe All Rights Reserved.
//==============================================================================
class MomentumReflectorAttachment extends LinkAttachment;

simulated function SetLinkColor( ELinkColor NewColor );
simulated function UpdateLinkColor();

// Copied from parent class to change the hardcoded muzflash class...
simulated event ThirdPersonEffects()
{
    local Rotator R;

    if ( Level.NetMode != NM_DedicatedServer && FlashCount > 0 )
	{
        if (FiringMode == 0)
        {
            if (MuzFlash == None)
            {
                MuzFlash = Spawn(class'MomentumReflectorMuzFlashProj3rd');
                AttachToBone(MuzFlash, 'tip');
            }
            if (MuzFlash != None)
            {
                MuzFlash.mSizeRange[0] = MuzFlash.default.mSizeRange[0];
                MuzFlash.mSizeRange[1] = MuzFlash.mSizeRange[0];

                MuzFlash.Trigger(self, None);
                R.Roll = Rand(65536);
                SetBoneRotation('bone flashA', R, 0, 1.0);
            }
        }
    }

    super.ThirdPersonEffects();
}

defaultproperties
{
	Skins[0]=Shader'MRGShader'
	Skins(1)=PipeTexture
}
