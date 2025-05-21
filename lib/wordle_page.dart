import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle_clone/helper_functions.dart';
import 'package:wordle_clone/keyboard_view.dart';
import 'package:wordle_clone/wordle_provider.dart';
import 'package:wordle_clone/wordle_view.dart';

class WordlePage extends StatefulWidget {
  const WordlePage({super.key});

  @override
  State<WordlePage> createState() => _WordlePageState();
}

class _WordlePageState extends State<WordlePage> {
  @override
  void didChangeDependencies() {
    Provider.of<WordleProvider>(context, listen: false).init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wordle Game"), centerTitle: true),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Consumer<WordleProvider>(
                  builder:
                      (context, provider, child) => GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                        ),
                        itemCount: provider.board.length,
                        itemBuilder: (context, index) {
                          final wordle = provider.board[index];
                          return WordleView(wordle: wordle);
                        },
                      ),
                ),
              ),
            ),
            Consumer<WordleProvider>(
              builder:
                  (context, provider, child) => KeyboardView(
                    excludedLetters: provider.excludedLetters,
                    onPress: (value) {
                      provider.inputLetter(value);
                    },
                  ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Consumer<WordleProvider>(
                builder:
                    (context, provider, child) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            provider.deleteLetter();
                          },
                          child: const Text('DELETE'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _checkInput(provider);
                          },
                          child: const Text('CHECK'),
                        ),
                      ],
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _checkInput(WordleProvider provider) {
    if (provider.isWholeRowFilled) {
      provider.checkWord();
      if (!provider.isValidWord) {
        showMessage(context, 'This word is not in my dictionary.');
      }
    } else {
      showMessage(context, 'Please fill the whole row.');
    }
    if (provider.isWinner) {
      showResult(
        context: context,
        title: 'Congratulations, you win!',
        body: 'You found the word ${provider.targetWord}',
        onQuit: () {
          Navigator.pop(context);
        },
        onPlayAgain: () {
          Navigator.pop(context);
          provider.reset();
        },
      );
    } else if (provider.doneTries) {
      showResult(
        context: context,
        title: 'You lost! :(',
        body: 'The word was ${provider.targetWord}',
        onQuit: () {
          Navigator.pop(context);
        },
        onPlayAgain: () {
          Navigator.pop(context);
          provider.reset();
        },
      );
    }
  }
}
