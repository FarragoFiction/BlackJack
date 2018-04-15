import "Hand.dart";
import "Card.dart";
import "dart:html";
class Player {
    //has a hand, can hit or stay
    Hand hand;

    bool donePlaying = false;
    Element container;

    Player(List<Card> deck, Element this.container) {
        hand = new Hand(deck);
    }

    void hit() {
        print("hit me");
        if(!donePlaying) {
            hand.hit();
            render();
            if(hand.isOver21) {
                donePlaying = true;
            }
        }
    }

    void stay() {
        donePlaying = true;
    }

    void render() {
        container.setInnerHtml("");
        container.setInnerHtml("Player");
        hand.render(container);
    }

}