// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_block_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppBlockInfoImpl _$$AppBlockInfoImplFromJson(Map<String, dynamic> json) =>
    _$AppBlockInfoImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      category: json['category'] as String,
      icon: json['icon'] as String,
      blocked: json['blocked'] as bool? ?? false,
    );

Map<String, dynamic> _$$AppBlockInfoImplToJson(_$AppBlockInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'icon': instance.icon,
      'blocked': instance.blocked,
    };
