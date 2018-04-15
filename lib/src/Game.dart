import 'package:RenderingLib/RendereringLib.dart';
import "Card.dart";
import "Player.dart";
import "Dealer.dart";
import "dart:html";

class Game {

    Player player;
    Dealer dealer;
    List<Card> deck;
    Element container;

    Game(List<Card> this.deck, Element this.container, Element playerContainer, Element dealerContainer) {
        player = new Player(deck, playerContainer);
        dealer = new Dealer(deck, dealerContainer);
        renderHitButton();
    }

    void renderHitButton() {
        ButtonElement button = new ButtonElement();
        container.append(button);
        button.text = "Hit Me";
        button.onClick.listen((e) {
            player.hit();
            player.render();
        });
    }


}