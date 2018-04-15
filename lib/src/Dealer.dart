import "Player.dart";
import 'package:BlackJack/src/Card.dart';
import "dart:html";
class Dealer extends Player{
  Dealer(List<Card> deck, Element container) : super(deck, container);
    //everything a player is but can auto play

  void render() {
      container.setInnerHtml("");
      container.setInnerHtml("Dealer");
      hand.render(container);
  }
}