class Wordle {
  String letter;
  bool existsInTarget;
  bool doesNotExistsInTarget;
  bool isCorrectSpot;

  Wordle({
    required this.letter,
    this.existsInTarget = false,
    this.doesNotExistsInTarget = false,
    this.isCorrectSpot = false,
  });
}
