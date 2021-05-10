
För att göra så att ord och meningar som ska synas
för användaren översätts automatiskt gör så här:

Lägg till önskade ord/fraser/meningar i .json-filerna som ligger under assets.
första ordet innan ':' ska vara variabelnamnet, denna måste vara samma för båda språken.
Efter ':' skriver ni det användaren ska se.
Var noga med att sista raden i .json INTE har komma-tecken efter sig, annars skiter det sig.

I filen där ord ska översättas importera translations.dart.

Där ord ska förekomma skriv: Translations.of(context).text("Variabelnamnet"),
notera att Variabelnamnet ska skrivas in som en sträng med "" runt sig, inte som variabel.
Metoden returnerar en sträng, inte en Text-widget,
funkar förstås bra att wrappa med Text-widget där det önskas sånt.