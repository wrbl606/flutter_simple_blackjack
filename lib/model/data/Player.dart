import 'package:blackjack_kolokwium/model/interface/ICard.dart';
import 'package:blackjack_kolokwium/model/interface/IPlayer.dart';

class Player implements IPlayer {
  String _name;
  String get name => _name;
  final List<ICard> _cards = [];
  List<ICard> get cards => _cards;
  bool _pass = false;
  bool get passed => _pass;

  Player({String name = "Player"}) {
    _name = name;
  }

  void cardPicked(ICard card) => _cards.add(card);
  void pass() => _pass = true;
}
