import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'e01S01001_item_table.g.dart';

@JsonSerializable()
@CopyWith()
class E01S01001ItemTable {
  final bool? isCheck;
  @JsonKey(name: 'Id')
  final String? patientCode;
  @JsonKey(name: 'StaffCode')
  final String? accountCode;
  @JsonKey(name: 'FullName')
  final String? accountName;
  @JsonKey(name: 'OrganizationName')
  final String? roleGroup;
  @JsonKey(name: 'JobPositionName')
  final String? department;
  @JsonKey(name: 'TrangThaiCongViec')
  final int? status;

  E01S01001ItemTable({
    this.isCheck = false,
    this.patientCode,
    this.accountCode,
    this.accountName,
    this.roleGroup,
    this.department,
    this.status,
  });

  factory E01S01001ItemTable.fromJson(Map<String, dynamic> json) {
    return _$E01S01001ItemTableFromJson(json);
  }

  Map<String, dynamic> toJson() => _$E01S01001ItemTableToJson(this);

  static List<E01S01001ItemTable> fromJsonArray(
    List<dynamic> jsonArray,
  ) {
    return jsonArray
        .map(
          (dynamic e) => E01S01001ItemTable.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }
}
