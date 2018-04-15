import "Player.dart";
import 'package:BlackJack/src/Card.dart';
import "dart:html";
class Dealer extends Player{
    //at 100% patience they ALWAYS hit under 17 and stay at 17+
    //otherwise have a chance of staying at 16 and hitting at 18.
    double patience;

  Dealer(double this.patience, List<Card> deck, Element container) : super(deck, container);
    //everything a player is but can auto play

  void render() {
      container.setInnerHtml("");
      container.setInnerHtml("Dealer");
      hand.render(container);
  }

  //if you do something dumb, say something about it.
  void takeTurn(int otherPlayerValue) {

  }

}