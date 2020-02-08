import 'package:flip_card/flip_card.dart';

extension ExtendedFlipCardState on FlipCardState {
  void setFront() {
    setState(() {
      isFront = !isFront;
      controller.reverse(from: 0);
    });
  }
}