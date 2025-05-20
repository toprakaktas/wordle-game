import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:english_words/english_words.dart' as words;
import 'package:wordle_clone/wordle.dart';

class WordleProvider extends ChangeNotifier {
  final random = Random.secure();
  List<String> totalWords = [];
  List<String> rowInputs = [];
  List<String> excludedLetters = [];
  List<Wordle> board = [];
  String targetWord = '';
  int count = 0;
  final lettersPerRow = 5;

  init() {
    totalWords = words.all.where((element) => element.length == 5).toList();
    generateBoard();
    generateRandomWord();
  }

  generateBoard() {
    board = List.generate(30, (index) => Wordle(letter: ''));
  }

  generateRandomWord() {
    targetWord = totalWords[random.nextInt(totalWords.length)].toUpperCase();
    print('The target word is: $targetWord');
  }

  inputLetter(String letter) {
    if (count < lettersPerRow) {
      rowInputs.add(letter);
      board[count] = Wordle(letter: letter);
      count++;
      print(rowInputs);
      notifyListeners();
    }
  }

  void deleteLetter() {
    if (rowInputs.isNotEmpty) {
      rowInputs.removeAt(rowInputs.length - 1);
      print(rowInputs);
    }
    if (count > 0) {
      board[count - 1] = Wordle(letter: '');
      count--;
    }
    notifyListeners();
  }

  bool get isValidWord => totalWords.contains(rowInputs.join('').toLowerCase());

  void checkWord() {}
}
