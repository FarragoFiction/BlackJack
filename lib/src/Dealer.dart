import "Player.dart";
import 'package:BlackJack/src/Card.dart';
import "dart:html";
import 'package:RenderingLib/RendereringLib.dart';

class Dealer extends Player{
    //at 100% patience they ALWAYS hit under 17 and stay at 17+
    //otherwise have a chance of staying at 16 and hitting at 18.

    @override
    String name = "Dealer"; //in wiggler sim will be empresses name?

    Random rand = new Random();
    int normal = 16; //17 is best place to stop at.

    //things that use this can replace.
    List<String> winQuips = <String>["I'm feeling really lucky."];
    List<String> loseQuips = <String>["I'm feeling really lucky."];


  Dealer(List<Card> deck, Element container) : super(deck, container) {
      rand.nextInt(); //init
  }
    //everything a player is but can auto play

  void render() {
      container.setInnerHtml("");
      container.setInnerHtml(name);
      hand.render(container);
  }

  //if you do something dumb, say something about it.
  void takeTurn(int otherPlayerValue) {
      print("dealer taking turn with value ${hand.value} compared to ${otherPlayerValue}");
      int stopAt = normal;
      makeDecision(otherPlayerValue, stopAt);
      if(!donePlaying) takeTurn(otherPlayerValue);
  }


  void makeDecision(int otherPlayerValue, int stopAt) {
      print("making a decision, comparing ${otherPlayerValue} and  my value of ${hand.value}");
      if(hand.value > otherPlayerValue) {
          donePlaying = true;
      }
      if(hand.value >= stopAt) {
          donePlaying = true;
      }

      hit();
  }




}