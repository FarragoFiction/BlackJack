import 'package:RenderingLib/RendereringLib.dart';
import "dart:html";
import "dart:async";

class Card {
    static Suit HEART = new Suit("Hearts", new Colour(255,0,0));
    static Suit DIAMONDS = new Suit("Diamonds", new Colour(255,0,0));
    static Suit CLUBS =  new Suit("Clubs", new Colour(0,0,0));
    static Suit SPADES =  new Suit("Spades", new Colour(0,0,0));

    int width = 322;
    int height = 450;
    //means i need to rerender
    bool dirty = false;

    //cahced for your convinience
    CanvasElement canvas;


    String folder = "images/Cards/";
    String blankCard = "Base.png";
    String flippedCard = "Back.png";
    int value;
    Suit suit;

    String get blankCardPath => "${folder}${blankCard}";
    String get backCardPath => "${folder}${flippedCard}";
    int get scaledWidth => (width*scale).round();
    int get scaledHeight => (height*scale).round();
    double scale;


    //cards are actually p big
    Card(int this.value, Suit this.suit, {double this.scale:0.33});

    int currentValue(int otherValue) {
        //aces do their own thing
        if(value >10) return 10;
        return value;
    }

    Future<Null> render(Element container, bool visible) async {
        DivElement div = new DivElement();
        div.classes.add("card");
        String visibleString = "Hidden";
        if(visible) visibleString = "Visible";
        print("going to render $visibleString $name");
        div.setInnerHtml("$visibleString $name");
        container.append(div);

        if(canvas != null && !dirty) {
            div.append(canvas);
        }
        if(canvas == null || dirty ) {
            CanvasElement fullCanvas = new CanvasElement(width: width, height: height);
            canvas = new CanvasElement(width: scaledWidth, height: scaledHeight);
            div.append(canvas);
            if (visible) {
                await renderFront(fullCanvas);
            } else {
                await Renderer.drawWhateverFuture(fullCanvas, backCardPath);
            }
            canvas.context2D.drawImageScaled(fullCanvas, 0, 0, scaledWidth, scaledHeight);
        }
    }


    Future<Null> renderFront(CanvasElement destinationCanvas) async {
        await Renderer.drawWhateverFuture(destinationCanvas, blankCardPath);
        //TODO render symbol
        //TODO in text, draw value (number of JKQ)

    }


        static Card drawCard(List<Card> cards) {
        if(cards.isEmpty) {
            window.alert("shuffling new deck");
            cards.clear();
            //doing it this way should keep all the refrances working
            List<Card> newDeck = Card.getFreshDeck();
            cards.addAll(newDeck);
        }
        Card ret = cards[0];
        cards.removeAt(0);
        return ret;
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

    String get symbolValue {
        if(value == 11) return "J";
        if(value == 12) return "Q";
        if(value == 13) return "K";
        return "$value";
    }

    String get name {
        return "$symbolValue of $suit";
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
                ret.add(new AceCard(HEART));
                ret.add(new AceCard(SPADES,));
                ret.add(new AceCard(CLUBS));
                ret.add(new AceCard(DIAMONDS));
            }else {
                ret.add(new Card(i,HEART));
                ret.add(new Card(i,SPADES));
                ret.add(new Card(i,CLUBS));
                ret.add(new Card(i,DIAMONDS));
            }
        }

        return ret;
    }
}


//value becomes a get
class AceCard extends Card {
    int altValue = 11;
    int value = 1;

  AceCard(Suit suit) : super(1, suit);

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

class Suit {
    String name;
    Colour color;
    Suit(String this.name, Colour this.color);

    @override
    String toString() {
        return this.name;
    }
}