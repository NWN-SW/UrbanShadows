void main()
{
    object oPC = GetItemActivator();
    string sName = GetName(oPC);


    if(GetResRef(GetItemActivated()) == "tsw_feywine") {

        int roll = Random(20) + 1;
        switch (roll)
        {
        case 0: SendMessageToPC(oPC, "As you take a sip, a spicy sensation tingles your taste buds with fiery heat, reminiscent of licking flames.");
            break;
        case 1: SendMessageToPC(oPC, "Hrm... a sweet and light flavor, like sipping on a cup of cotton candy clouds.");
            break;
        case 2: SendMessageToPC(oPC, "Mmm... the zesty zip of lemon-lime mixed with a playful pop of fizzy sherbet.");
            break;
        case 3: SendMessageToPC(oPC, "Uff...! The bold flavor of jalapeno and habanero peppers, with a spicy kick that petrifies the senses!");
            break;
        case 4: SendMessageToPC(oPC, "Hrm...! The chill of a frosty blast of peppermint and cool menthol, like a blizzard in your mouth!");
            break;
        case 5: SendMessageToPC(oPC, "Mmm...! Freshly baked cinnamon rolls, with swirls of sweet cinnamon and vanilla icing dancing on your taste buds.");
            break;
        case 6: SendMessageToPC(oPC, "Egh... the bizarre and peculiar taste of aged shoe leather, with hints of mustiness and earthiness that leave a lingering, unforgettable impression.");
            break;
        case 7: SendMessageToPC(oPC, "Hrm... the smoky, tangy flavor of barbecue sauce, reminiscent of summer cookouts and savory delights straight from the grill.");
            break;
        case 8: SendMessageToPC(oPC, "Mmm... the rich, golden flavor of maple syrup, evoking memories of crisp autumn mornings and stacks of fluffy pancakes.");
            break;
        case 9: SendMessageToPC(oPC, "Hrm...! The zesty zest of tangy lemon, awakening your senses with its bright and citrusy flavor.");
            break;
        case 10: SendMessageToPC(oPC, "Mmm...! The sweetness of ripe raspberries, with their vibrant flavor that tantalizes the taste buds.");
            break;
        case 11: SendMessageToPC(oPC, "Mmm...! The refreshing taste of juicy apples, with their sweet and tangy flavor that satisfies the senses.");
            break;
        case 12: SendMessageToPC(oPC, "Mmm...! The golden sweetness of pure honey, with its smooth and velvety texture that lingers on your taste buds.");
            break;
        case 13: SendMessageToPC(oPC, "Mmm...! The perfect balance of sweet and salty with the decadent flavor of salted caramel, with its rich and buttery caramel goodness.");
            break;
        case 14: SendMessageToPC(oPC, "Mmmm...! The creamy richness of blueberry cheesecake, with its velvety texture and sweet berry flavor that melts in your mouth.");
            break;
        case 15: SendMessageToPC(oPC, "Egh... a musty flavor reminiscent of damp, decaying wood and the faint hint of mildew.");
            break;
        case 16: SendMessageToPC(oPC, "Egh... the murky taste of stagnant water mixed with rotting vegetation, like sipping from a swamp.");
            break;
        case 17: SendMessageToPC(oPC, "Ugh... overwhelmingly pungent and sharp, this bean tastes like biting into a raw, tear-inducing onion.");
            break;
        case 18: SendMessageToPC(oPC, "Ugh... this time the wine has a slimy, gooey texture with a sickly sweet flavor akin to spoiled candy.");
            break;
        case 19: SendMessageToPC(oPC, "Ugh... a metallic taste with faint notes of blood and decay, reminiscent of licking rusted iron.");
            break;
        case 20: SendMessageToPC(oPC, "Ugh... a bitter blend with notes of sweaty socks and moldy cheese, leaving a lingering, unpleasant aftertaste.");
            break;
        case 21: SendMessageToPC(oPC, "HOT!!! A scorching hot flavor that burns the tongue with intense spiciness, and the horrible aftertaste of cheap hot sauce!");
            break;
        default: SendMessageToPC(oPC, "Huh... the goodness of salted pretzels, with their buttery flavor and sprinkling of salt.");
            break;
        }
    }

    else {
        return;
    }


}
