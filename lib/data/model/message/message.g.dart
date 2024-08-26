// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageImpl _$$MessageImplFromJson(Map<String, dynamic> json) =>
    _$MessageImpl(
      from: json['from'] as String?,
      to: json['to'] as String?,
      text: json['text'] as String?,
      status: (json['status'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$MessageImplToJson(_$MessageImpl instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'text': instance.text,
      'status': instance.status,
    };
