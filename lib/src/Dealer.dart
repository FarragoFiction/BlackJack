import "Player.dart";
import 'package:BlackJack/src/Card.dart';
import "dart:html";
import 'package:RenderingLib/RendereringLib.dart';

class Dealer extends Player{
    //at 100% patience they ALWAYS hit under 17 and stay at 17+
    //otherwise have a chance of staying at 16 and hitting at 18.
    double patience;
    Random rand = new Random();

  Dealer(double this.patience, List<Card> deck, Element container) : super(deck, container);
    //everything a player is but can auto play

  void render() {
      container.setInnerHtml("");
      container.setInnerHtml("Dealer");
      hand.render(container);
  }

  //if you do something dumb, say something about it.
  void takeTurn(int otherPlayerValue) {
      int stopAt = 17;
      if(rand.nextDouble() > patience) {
          if(rand.nextBool()) {
              stopAt = 16;
          }else {
            stopAt = 18;
          }
      }
      makeDecision(otherPlayerValue, stopAt);
      if(!donePlaying) takeTurn(otherPlayerValue);
  }

  void makeDecision(int otherPlayerValue, int stopAt) {

      if(hand.value > otherPlayerValue) {
          donePlaying = true;
      }

      if(hand.value >= stopAt) {
          //stay
          donePlaying = true;
      }

      hit();
  }




}