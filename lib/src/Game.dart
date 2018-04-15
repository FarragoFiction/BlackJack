import 'package:RenderingLib/RendereringLib.dart';
import "Card.dart";
import "Player.dart";
import "Dealer.dart";
import "dart:html";

class Game {

    Player player;
    Dealer dealer;
    List<Card> deck;
    Element container;
    ButtonElement hitButton;
    ButtonElement stayButton;
    bool lost = false;
    bool dealerTookTurn = false;

    Game(List<Card> this.deck, Element this.container, Element playerContainer, Element dealerContainer) {
        player = new Player(deck, playerContainer);
        dealer = new Dealer(new Random().nextDouble(),deck, dealerContainer);
        renderHitButton();
        renderStayButton();
    }

    void syncHitButton() {
        if(player.donePlaying) {
            hitButton.disabled = true;
            stayButton.disabled = true;
            checkResult(); //did i already go over
            if(!lost) {
                handleDealersTurn(); //game is done
                checkResult();
            }
        }
    }

    void youLose() {
        DivElement resultsDiv = new DivElement();
        resultsDiv.text = "YOU LOSE!!!";
        lost = true;
        container.append(resultsDiv);

    }

    void youWin() {
        if(dealerTookTurn) {
            DivElement resultsDiv = new DivElement();
            resultsDiv.text = "YOU WIN!!!";
            lost = false;
            container.append(resultsDiv);
        }
    }

    void checkResult() {
        if(player.hand.isOver21) {
            youLose();
        }else if(dealer.hand.isOver21) {
            youWin();
        }else if(dealer.hand.value > player.hand.value) {
            if(dealerTookTurn) youLose();
        }else if(player.hand.value > dealer.hand.value) {
            if(dealerTookTurn) youWin();
        }
    }

    void handleDealersTurn() {
        print("handling dealers turn");
        dealer.takeTurn(player.hand.value);
    }

    void renderStayButton() {
        stayButton = new ButtonElement();
        container.append(stayButton);
        stayButton.text = "I'll Stay";
        stayButton.onClick.listen((e) {
            player.stay();
            syncHitButton();
        });
    }

    void renderHitButton() {
        hitButton = new ButtonElement();
        container.append(hitButton);
        hitButton.text = "Hit Me";
        hitButton.onClick.listen((e) {
            player.hit();
            syncHitButton();
        });
    }


}