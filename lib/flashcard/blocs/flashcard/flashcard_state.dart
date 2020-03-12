import 'package:meta/meta.dart';

@immutable
abstract class FlashcardState {}

class FlashcardFront extends FlashcardState {}

class FlashcardBack extends FlashcardState {}
