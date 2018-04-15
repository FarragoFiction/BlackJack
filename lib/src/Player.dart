import "Hand.dart";
import "Card.dart";
class Player {
    //has a hand, can hit or stay
    Hand hand;

    bool donePlaying = false;

    Player(List<Card> deck) {
        hand = new Hand(deck);
    }

    void hit() {
        if(!donePlaying) {
            hand.hit();
        }
    }

    void stay() {
        donePlaying = true;
    }

}