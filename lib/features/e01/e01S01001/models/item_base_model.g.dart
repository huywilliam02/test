// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_base_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemBaseModel _$ItemBaseModelFromJson(Map<String, dynamic> json) =>
    ItemBaseModel(
      id: (json['Id'] as num?)?.toInt(),
      name: json['Name'] as String?,
    );

Map<String, dynamic> _$ItemBaseModelToJson(ItemBaseModel instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
    };
