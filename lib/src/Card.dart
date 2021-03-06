import 'package:CommonLib/Colours.dart';
import 'package:CommonLib/Random.dart';
import 'package:RenderingLib/RendereringLib.dart';
import "dart:html";
import "dart:async";
import "dart:math" as Math;

class Card {
    static String folder = "images/Cards/";
    int fontSize = 52;
    //how much smaller than ace
    int symbolDivider = 3;


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


    String blankCard = "Base.png";
    String flippedCard = "Back.png";
    int value;
    Suit suit;

    String get blankCardPath => "${folder}${blankCard}";
    String get kingPath => "${folder}King.png";
    String get queenPath => "${folder}Queen.png";
    String get jackPath => "${folder}Jack.png";

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
        SpanElement div = new SpanElement();
        div.classes.add("card");
        //String visibleString = "Hidden";
        //if(visible) visibleString = "Visible";
        //print("going to render $visibleString $name");
        //div.setInnerHtml("$visibleString $name");
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
        await renderNumbers(destinationCanvas);
        await renderSymbols(destinationCanvas);
    }

    Future<Null> renderNumbers(CanvasElement destinationCanvas) async {
        print("rendering numbers");
        destinationCanvas.context2D.fillStyle = suit.color.toStyleString();
        destinationCanvas.context2D.font = "${fontSize}px Times New Roman";
        destinationCanvas.context2D.fillText(symbolValue, fontSize/2, fontSize);

        destinationCanvas.context2D.save();
        //translate canvas such that where you want to draw the number is the origin
        //that way it rotates correctly
        destinationCanvas.context2D.translate(destinationCanvas.width- fontSize/2, destinationCanvas.height - fontSize);
        destinationCanvas.context2D.rotate(180*Math.pi/180);
        destinationCanvas.context2D.fillText(symbolValue,0, 0);
        destinationCanvas.context2D.restore();

        CanvasElement symbol = await suit.getSymbol();
        //just underneath number
        destinationCanvas.context2D.drawImageScaled(symbol, fontSize/2, fontSize, symbol.width/6, symbol.height/6);
        Renderer.drawUpsideDownAt(symbol, destinationCanvas, destinationCanvas.width - (fontSize/2).round(), destinationCanvas.height - fontSize, 6);

    }

    Future<Null> renderSymbols(CanvasElement destinationCanvas) async {
        if(value == 2) {
            await renderTwoFront(destinationCanvas);
        }else if(value == 3) {
            await renderThreeFront(destinationCanvas);
        }else if(value == 4) {
            await renderFourFront(destinationCanvas);
        }else if(value == 5) {
            await renderFiveFront(destinationCanvas);
        }else if(value == 6) {
            await renderSixFront(destinationCanvas);
        }else if(value == 7) {
            await renderSevenFront(destinationCanvas);
        }else if(value == 8) {
            await renderEightFront(destinationCanvas);
        }else if(value == 9) {
            await renderNineFront(destinationCanvas);
        }else if(value == 10) {
            await renderTenFront(destinationCanvas);
        }else if(value == 11) {
            await renderJackFront(destinationCanvas);
        }else if(value == 12) {
            await renderQueenFront(destinationCanvas);
        }else if(value == 13) {
            await renderKingFront(destinationCanvas);
        }else {
            await renderAceFront(destinationCanvas);
        }


    }


    Future<Null> renderAceFront(CanvasElement destinationCanvas) async {
        CanvasElement symbol = await suit.getSymbol();
        destinationCanvas.context2D.drawImage(symbol, width/4, height/4);
        print("drew ace symbol");
    }

    Future<Null> renderQueenFront(CanvasElement destinationCanvas) async {
        await Renderer.drawWhateverFuture(destinationCanvas, queenPath);
    }

    Future<Null> renderKingFront(CanvasElement destinationCanvas) async {
        await Renderer.drawWhateverFuture(destinationCanvas, kingPath);

    }

    Future<Null> renderJackFront(CanvasElement destinationCanvas) async {
        await Renderer.drawWhateverFuture(destinationCanvas, jackPath);
    }

    Future<Null> renderTwoFront(CanvasElement destinationCanvas) async {
        CanvasElement symbol = await suit.getSymbol();
        destinationCanvas.context2D.drawImageScaled(symbol, 130, 100, symbol.width/symbolDivider, symbol.height/symbolDivider);
        Renderer.drawUpsideDownAt(symbol, destinationCanvas, 130 + (symbol.width/3).round(), 350, symbolDivider);
    }

    Future<Null> renderThreeFront(CanvasElement destinationCanvas) async {
        CanvasElement symbol = await suit.getSymbol();
        destinationCanvas.context2D.drawImageScaled(symbol, 130, 100, symbol.width/symbolDivider, symbol.height/symbolDivider);
        destinationCanvas.context2D.drawImageScaled(symbol, 130, 190, symbol.width/symbolDivider, symbol.height/symbolDivider);
        Renderer.drawUpsideDownAt(symbol, destinationCanvas, 130 + (symbol.width/3).round(), 350, symbolDivider);

    }

    Future<Null> renderFourFront(CanvasElement destinationCanvas) async {
        CanvasElement symbol = await suit.getSymbol();
        destinationCanvas.context2D.drawImageScaled(symbol, 50, 100, symbol.width/symbolDivider, symbol.height/symbolDivider);
        destinationCanvas.context2D.drawImageScaled(symbol, 200, 100, symbol.width/symbolDivider, symbol.height/symbolDivider);

        Renderer.drawUpsideDownAt(symbol, destinationCanvas, 50 + (symbol.width/3).round(), 350, symbolDivider);
        Renderer.drawUpsideDownAt(symbol, destinationCanvas, 200 + (symbol.width/3).round(), 350, symbolDivider);

    }

    Future<Null> renderFiveFront(CanvasElement destinationCanvas) async {
        CanvasElement symbol = await suit.getSymbol();
        destinationCanvas.context2D.drawImageScaled(symbol, 50, 100, symbol.width/symbolDivider, symbol.height/symbolDivider);
        destinationCanvas.context2D.drawImageScaled(symbol, 200, 100, symbol.width/symbolDivider, symbol.height/symbolDivider);
        destinationCanvas.context2D.drawImageScaled(symbol, 130, 190, symbol.width/symbolDivider, symbol.height/symbolDivider);

        Renderer.drawUpsideDownAt(symbol, destinationCanvas, 50 + (symbol.width/3).round(), 350, symbolDivider);
        Renderer.drawUpsideDownAt(symbol, destinationCanvas, 200 + (symbol.width/3).round(), 350, symbolDivider);
    }

    Future<Null> renderSixFront(CanvasElement destinationCanvas) async {
        CanvasElement symbol = await suit.getSymbol();
        destinationCanvas.context2D.drawImageScaled(symbol, 50, 100, symbol.width/symbolDivider, symbol.height/symbolDivider);
        destinationCanvas.context2D.drawImageScaled(symbol, 50, 190, symbol.width/symbolDivider, symbol.height/symbolDivider);
        Renderer.drawUpsideDownAt(symbol, destinationCanvas, 50 + (symbol.width/3).round(), 350, symbolDivider);

        destinationCanvas.context2D.drawImageScaled(symbol, 200, 100, symbol.width/symbolDivider, symbol.height/symbolDivider);
        destinationCanvas.context2D.drawImageScaled(symbol, 200, 190, symbol.width/symbolDivider, symbol.height/symbolDivider);
        Renderer.drawUpsideDownAt(symbol, destinationCanvas, 200 + (symbol.width/3).round(), 350, symbolDivider);


    }

    Future<Null> renderSevenFront(CanvasElement destinationCanvas) async {
        CanvasElement symbol = await suit.getSymbol();
        destinationCanvas.context2D.drawImageScaled(symbol, 50, 100, symbol.width/symbolDivider, symbol.height/symbolDivider);
        destinationCanvas.context2D.drawImageScaled(symbol, 50, 190, symbol.width/symbolDivider, symbol.height/symbolDivider);
        destinationCanvas.context2D.drawImageScaled(symbol, 130, 150, symbol.width/symbolDivider, symbol.height/symbolDivider);

        Renderer.drawUpsideDownAt(symbol, destinationCanvas, 50 + (symbol.width/3).round(), 350, symbolDivider);

        destinationCanvas.context2D.drawImageScaled(symbol, 200, 100, symbol.width/symbolDivider, symbol.height/symbolDivider);
        destinationCanvas.context2D.drawImageScaled(symbol, 200, 190, symbol.width/symbolDivider, symbol.height/symbolDivider);
        Renderer.drawUpsideDownAt(symbol, destinationCanvas, 200 + (symbol.width/3).round(), 350, symbolDivider);
    }

    Future<Null> renderEightFront(CanvasElement destinationCanvas) async {
        CanvasElement symbol = await suit.getSymbol();
        destinationCanvas.context2D.drawImageScaled(symbol, 50, 100, symbol.width/symbolDivider, symbol.height/symbolDivider);
        destinationCanvas.context2D.drawImageScaled(symbol, 50, 190, symbol.width/symbolDivider, symbol.height/symbolDivider);
        destinationCanvas.context2D.drawImageScaled(symbol, 130, 150, symbol.width/symbolDivider, symbol.height/symbolDivider);

        Renderer.drawUpsideDownAt(symbol, destinationCanvas, 50 + (symbol.width/3).round(), 350, symbolDivider);
        Renderer.drawUpsideDownAt(symbol, destinationCanvas, 130 + (symbol.width/3).round(), 300, symbolDivider);

        destinationCanvas.context2D.drawImageScaled(symbol, 200, 100, symbol.width/symbolDivider, symbol.height/symbolDivider);
        destinationCanvas.context2D.drawImageScaled(symbol, 200, 190, symbol.width/symbolDivider, symbol.height/symbolDivider);
        Renderer.drawUpsideDownAt(symbol, destinationCanvas, 200 + (symbol.width/3).round(), 350, symbolDivider);
    }

    Future<Null> renderNineFront(CanvasElement destinationCanvas) async {
        CanvasElement symbol = await suit.getSymbol();
        destinationCanvas.context2D.drawImageScaled(symbol, 50, 80, symbol.width/symbolDivider, symbol.height/symbolDivider);
        destinationCanvas.context2D.drawImageScaled(symbol, 50, 160, symbol.width/symbolDivider, symbol.height/symbolDivider);
        Renderer.drawUpsideDownAt(symbol, destinationCanvas, 50 + (symbol.width/3).round(), 310, symbolDivider);
        Renderer.drawUpsideDownAt(symbol, destinationCanvas, 50 + (symbol.width/3).round(), 380, symbolDivider);

        destinationCanvas.context2D.drawImageScaled(symbol, 125, 200, symbol.width/symbolDivider, symbol.height/symbolDivider);


        destinationCanvas.context2D.drawImageScaled(symbol, 200, 80, symbol.width/symbolDivider, symbol.height/symbolDivider);
        destinationCanvas.context2D.drawImageScaled(symbol, 200, 160, symbol.width/symbolDivider, symbol.height/symbolDivider);
        Renderer.drawUpsideDownAt(symbol, destinationCanvas, 200 + (symbol.width/3).round(), 310, symbolDivider);
        Renderer.drawUpsideDownAt(symbol, destinationCanvas, 200 + (symbol.width/3).round(), 380, symbolDivider);
    }

    Future<Null> renderTenFront(CanvasElement destinationCanvas) async {
        CanvasElement symbol = await suit.getSymbol();
        destinationCanvas.context2D.drawImageScaled(symbol, 50, 80, symbol.width/symbolDivider, symbol.height/symbolDivider);
        destinationCanvas.context2D.drawImageScaled(symbol, 50, 160, symbol.width/symbolDivider, symbol.height/symbolDivider);
        Renderer.drawUpsideDownAt(symbol, destinationCanvas, 50 + (symbol.width/3).round(), 310, symbolDivider);
        Renderer.drawUpsideDownAt(symbol, destinationCanvas, 50 + (symbol.width/3).round(), 380, symbolDivider);

        destinationCanvas.context2D.drawImageScaled(symbol, 130, 120, symbol.width/symbolDivider, symbol.height/symbolDivider);
        Renderer.drawUpsideDownAt(symbol, destinationCanvas, 130 + (symbol.width/3).round(), 330, symbolDivider);


        destinationCanvas.context2D.drawImageScaled(symbol, 200, 80, symbol.width/symbolDivider, symbol.height/symbolDivider);
        destinationCanvas.context2D.drawImageScaled(symbol, 200, 160, symbol.width/symbolDivider, symbol.height/symbolDivider);
        Renderer.drawUpsideDownAt(symbol, destinationCanvas, 200 + (symbol.width/3).round(), 310, symbolDivider);
        Renderer.drawUpsideDownAt(symbol, destinationCanvas, 200 + (symbol.width/3).round(), 380, symbolDivider);
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
        if(value == 1) return "A";
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
    int width = 180;
    int height = 215;
    //only need to fetch once
    CanvasElement cachedCanvas;
    Suit(String this.name,Colour this.color);

    @override
    String toString() {
        return this.name;
    }

    String get symbolPath => "${Card.folder}${name}.png";


    Future<CanvasElement> getSymbol() async {
        if(cachedCanvas == null) {
           // print("rendering $name for first time");
            CanvasElement tmpcachedCanvas = new CanvasElement(width: width, height: height);
            await Renderer.drawWhateverFuture(tmpcachedCanvas, symbolPath);
            //don't do this sooner or if subsequent uses of this symbol will be blank  until the await is done
            cachedCanvas = tmpcachedCanvas;
        }else {
            //print("using cached canvas");
        }
        return cachedCanvas;
    }
}