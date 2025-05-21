import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:english_words/english_words.dart' as words;
import 'package:wordle_clone/wordle.dart';

class WordleProvider extends ChangeNotifier {
  final random = Random.secure();
  final lettersPerRow = 5;
  final maxTries = 6;
  List<String> totalWords = [];
  List<String> rowInputs = [];
  List<String> excludedLetters = [];
  List<Wordle> board = [];
  String targetWord = '';
  int count = 0;
  int index = 0;
  int tries = 0;
  bool isWinner = false;

  bool get isValidWord => totalWords.contains(rowInputs.join('').toLowerCase());

  bool get isWholeRowFilled => rowInputs.length == lettersPerRow;

  bool get doneTries => tries == maxTries;

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
    if (kDebugMode) {
      print('The target word is: $targetWord');
    }
  }

  inputLetter(String letter) {
    if (count < lettersPerRow) {
      count++;
      rowInputs.add(letter);
      board[index] = Wordle(letter: letter);
      index++;
      notifyListeners();
    }
  }

  void deleteLetter() {
    if (rowInputs.isNotEmpty) {
      rowInputs.removeAt(rowInputs.length - 1);
    }
    if (count > 0) {
      board[index - 1] = Wordle(letter: '');
      count--;
      index--;
    }
    notifyListeners();
  }

  void checkWord() {
    _markLetter();

    final input = rowInputs.join('');
    if (targetWord == input) {
      isWinner = true;
    } else {
      _markLetter();
      if (tries < maxTries) {
        _goToNextRow();
      }
    }
  }

  void _markLetter() {
    final guess = rowInputs.map((e) => e.toUpperCase()).toList();
    final target = targetWord.toUpperCase().split('');
    final matched = List.filled(lettersPerRow, false);

    // Correct spot (Green color)
    for (int i = 0; i < lettersPerRow; i++) {
      final boardIndex = tries * lettersPerRow + i;
      if (guess[i] == target[i]) {
        board[boardIndex].isCorrectSpot = true;
        matched[i] = true;
      }
    }

    // Wrong spot (Yellow color) or not in word (Gray color)
    for (int i = 0; i < lettersPerRow; i++) {
      final boardIndex = tries * lettersPerRow + i;
      if (board[boardIndex].isCorrectSpot) continue;

      final letter = guess[i];
      bool foundElsewhere = false;

      for (int j = 0; j < lettersPerRow; j++) {
        if (!matched[j] && letter == target[j]) {
          matched[j] = true;
          foundElsewhere = true;
          break;
        }
      }

      if (foundElsewhere) {
        board[boardIndex].existsInTarget = true;
      } else {
        board[boardIndex].doesNotExistsInTarget = true;
        excludedLetters.add(letter);
      }
    }
    notifyListeners();
  }

  void _goToNextRow() {
    tries++;
    count = 0;
    rowInputs.clear();
  }

  reset() {
    count = 0;
    index = 0;
    rowInputs.clear();
    excludedLetters.clear();
    board.clear();
    targetWord = '';
    tries = 0;
    isWinner = false;
    generateBoard();
    generateRandomWord();
    notifyListeners();
  }
}
