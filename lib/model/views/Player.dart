import 'package:blackjack_kolokwium/model/data/Card.dart';
import 'package:blackjack_kolokwium/model/interface/ICard.dart';
import 'package:blackjack_kolokwium/model/interface/IPlayer.dart';
import 'package:blackjack_kolokwium/model/views/Card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class PlayerView extends StatelessWidget {
  final IPlayer player;
  final bool nowPlaying;
  PlayerView({@required this.player, this.nowPlaying = false, Key key})
      : super(key: key);

  int _playerPoints() {
    return player.cards.fold(0, (prev, card) {
      if (card.runtimeType == Ace)
        return prev + (card as Ace).betterValue(prev);

      return prev + card.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  player.name,
                  style: Theme.of(context).textTheme.subhead,
                ),
                SizedBox(
                  width: 16,
                ),
                Chip(
                  label: Text("${_playerPoints()}"),
                ),
                SizedBox(
                  width: 16,
                ),
                player.passed
                    ? Chip(
                        label: Text(
                          "Pass".toUpperCase(),
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        backgroundColor: Colors.red,
                      )
                    : nowPlaying
                        ? Chip(
                            label: Text(
                              "Now playing".toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            backgroundColor: Colors.green.shade800,
                          )
                        : Container()
              ],
            ),
          ),
          Container(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: player.cards.length,
              itemBuilder: (context, index) =>
                  CardView(card: player.cards[index]),
            ),
          )
        ],
      ),
    );
  }
}
