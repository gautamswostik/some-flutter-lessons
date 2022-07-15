import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_model.g.dart';
part 'post_model.freezed.dart';

@freezed
class PostModel with _$PostModel {
  const factory PostModel({
    @Default(-1) int userId,
    @Default(-1) int id,
    @Default('') String title,
    @Default('') String body,
  }) = _PostModel;

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
}
