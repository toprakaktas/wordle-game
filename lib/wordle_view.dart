import 'package:flutter/material.dart';
import 'package:wordle_clone/wordle.dart';

class WordleView extends StatelessWidget {
  final Wordle wordle;
  const WordleView({super.key, required this.wordle});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
            wordle.existsInTarget
                ? const Color(0xFFC9B458) // Yellow (wrong spot)
                : wordle.doesNotExistsInTarget
                ? const Color(0xFF787C7E) // Gray (not in word)
                : wordle.isCorrectSpot
                ? const Color(0xFF6AAA64) // Green (correct spot)
                : Colors.transparent, // Defa
        border: Border.all(
          color: Color.fromARGB(255, 64, 120, 103),
          width: 1.75,
        ),
      ),
      child: Text(
        wordle.letter,
        style: TextStyle(
          fontSize: 16,
          color: wordle.existsInTarget ? Colors.white70 : Colors.white,
        ),
      ),
    );
  }
}
