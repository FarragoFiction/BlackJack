import "Card.dart";
import "dart:html";
class Hand {
    //one visible card
    //list of invisible cards
    //getter for hand value
    Card invisibleCard;
    List<Card> visibleCards = new List<Card>();

    //multiple hands can have this
    List<Card> deck;

    List<Card> get cardsInHand {
        List<Card> tmp = new List<Card>.from(visibleCards);
        tmp.add(invisibleCard);
        return tmp;
    }

    int get value {
        return Card.sumCards(cardsInHand);
    }

    bool get isOver21 {
        return value >21;
    }

    Hand(List<Card> this.deck) {
        invisibleCard = Card.drawCard(deck);
        visibleCards.add(Card.drawCard(deck));
    }

    void hit() {
        visibleCards.add(Card.drawCard(deck));
    }

    void render(Element container) {
        DivElement div = new DivElement();
        container.append(div);
        div.setInnerHtml("Value: ${value}");
        List<Card> cards = cardsInHand;
        for(Card c in cards) {
            if(c == invisibleCard) {
                c.render(div, false);
            }else {
                c.render(div, true);
            }
        }

    }
}