import "Player.dart";
import 'package:BlackJack/src/Card.dart';
import "dart:html";
import 'package:RenderingLib/RendereringLib.dart';

class Dealer extends Player{
    //at 100% patience they ALWAYS hit under 17 and stay at 17+
    //otherwise have a chance of staying at 16 and hitting at 18.
    double patience;
    Random rand = new Random();
    int low = 16;
    int high = 18;
    int normal = 17; //best place to stop at.

  Dealer(double this.patience, List<Card> deck, Element container) : super(deck, container) {
      rand.nextInt(); //init
  }
    //everything a player is but can auto play

  void render() {
      container.setInnerHtml("");
      container.setInnerHtml("Dealer");
      hand.render(container);
  }

  //if you do something dumb, say something about it.
  void takeTurn(int otherPlayerValue) {
      print("dealer taking turn with value ${hand.value} compared to ${otherPlayerValue}");
      int stopAt = normal;
      if(rand.nextDouble() > patience) {
          if(rand.nextBool()) {
              stopAt = low;
          }else {
              stopAt = high;
          }
      }
      makeDecision(otherPlayerValue, stopAt);
      if(!donePlaying) takeTurn(otherPlayerValue);
  }

  void quip(int stopAt) {
      DivElement div = new DivElement();
      if(stopAt == high) {
          div.setInnerHtml("I'm feeling really lucky.");
      }else if(stopAt == low) {
          div.setInnerHtml("Better not risk it.");
      }else {

      }
  }

  void makeDecision(int otherPlayerValue, int stopAt) {
      print("making a decision, comparing ${otherPlayerValue} and  my value of ${hand.value}");
      if(hand.value > otherPlayerValue) {
          donePlaying = true;
      }
      if(hand.value >= stopAt) {
          //stay
          donePlaying = true;
          quip(stopAt);
      }

      hit();
  }




}