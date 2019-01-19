import 'package:BlackJack/BlackJack.dart';
import 'package:RenderingLib/RendereringLib.dart';
import "dart:html";
import "dart:async";
Element container;
BlackJackGame game;

DivElement div;
main() {
    div = querySelector("#output");
    start();
}

void clearDiv() {
    List<Element> children = new List.from(div.children);
    children.forEach((f) {
        f.remove();
    });
}

Future<Null> start() async{
    clearDiv();
    game = new BlackJackGame(Card.getFreshDeck(),div, finishGame);
    game.start();
}

void finishGame() {
    ButtonElement restartButton = new ButtonElement();
    restartButton.text = "New Deal?";
    div.append(restartButton);
    restartButton.onClick.listen((e) {
        start();
    });
}