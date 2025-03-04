#include "spell_dmg_inc"

void DoStamAnimDmg(int iDamage, object oPCTarget)
{

    effect eDamage;
    eDamage = EffectDamage(iDamage, DAMAGE_TYPE_POSITIVE);
    ApplyEffectToObject(0,eDamage,oPCTarget);

}


void main()
{

    object oPCEntering = GetEnteringObject();
    int nAnima = GetLocalInt(oPCEntering, "PC_ANIMA_CURRENT");
    int nStamina = GetLocalInt(oPCEntering, "PC_STAMINA_CURRENT");
    int iFilthDamage=0;


    effect eVis = EffectVisualEffect(VFX_IMP_SUNSTRIKE);

    if ( GetIsObjectValid(oPCEntering) && GetLocalInt(oPCEntering,"iFilthedUp") ==0 )
    {

         FloatingTextStringOnCreature("A shivering sensation crawls up your spine . . .",oPCEntering,FALSE);
         FloatingTextStringOnCreature("You feel as if prolonged contact with the filth would leave you unavoidably warped.", oPCEntering,FALSE);

        if (GetLocalInt(oPCEntering,"I_AM_BLOODMAGE"))
        {
                iFilthDamage = 15;
        }
        else
        {
            if ( nAnima >=5)
            {
                SetLocalInt(oPCEntering, "PC_ANIMA_CURRENT", nAnima-5);
            }
            else
            {
                iFilthDamage = abs(nAnima -5);
                SetLocalInt(oPCEntering, "PC_ANIMA_CURRENT", 0);
            }
            if ( nStamina >=5 )
            {
                SetLocalInt(oPCEntering, "PC_STAMINA_CURRENT", nStamina-5);
            }
            else
            {
                iFilthDamage += abs(nStamina -5);
                SetLocalInt(oPCEntering, "PC_STAMINA_CURRENT", 0);
            }
        }
     UpdateBinds(oPCEntering);
     DoStamAnimDmg(iFilthDamage, oPCEntering);

     SetLocalInt(oPCEntering,"iFilthedUp",1);
     DelayCommand(12.0f,DeleteLocalInt(oPCEntering,"iFilthedUp"));
    }
}



