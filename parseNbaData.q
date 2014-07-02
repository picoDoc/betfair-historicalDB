system"l scripts/nbaMatchOdds.q";
delete basketball from `.;
{d:` sv hsym[`tables],x,`;d set .Q.en[`:tables]0!value x}each tables[];
exit 0
