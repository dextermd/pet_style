import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@freezed
class Message with _$Message {
    const factory Message({
        String? from,
        String? to,
        String? text,
        int? status,
    }) = _Message;

          factory Message.fromJson(Map<String, Object?> json)
      => _$MessageFromJson(json);
}
