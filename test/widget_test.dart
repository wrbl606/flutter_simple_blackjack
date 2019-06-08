// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:blackjack_kolokwium/model/data/Board.dart';
import 'package:blackjack_kolokwium/model/data/Card.dart';
import 'package:blackjack_kolokwium/model/data/Player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:blackjack_kolokwium/main.dart';

void main() {
  testWidgets('Ace card logic - smaller is better',
      (WidgetTester tester) async {
    Board board = Board(Player(name: "One"), Player(name: "Two"));
    board.playerOne.cardPicked(King);
    board.playerOne.cardPicked(AceCard);
    board.playerOne.pass();
    board.playerTwo.pass();

    expect(board.result(), GameResult.PlayerOne);
  });
  testWidgets('Ace card logic - higher is better', (WidgetTester tester) async {
    Board board = Board(Player(name: "One"), Player(name: "Two"));
    board.playerOne.cardPicked(AceCard);
    board.playerOne.cardPicked(Nine);
    board.playerTwo.cardPicked(King);
    board.playerTwo.cardPicked(AceCard);
    board.playerOne.pass();
    board.playerTwo.pass();

    expect(board.result(), GameResult.PlayerOne);
  });
  testWidgets('Not determined', (WidgetTester tester) async {
    Board board = Board(Player(name: "One"), Player(name: "Two"));
    board.playerOne.cardPicked(AceCard);
    board.playerOne.cardPicked(Nine);
    board.playerTwo.cardPicked(King);
    board.playerTwo.cardPicked(AceCard);

    expect(board.result(), GameResult.NotDetermined);
  });
}
