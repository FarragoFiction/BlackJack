import 'package:RenderingLib/RendereringLib.dart';
import "Card.dart";
import "Player.dart";
import "Dealer.dart";
import "dart:html";

class Game {

    Element playerContainer;
    Element dealerContainer;
    Element quipContainer;
    Element infoContainer;

    List<String> dealerWonQuips = <String>["Obviously a superior robot would win."];
    List<String> dealerLostQuips = <String>["Huh. How'd that happen?"];

    Player player;
    Dealer dealer;
    List<Card> deck;
    Element container;
    ButtonElement hitButton;
    ButtonElement stayButton;
    //from player's persepctive
    bool lost = false;
    bool dealerTookTurn = false;
    Action callBack;
    Game(List<Card> this.deck, Element this.container,Action this.callBack) {
        deck.shuffle(new Random());
        setUpPlayingField();
        player = new Player(deck, playerContainer);
        dealer = new Dealer(deck, dealerContainer);
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
        quip();
        callBack();
    }

    void youWin() {
        if(dealerTookTurn) {
            DivElement resultsDiv = new DivElement();
            resultsDiv.text = "YOU WIN!!!";
            lost = false;
            container.append(resultsDiv);
            flipCards();
            quip();
            callBack();
        }
    }

    void quip() {
        DivElement quipElement = new DivElement();
        String quipText = "";
        Random rand = new Random();
        if(lost) { //if player lost, i won
            quipText = rand.pickFrom(dealerWonQuips);
        }else {
            quipText = rand.pickFrom(dealerLostQuips);
        }

        quipElement.setInnerHtml("$quipText");
        quipContainer.append(quipElement);

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
        DivElement borderElement = new DivElement();
        borderElement.style.display = "inline-block";
        borderElement.style.border = "3px solid #154418";

        TableElement table = new TableElement();
        table.style.backgroundColor = "#298b30";
        table.style.border = "3px solid #ffffff";
        table.style.padding = "10px";
        table.style.minWidth = "600px";
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
        quipContainer = new TableCellElement();
        infoRow.append(quipContainer);
        trDealer.append(dealerContainer);
        trPlayer.append(playerContainer);
        borderElement.append(table);
        container.append(borderElement);
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