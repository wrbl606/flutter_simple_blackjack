import 'package:blackjack_kolokwium/model/interface/ICard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class CardView extends StatelessWidget {
  final ICard card;
  CardView({@required this.card, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      child: Card(
        child: ListTile(
          title: Text(
            card.name,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 64),
          ),
          subtitle: Text(
            "${card.value}",
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
