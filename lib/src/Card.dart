import 'package:RenderingLib/RendereringLib.dart';

class Card {
    static String HEART = "Hearts";
    static String DIAMONDS = "Diamonds";
    static String CLUBS = "Clubs";
    static String SPADES = "Spades";


    String folder = "images/Cards/";
    String imageName;
    int value;
    String suit;

    Card(String this.imageName, int this.value, String this.suit);

    int currentValue(List<Card> hand) {
        return value;
    }

    static int sumCards(List<Card> cards) {
        throw "TODO";
    }

    String get name {
        if(value == 11) return "Jack of $suit";
        if(value == 12) return "Queen of $suit";
        if(value == 13) return "King of $suit";
        return "$value of $suit";
    }

    static List<Card> shuffleDeck(List<Card> cards) {
            List<Card> thingy = new List<Card>.from(cards);
            List<Card> ret = new List<Card>();
            Random rand = new Random();
            while(thingy.length > 0) {
                Card chosen = rand.pickFrom(thingy);
                ret.add(chosen);
                thingy.remove(chosen);
            }
            return ret;
    }

    static List<Card> getFreshDeck() {
        List<Card> ret = new List<Card>();

        for(int i = 1; i<14; i++) {
            if(i == 1) {
                ret.add(new AceCard("hearts1",1,HEART,11));
                ret.add(new AceCard("spades1",1,SPADES, 11));
                ret.add(new AceCard("clubs1",1,CLUBS, 11));
                ret.add(new AceCard("diamonds1",1,DIAMONDS, 11));
            }else {
                ret.add(new Card("spades${i}",i,HEART));
                ret.add(new Card("spades${i}",i,SPADES));
                ret.add(new Card("spades${i}",i,CLUBS));
                ret.add(new Card("spades${i}",i,DIAMONDS));
            }
        }

        return ret;
    }
}


//value becomes a get
class AceCard extends Card {
    int altValue;

  AceCard(String imageName, int value, String suit,  int this.altValue) : super(imageName, value, suit);

    @override
    String get name {
        return "Ace of $suit";
    }

    @override
    int currentValue(List<Card> hand) {
        throw "TODO: calc value based on hand";
    }
}