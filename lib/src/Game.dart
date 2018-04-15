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
    ButtonElement stayButton;
    bool lost = false;

    Game(List<Card> this.deck, Element this.container, Element playerContainer, Element dealerContainer) {
        player = new Player(deck, playerContainer);
        dealer = new Dealer(deck, dealerContainer);
        renderHitButton();
        renderStayButton();
    }

    void syncHitButton() {
        if(player.donePlaying) {
            hitButton.disabled = true;
            stayButton.disabled = true;
            if(player.hand.isOver) {
                DivElement lostDiv = new DivElement();
                lostDiv.text = "YOU LOSE!!!";
                lost = true;
                container.append(lostDiv);
            }
        }
    }

    void renderStayButton() {
        stayButton = new ButtonElement();
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