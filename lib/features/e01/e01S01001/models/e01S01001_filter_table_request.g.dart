// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'e01S01001_filter_table_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

E01S01001FilterTableRequest _$E01S01001FilterTableRequestFromJson(
        Map<String, dynamic> json) =>
    E01S01001FilterTableRequest(
      limit: (json['limit'] as num?)?.toInt(),
      page: (json['page'] as num?)?.toInt(),
      keyword: json['keyword'] as String?,
      hascount: json['hascount'] as bool?,
    );

Map<String, dynamic> _$E01S01001FilterTableRequestToJson(
        E01S01001FilterTableRequest instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'page': instance.page,
      'keyword': instance.keyword,
      'hascount': instance.hascount,
    };
