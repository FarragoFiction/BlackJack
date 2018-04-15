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
    ButtonElement hitButton;

    Game(List<Card> this.deck, Element this.container, Element playerContainer, Element dealerContainer) {
        player = new Player(deck, playerContainer);
        dealer = new Dealer(deck, dealerContainer);
        renderHitButton();
    }

    void syncHitButton() {
        if(player.donePlaying) {
            hitButton.disabled = true;
        }
    }

    void renderStayButton() {
        ButtonElement stayButton = new ButtonElement();
        container.append(stayButton);
        stayButton.text = "I'll Stay";
        stayButton.onClick.listen((e) {
            player.stay();
            syncHitButton();
        });
    }

    void renderHitButton() {
        hitButton = new ButtonElement();
        container.append(hitButton);
        hitButton.text = "Hit Me";
        hitButton.onClick.listen((e) {
            player.hit();
            syncHitButton();
            player.render();
        });
    }


}