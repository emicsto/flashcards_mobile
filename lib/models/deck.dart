import 'package:json_annotation/json_annotation.dart';

part 'deck.g.dart';

@JsonSerializable()
class Deck {
  Deck({this.id, this.name, this.quantity});

  final String id;
  final String name;
  final int quantity;

  factory Deck.fromJson(Map<String, dynamic> json) => _$DeckFromJson(json);

  Map<String, dynamic> toJson() => _$DeckToJson(this);
}
