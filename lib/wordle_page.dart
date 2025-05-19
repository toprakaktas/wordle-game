import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
              child: Consumer<WordleProvider>(
                builder:
                    (context, provider, child) => GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                      ),
                      itemCount: provider.board.length,
                      itemBuilder: (context, index) {
                        final wordle = provider.board[index];
                        return WordleView(wordle: wordle);
                      },
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
