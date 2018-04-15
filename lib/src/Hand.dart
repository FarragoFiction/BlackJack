import "Card.dart";
import "dart:html";
class Hand {
    //one visible card
    //list of invisible cards
    //getter for hand value
    Card visibleCard;
    List<Card> invisibleCards = new List<Card>();

    //multiple hands can have this
    List<Card> deck;

    List<Card> get cardsInHand {
        List<Card> tmp = new List<Card>.from(invisibleCards);
        tmp.add(visibleCard);
        return tmp;
    }

    int get value {
        return Card.sumCards(cardsInHand);
    }

    bool get isOver {
        return value >21;
    }

    Hand(List<Card> this.deck) {
        visibleCard = Card.drawCard(deck);
        invisibleCards.add(Card.drawCard(deck));
    }

    void hit() {
        invisibleCards.add(Card.drawCard(deck));
    }

    void render(Element container) {
        container.setInnerHtml("");
        DivElement div = new DivElement();
        container.append(div);
        div.setInnerHtml("Value: ${value}");
        List<Card> cards = cardsInHand;
        for(Card c in cards) {
            if(c == visibleCard) {
                c.render(div, true);
            }else {
                c.render(div, false);
            }
        }

    }
}