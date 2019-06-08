import 'package:blackjack_kolokwium/model/interface/ICard.dart';

class Card implements ICard {
  final int value;
  final String name;

  const Card(this.value, this.name);
}

class Ace extends Card {
  const Ace() : super(1, "🤡");

  int betterValue(int currentSum) {
    return currentSum > 10 ? 1 : 11;
  }
}

const ICard AceCard = const Ace();
const ICard Two = const Card(2, "2");
const ICard Three = const Card(3, "3");
const ICard Four = const Card(4, "4");
const ICard Five = const Card(5, "5");
const ICard Six = const Card(6, "6");
const ICard Seven = const Card(7, "7");
const ICard Eight = const Card(8, "8");
const ICard Nine = const Card(9, "9");
const ICard Ten = const Card(10, "10");
const ICard Jack = const Card(11, "🤺");
const ICard Queen = const Card(12, "👸");
const ICard King = const Card(13, "👑");

const List<Card> Cards = const [
  AceCard,
  Two,
  Three,
  Four,
  Five,
  Six,
  Seven,
  Eight,
  Nine,
  Ten,
  Jack,
  Queen,
  King
];
