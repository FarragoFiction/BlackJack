import 'package:BlackJack/BlackJack.dart';
import 'package:RenderingLib/RendereringLib.dart';
import "dart:html";
Element container;
Game game;
Element playerContainer;
Element dealerContainer;
Element infoContainer;
main() {
    container = querySelector("#output");
    List<Card> cards = Card.getFreshDeck();
    cards = Card.shuffleDeck(cards);
    setUpPlayingField();

    game = new Game(cards, infoContainer, playerContainer, dealerContainer);

    //testThingy();
    displayStartGame();
}

void setUpPlayingField() {
    TableElement table = new TableElement();
    TableRowElement tr2 = new TableRowElement();
    infoContainer = new TableCellElement();
    tr2.append(infoContainer);
    table.append(tr2);

    TableRowElement tr = new TableRowElement();
    table.append(tr);
    playerContainer = new TableCellElement();
    dealerContainer = new TableCellElement();
    tr.append(playerContainer);
    tr.append(dealerContainer);
    container.append(table);
}

void displayStartGame() {
    game.player.render();
    game.dealer.render();

}

void testHand() {
    DivElement d = new DivElement();
    container.append(d);
    d.text = "${game.deck[0].name}";

    DivElement d2 = new DivElement();
    container.append(d2);
    d2.text = "${game.deck[1].name}";

    DivElement d3 = new DivElement();
    container.append(d3);
    d3.text = "Value: ${Card.sumCards(<Card>[game.deck[0], game.deck[1]])}";
}

void testThingy() {
    for(Card c in game.deck) {
        DivElement d = new DivElement();
        container.append(d);
        d.text = "${c.name}";

    }
}
