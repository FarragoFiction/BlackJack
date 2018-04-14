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

    int currentValue(int otherValue) {
        return value;
    }

    static int sumCards(List<Card> cards) {
        int ret = 0;
        List<AceCard> aces = new List<AceCard>();
        for(Card c in cards) {
            if(c is AceCard) {
                aces.add(c);
            }else {
                ret += c.currentValue(ret);
            }
        }

        for(AceCard ace in aces) {
            ret += ace.currentValue(ret);
        }

        return ret;
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
                ret.add(new AceCard("hearts1",HEART));
                ret.add(new AceCard("spades1",SPADES,));
                ret.add(new AceCard("clubs1",CLUBS));
                ret.add(new AceCard("diamonds1",DIAMONDS));
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
    int altValue = 11;
    int value = 1;

  AceCard(String imageName,String suit) : super(imageName, 1, suit);

    @override
    String get name {
        return "Ace of $suit";
    }

    @override
    int currentValue(int otherValues) {
        if(otherValues + altValue > 21) {
            return value;
        }
        return altValue;
    }
}