import "Hand.dart";
import "Card.dart";
import "dart:html";
class Player {
    //has a hand, can hit or stay
    Hand hand;

    bool donePlaying = false;
    Element container;
    String name = "Player";

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

    void flipCards() {
        container.setInnerHtml("");
        container.setInnerHtml(name);
        hand.flipCards(container);
    }

    void render() {
        container.setInnerHtml("");
        container.setInnerHtml(name);
        hand.render(container,true);
    }

}