import 'package:blackjack_kolokwium/model/interface/ICard.dart';

abstract class IPlayer {
  String get name;
  List<ICard> get cards;
  bool get passed;
  void cardPicked(ICard card);
  void pass();
}
