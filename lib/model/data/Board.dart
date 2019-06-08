import 'package:blackjack_kolokwium/model/data/Player.dart';
import 'package:blackjack_kolokwium/model/data/Card.dart' show Ace, Card, Cards;
import 'package:blackjack_kolokwium/model/interface/IPlayer.dart';

class Board {
  Player _playerOne, _playerTwo;
  Player get playerOne => _playerOne;
  Player get playerTwo => _playerTwo;
  bool _playerOneIsNowPlaying = true;
  bool get playerOneIsNowPlaying => _playerOneIsNowPlaying;
  List<Card> deck = [];

  Board(Player one, Player two) {
    _playerOne = one;
    _playerTwo = two;
    _setupDeck();
  }

  void _setupDeck() {
    Cards.forEach((card) {
      for (int i = 0; i < 4; i++) deck.add(card);
    });
  }

  void _turn() {
    if (!_playerOne.passed && !playerTwo.passed)
      _playerOneIsNowPlaying = !_playerOneIsNowPlaying;
  }

  void pickCard() {
    IPlayer currentPlayer = _playerOneIsNowPlaying ? playerOne : playerTwo;
    currentPlayer.cardPicked(_getNextCard());
    _turn();
  }

  void pass() {
    IPlayer currentPlayer = _playerOneIsNowPlaying ? playerOne : playerTwo;
    currentPlayer.pass();
    _turn();
    _playerOneIsNowPlaying = !_playerOneIsNowPlaying;
  }

  Card _getNextCard() {
    if (deck.length == 0) _setupDeck();
    deck.shuffle();
    return deck.removeLast();
  }

  GameResult result() {
    int playerOnePoints = _playerOne.cards.fold(0, (prev, card) {
      if (card.runtimeType == Ace)
        return prev + (card as Ace).betterValue(prev);

      return prev + card.value;
    });

    int playerTwoPoints = _playerTwo.cards.fold(0, (prev, card) {
      if (card.runtimeType == Ace)
        return prev + (card as Ace).betterValue(prev);

      return prev + card.value;
    });

    if (playerOnePoints == 21) return GameResult.PlayerOne;
    if (playerOnePoints > 21) return GameResult.PlayerTwo;
    if (playerTwoPoints == 21) return GameResult.PlayerTwo;
    if (playerTwoPoints > 21) return GameResult.PlayerOne;

    if (_playerOne.passed && _playerTwo.passed) {
      if (playerOnePoints == playerTwoPoints) return GameResult.Draw;
      return playerOnePoints > playerTwoPoints
          ? GameResult.PlayerOne
          : GameResult.PlayerTwo;
    }

    return GameResult.NotDetermined;
  }
}

enum GameResult { NotDetermined, Draw, PlayerOne, PlayerTwo }
