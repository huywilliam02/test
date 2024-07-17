import 'package:json_annotation/json_annotation.dart';

part 'e01S01001_filter_table_request.g.dart';

@JsonSerializable()
class E01S01001FilterTableRequest {
  int? limit;
  int? page;
  String? keyword;
  bool? hascount;

  E01S01001FilterTableRequest({
    this.limit,
    this.page,
    this.keyword,
    this.hascount,
  });

  Map<String, dynamic> toJson() => _$E01S01001FilterTableRequestToJson(this);
}
