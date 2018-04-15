import 'package:RenderingLib/RendereringLib.dart';
import "Card.dart";
import "Player.dart";
import "Dealer.dart";
class Game {

    Player player;
    Dealer dealer;
    List<Card> deck;

    Game(List<Card> this.deck) {
        player = new Player(deck);
        dealer = new Dealer(deck);
    }


}