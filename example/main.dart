import 'package:BlackJack/BlackJack.dart';
import 'package:RenderingLib/RendereringLib.dart';
import "dart:html";
List<Card> cards;
Element container;
main() {
    container = querySelector("#output");
    cards = Card.getFreshDeck();
    cards = Card.shuffleDeck(cards);
    //testThingy();
    testHand();
}

void testHand() {
    DivElement d = new DivElement();
    container.append(d);
    d.text = ",${cards[0].name}";

    DivElement d2 = new DivElement();
    container.append(d2);
    d2.text = ",${cards[1].name}";

    DivElement d3 = new DivElement();
    container.append(d2);
    d3.text = ",${Card.sumCards(<Card>[cards[0], cards[1]])}";
}

void testThingy() {
    for(Card c in cards) {
        DivElement d = new DivElement();
        container.append(d);
        d.text = ",${c.name}";

    }
}
