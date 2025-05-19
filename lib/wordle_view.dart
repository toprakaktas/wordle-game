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
                ? Colors.grey
                : wordle.doesNotExistsInTarget
                ? Colors.transparent
                : null,
        border: Border.all(
          color: Color.fromARGB(255, 64, 120, 103),
          width: 1.75,
        ),
      ),
      child: Text(
        wordle.letter,
        style: TextStyle(
          fontSize: 16,
          color:
              wordle.existsInTarget
                  ? Colors.black
                  : wordle.doesNotExistsInTarget
                  ? Colors.grey
                  : Colors.white,
        ),
      ),
    );
  }
}
