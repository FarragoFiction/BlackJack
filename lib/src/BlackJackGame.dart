import 'package:CommonLib/Random.dart';
import 'package:CommonLib/Utility.dart';
import 'package:RenderingLib/RendereringLib.dart';
import "Card.dart";
import "Player.dart";
import "Dealer.dart";
import "dart:html";

class BlackJackGame {

    //from player's persepective
    static String WON = "WON";
    static String LOST = "LOST";
    static String TIED = "TIED";

    Element playerContainer;
    Element dealerContainer;
    Element quipContainer;
    Element infoContainer;
    Element buttonContainer;

    List<String> dealerWonQuips = <String>["Obviously a superior robot would win."];
    List<String> dealerLostQuips = <String>["Huh. How'd that happen?"];

    Player player;
    Dealer dealer;
    List<Card> deck;
    Element container;
    ButtonElement hitButton;
    ButtonElement stayButton;

    //from player's persepective
    String result;

    bool dealerTookTurn = false;
    Action callBack;
    BlackJackGame(List<Card> this.deck, Element this.container,Action this.callBack) {
        setUpAudio();
        deck.shuffle(new Random());
        setUpPlayingField();
        player = new Player(deck, playerContainer);
        dealer = new Dealer(deck, dealerContainer);
        buttonContainer = new DivElement();
        container.append(buttonContainer);
        renderHitButton();
        renderStayButton();
    }

    void setUpAudio() {
        DivElement controls = new DivElement();
        AudioElement blowup = new AudioElement();
        blowup.classes.add("FX");

        SourceElement mp3 = new SourceElement();
        mp3.src = "music/BlackJack.mp3";
        mp3.type = "audio/mpeg";

        SourceElement ogg = new SourceElement();
        mp3.src = "music/BlackJack.ogg";
        mp3.type = "audio/ogg";

        blowup.volume = 0.02;
        blowup.append(mp3);
        blowup.append(ogg);
        blowup.loop = true;
        blowup.autoplay = true;
        blowup.controls = true;
        controls.append(blowup);
        container.append(controls);
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
            if(result != LOST) {
                handleDealersTurn(); //game is done
                dealerTookTurn = true;
                checkResult();
            }
        }
    }

    void youLose() {
        DivElement resultsDiv = new DivElement();
        resultsDiv.text = "YOU LOSE!!!";
        result = LOST;
        container.append(resultsDiv);
        flipCards();
        quip();
        callBack();
    }

    void youWin() {
        if(dealerTookTurn) {
            DivElement resultsDiv = new DivElement();
            resultsDiv.text = "YOU WIN!!!";
            result = WON;
            container.append(resultsDiv);
            flipCards();
            quip();
            callBack();
        }
    }

    void youTIE() {
        if(dealerTookTurn) {
            DivElement resultsDiv = new DivElement();
            resultsDiv.text = "YOU TIED?";
            result = TIED;
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
        if(result == LOST) { //if player lost, i won
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
        }else if(dealer.hand.value == player.hand.value) {
            youTIE();
        }else if(dealer.hand.value > player.hand.value) {
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
        table.style.minWidth = "800px";
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
        quipContainer.setInnerHtml(" ");
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
        buttonContainer.append(stayButton);
        stayButton.text = "I'll Stay";
        stayButton.onClick.listen((e) {
            player.stay();
            syncHitButton();
        });
    }

    void renderHitButton() {
        hitButton = new ButtonElement();
        buttonContainer.append(hitButton);
        hitButton.text = "Hit Me";
        hitButton.onClick.listen((e) {
            player.hit();
            syncHitButton();
        });
    }


}