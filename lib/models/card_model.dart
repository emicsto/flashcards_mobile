import 'package:json_annotation/json_annotation.dart';

part 'card_model.g.dart';

@JsonSerializable()
class CardModel {
  CardModel(this.id, this.front, this.back);

  final String id;
  final String front;
  final String back;

  factory CardModel.fromJson(Map<String, dynamic> json) => _$CardModelFromJson(json);

  Map<String, dynamic> toJson() => _$CardModelToJson(this);
}
