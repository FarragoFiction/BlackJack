import 'package:BlackJack/BlackJack.dart';
import 'package:RenderingLib/RendereringLib.dart';
import "dart:html";
List<Card> cards;
Element container;
main() {
    container = querySelector("#output");
    cards = Card.getFreshDeck();
    testThingy();
}

void testThingy() {
    for(Card c in cards) {
        DivElement d = new DivElement();
        container.append(d);
        d.text = ",${c.name}";

    }
}
