import 'package:blackjack_kolokwium/model/data/Board.dart';
import 'package:blackjack_kolokwium/model/data/Card.dart';
import 'package:blackjack_kolokwium/model/data/Player.dart';
import 'package:blackjack_kolokwium/model/interface/IPlayer.dart';
import 'package:blackjack_kolokwium/model/views/Player.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blackjack',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Blackjack(title: 'Blackjack'),
    );
  }
}

class Blackjack extends StatefulWidget {
  Blackjack({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _BlackjackState createState() => _BlackjackState();
}

class _BlackjackState extends State<Blackjack> {
  Board board = Board(Player(name: "Player one"), Player(name: "Player two"));

  _pickCard() {
    board.pickCard();
    setState(() {});
    _checkResults();
  }

  _pass() {
    board.pass();
    setState(() {});
    _checkResults();
  }

  _buildMatchInfo() {
    int playerOnePoints = board.playerOne.cards.fold(0, (prev, card) {
      if (card.runtimeType == Ace)
        return prev + (card as Ace).betterValue(prev);

      return prev + card.value;
    });
    int playerTwoPoints = board.playerTwo.cards.fold(0, (prev, card) {
      if (card.runtimeType == Ace)
        return prev + (card as Ace).betterValue(prev);

      return prev + card.value;
    });

    return Text(
        "${board.playerOne.name}: $playerOnePoints\n${board.playerTwo.name}: $playerTwoPoints");
  }

  _buildResultsActions() {
    return [
      FlatButton(
        child: Text("Ok, play again"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      )
    ];
  }

  _checkResults() async {
    switch (board.result()) {
      case GameResult.Draw:
        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("It's a draw!"),
                  content: _buildMatchInfo(),
                  actions: _buildResultsActions(),
                ));
        break;
      case GameResult.PlayerOne:
        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("Player one won!"),
                  content: _buildMatchInfo(),
                  actions: _buildResultsActions(),
                ));
        break;
      case GameResult.PlayerTwo:
        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("Player two won!"),
                  content: _buildMatchInfo(),
                  actions: _buildResultsActions(),
                ));
        break;
      default:
        return;
    }

    setState(() {
      board = Board(Player(name: "Player one"), Player(name: "Player two"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          PlayerView(
            player: board.playerOne,
            nowPlaying: board.playerOneIsNowPlaying,
          ),
          PlayerView(
            player: board.playerTwo,
            nowPlaying: !board.playerOneIsNowPlaying,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'pass-fab',
            onPressed: _pass,
            tooltip: 'Pass',
            child: Icon(Icons.assignment_turned_in),
          ),
          SizedBox(
            width: 24,
          ),
          FloatingActionButton(
            onPressed: _pickCard,
            tooltip: 'Next card',
            child: Icon(Icons.add_box),
          ),
        ],
      ),
    );
  }
}
