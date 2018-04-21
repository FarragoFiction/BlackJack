import 'package:BlackJack/BlackJack.dart';
import 'package:RenderingLib/RendereringLib.dart';
import "dart:html";
import "dart:async";
Element container;
Game game;

main() {
    start();
}

Future<Null> start() async{
    await Loader.preloadManifest();
    game = new Game(Card.getFreshDeck(),querySelector("#output"), finishGame);
    game.start();
}

void finishGame() {
    window.alert("TODO: process bets");
}