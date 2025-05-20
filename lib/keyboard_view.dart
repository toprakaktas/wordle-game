import 'package:flutter/material.dart';
import 'package:wordle_clone/virtual_key.dart';

const keyList = [
  ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
  ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
  ['Z', 'X', 'C', 'V', 'B', 'N', 'M'],
];

class KeyboardView extends StatelessWidget {
  final List<String> excludedLetters;
  final Function(String) onPress;
  const KeyboardView({
    super.key,
    required this.excludedLetters,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          children: [
            for (int index = 0; index < keyList.length; index++)
              Row(
                spacing: 1.5,
                children:
                    keyList[index]
                        .map(
                          (e) => VirtualKey(
                            letter: e,
                            excluded: excludedLetters.contains(e),
                            onPress: (value) {
                              onPress(value);
                            },
                          ),
                        )
                        .toList(),
              ),
          ],
        ),
      ),
    );
  }
}
