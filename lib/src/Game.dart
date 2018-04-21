import 'package:RenderingLib/RendereringLib.dart';
import "Card.dart";
import "Player.dart";
import "Dealer.dart";
import "dart:html";

class Game {

    Element playerContainer;
    Element dealerContainer;
    Element infoContainer;

    Player player;
    Dealer dealer;
    List<Card> deck;
    Element container;
    ButtonElement hitButton;
    ButtonElement stayButton;
    bool lost = false;
    bool dealerTookTurn = false;
    Action callBack;
    Game(List<Card> this.deck, Element this.container,Action this.callBack) {
        setUpPlayingField();
        player = new Player(deck, playerContainer);
        dealer = new Dealer(new Random().nextDouble(),deck, dealerContainer);
        renderHitButton();
        renderStayButton();
    }

    void start() {
        player.render();
        dealer.render();
    }

    void syncHitButton() {
        if(player.donePlaying) {
            hitButton.disabled = true;
            stayButton.disabled = true;
            checkResult(); //did i already go over
            if(!lost) {
                handleDealersTurn(); //game is done
                dealerTookTurn = true;
                checkResult();
            }
        }
    }

    void youLose() {
        DivElement resultsDiv = new DivElement();
        resultsDiv.text = "YOU LOSE!!!";
        lost = true;
        container.append(resultsDiv);
        flipCards();
        callBack();
    }

    void youWin() {
        if(dealerTookTurn) {
            DivElement resultsDiv = new DivElement();
            resultsDiv.text = "YOU WIN!!!";
            lost = false;
            container.append(resultsDiv);
            flipCards();
            callBack();
        }
    }

    void flipCards() {
        player.flipCards();
        dealer.flipCards();
    }

    void checkResult() {
        if(player.hand.isOver21) {
            youLose();
        }else if(dealer.hand.isOver21) {
            youWin();
        }else if(dealer.hand.value >= player.hand.value) {
            if(dealerTookTurn) youLose();
        }else if(player.hand.value > dealer.hand.value) {
            if(dealerTookTurn) youWin();
        }
    }

    void setUpPlayingField() {
        TableElement table = new TableElement();
        TableRowElement infoRow = new TableRowElement();
        infoContainer = new TableCellElement();
        infoRow.append(infoContainer);
        table.append(infoRow);

        TableRowElement trDealer = new TableRowElement();
        table.append(trDealer);
        TableRowElement trPlayer = new TableRowElement();
        table.append(trPlayer);
        playerContainer = new TableCellElement();
        dealerContainer = new TableCellElement();
        trDealer.append(dealerContainer);
        trPlayer.append(playerContainer);
        container.append(table);
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